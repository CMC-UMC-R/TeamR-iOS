//
//  DistanceTrackingManager.swift
//  CMC-UMC-R
//
//  Created by Codex on 11/22/25.
//

import Foundation
import CoreMotion
import Combine

@MainActor
final class DistanceTrackingManager: ObservableObject {
    static let shared = DistanceTrackingManager()
    
    enum TrackingState: Equatable {
        case idle
        case running(startDate: Date)
        case unavailable(message: String)
        case failed(message: String)
    }

    enum MissionScenario: String, Equatable {
        case background
        case live
        case appEntry

        var description: String {
            switch self {
            case .background:
                return "백그라운드"
            case .live:
                return "실시간"
            case .appEntry:
                return "앱 진입"
            }
        }
    }

    struct MissionResult: Equatable {
        let scenario: MissionScenario
        let startDate: Date
        let endDate: Date
        let steps: Int
        let distance: Measurement<UnitLength>
        let targetSteps: Int

        var isCompleted: Bool { steps >= targetSteps }
    }

    enum MissionEvaluationState: Equatable {
        case idle
        case evaluating(MissionScenario)
        case completed(MissionResult)
        case failed(String)
    }

    @Published private(set) var trackingState: TrackingState = .idle
    @Published private(set) var distance: Measurement<UnitLength> = .init(value: 0, unit: .meters)
    @Published private(set) var steps: Int = 0
    @Published private(set) var lastUpdate: Date?
    @Published var missionStartDate: Date = Date()
    @Published var missionEndDate: Date = Date()
    @Published var missionTargetSteps: Int = 1000
    @Published private(set) var missionEvaluationState: MissionEvaluationState = .idle

    private let pedometer = CMPedometer()
    private let historicalPedometer = CMPedometer()
    private let measurementFormatter: MeasurementFormatter

    private var currentMissionTarget: Int?
    private var currentMissionScenario: MissionScenario?
    private var currentLiveStartDate: Date?

    private init() {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .naturalScale
        formatter.unitStyle = .medium
        formatter.locale = .current
        self.measurementFormatter = formatter
        missionEndDate = missionStartDate.addingTimeInterval(60 * 30)
    }

    var formattedDistance: String {
        measurementFormatter.string(from: distance)
    }

    var isTracking: Bool {
        if case .running = trackingState {
            return true
        }
        return false
    }

    func startTrackingFromNow() {
        startTracking(from: Date())
    }

    func startLiveMissionFromConfiguredTime() {
        startTracking(from: missionStartDate, missionTarget: missionTargetSteps, scenario: .live)
    }

    func startMissionAfterAppEntry() {
        startTracking(from: Date(), missionTarget: missionTargetSteps, scenario: .appEntry)
    }

//    func evaluateMissionInBackground() {
//        evaluateMissionHistory(
//            endDate: missionEndDate,
//            targetSteps: missionTargetSteps
//        )
//    }

    func startTracking(from date: Date, missionTarget: Int? = nil, scenario: MissionScenario? = nil) {
        guard CMPedometer.authorizationStatus() != .denied else {
            trackingState = .failed(message: "Pedometer access denied in Settings.")
            missionEvaluationState = .failed("설정에서 걸음수 권한을 허용해주세요.")
            return
        }

        guard CMPedometer.isStepCountingAvailable(), CMPedometer.isDistanceAvailable() else {
            trackingState = .unavailable(message: "Step counting or distance data is not available on this device.")
            missionEvaluationState = .failed("해당 기기에서 걸음수 데이터를 제공하지 않습니다.")
            return
        }

        pedometer.stopUpdates()
        distance = .init(value: 0, unit: .meters)
        steps = 0
        lastUpdate = nil
        trackingState = .running(startDate: date)
        currentMissionTarget = missionTarget
        currentMissionScenario = scenario
        currentLiveStartDate = date
        if let scenario {
            missionEvaluationState = .evaluating(scenario)
        } else {
            missionEvaluationState = .idle
        }

        pedometer.startUpdates(from: date) { [weak self] data, error in
            guard let self else { return }

            DispatchQueue.main.async {
                if let error = error {
                    self.trackingState = .failed(message: error.localizedDescription)
                    self.missionEvaluationState = .failed(error.localizedDescription)
                    return
                }

                guard let data else { return }
                if let meters = data.distance?.doubleValue {
                    self.distance = Measurement(value: meters, unit: .meters)
                }
                self.steps = data.numberOfSteps.intValue
                self.lastUpdate = Date()

                if let target = self.currentMissionTarget,
                   let scenario = self.currentMissionScenario,
                   let startDate = self.currentLiveStartDate,
                   self.steps >= target {
                    self.pedometer.stopUpdates()
                    
                    // 여기서 미션 완료
                    
                    self.trackingState = .idle
                    let result = MissionResult(
                        scenario: scenario,
                        startDate: startDate,
                        endDate: Date(),
                        steps: self.steps,
                        distance: self.distance,
                        targetSteps: target
                    )
                    self.missionEvaluationState = .completed(result)
                    self.currentMissionTarget = nil
                    self.currentMissionScenario = nil
                    self.currentLiveStartDate = nil
                }
            }
        }
    }

    func evaluateMissionHistory(endDate: Date, targetSteps: Int) async -> Bool {
        let startDate = dateToday(hour: 0, minute: 0)
        
        // 권한 확인
        if CMPedometer.authorizationStatus() == .denied {
            print("걸음수 권한이 거부됨. 설정에서 권한을 허용해주세요.")
            return false
        }
        
        // 기기 지원 여부 확인
        guard CMPedometer.isStepCountingAvailable(),
              CMPedometer.isDistanceAvailable() else {
            print("해당 기기에서는 걸음수/거리 데이터를 제공하지 않음.")
            return false
        }
        
        // 시각 유효성 확인
        guard startDate <= endDate else {
            print("시작 시각이 종료 시각보다 늦음.")
            return false
        }
        
        // pedometer 데이터 조회
        do {
            let data: CMPedometerData = try await withCheckedThrowingContinuation { continuation in
                historicalPedometer.queryPedometerData(from: startDate, to: endDate) { data, error in
                    
                    if let error {
                        continuation.resume(throwing: error)
                    } else if let data {
                        continuation.resume(returning: data)
                    } else {
                        continuation.resume(throwing: NSError(domain: "PedometerError", code: -1))
                    }
                }
            }
            
            let steps = data.numberOfSteps.intValue
            let meters = data.distance?.doubleValue ?? 0
            
            if steps >= targetSteps {
                return true
            } else {
                print("목표 걸음수 미달 (\(steps)/\(targetSteps))")
                return false
            }
            
        } catch {
            print("걸음수 데이터를 가져오는 중 오류 발생 → \(error.localizedDescription)")
            return false
        }
    }


    func stopTracking() {
        pedometer.stopUpdates()
        trackingState = .idle
        currentMissionTarget = nil
        currentMissionScenario = nil
        currentLiveStartDate = nil
    }
    
    func dateToday(hour: Int, minute: Int = 0, second: Int = 0) -> Date {
        let now = Date()
        let calendar = Calendar.current

        return calendar.date(
            bySettingHour: hour,
            minute: minute,
            second: second,
            of: now
        )!
    }
}
