//
//  CoreMotionViewModel.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation
import Combine

/// 흔들기 미션의 상태를 관리하는 ViewModel
final class CoreMotionViewModel: ObservableObject {
    
    /// 현재 흔들기 카운트
    @Published private(set) var shakeCount: Int = 0
    
    /// 감지 활성화 여부
    @Published private(set) var isDetecting: Bool = false
    
    /// 미션 완료 여부
    @Published private(set) var isMissionCompleted: Bool = false
    
    // MARK: - Private Properties
    
    /// CoreMotion 싱글톤 매니저
    private let motionManager = CoreMotionManager.shared
    
    /// 목표 횟수
    private let targetCount: Int
    
    /// 완료 시 실행될 콜백
    private var onComplete: (() -> Void)?
    
    // MARK: - Initializer
    
    /// ViewModel 초기화
    /// - Parameter targetCount: 목표 흔들기 횟수
    init(targetCount: Int) {
        self.targetCount = targetCount
        
        // delegate 설정
        motionManager.delegate = self
        
        print("🔧 CoreMotionViewModel 초기화 (목표: \(targetCount)회)")
    }
    
    // MARK: - Public Methods
    
    /// 미션 시작
    /// - Parameter onComplete: 목표 달성 시 실행될 콜백
    func startMission(onComplete: @escaping () -> Void) {
        guard !isDetecting else {
            print("⚠️ 이미 미션이 진행 중입니다.")
            return
        }
        
        self.onComplete = onComplete
        resetCount()
        
        motionManager.startDetecting()
        isDetecting = true
        
        print("✅ 미션 시작 (목표: \(targetCount)회)")
    }
    
    /// 미션 중지
    func stopMission() {
        guard isDetecting else {
            print("⚠️ 진행 중인 미션이 없습니다.")
            return
        }
        
        motionManager.stopDetecting()
        isDetecting = false
        
        print("🛑 미션 중지")
    }
    
    /// 카운트 및 상태 초기화
    func resetCount() {
        shakeCount = 0
        isMissionCompleted = false
        
        print("🔄 카운트 초기화")
    }
    
    // MARK: - Private Methods
    
    /// 미션 완료 처리
    private func handleMissionComplete() {
        isMissionCompleted = true
        
        // 목표 달성 시 자동으로 감지 중지
        stopMission()
        
        print("🎉 미션 완료! (\(targetCount)회)")
        
        // 완료 콜백 실행
        onComplete?()
        
        // API 호출
        sendMissionResultToServer()
    }
    
    /// 서버로 미션 결과 전송 (구현 필요)
    private func sendMissionResultToServer() {
        // TODO: 서버 API 호출 로직 추가
        print("📡 서버로 미션 결과 전송 (구현 예정)")
    }
    
    // MARK: - Deinit
    
    deinit {
        stopMission()
        motionManager.delegate = nil
        print("🗑️ CoreMotionViewModel 해제")
    }
    
    func waitUntilCompleted() async -> Bool {
        // 이미 완료되어 있으면 즉시 true
        if isMissionCompleted { return true }
        
        // "흔들기 완료"가 될 때까지 기다리는 Continuation
        return await withCheckedContinuation { continuation in
            // onComplete 콜백을 교체해서 true 반환
            self.onComplete = {
                continuation.resume(returning: true)
            }
        }
    }
}

// MARK: - CoreMotionManagerDelegate

extension CoreMotionViewModel: CoreMotionManagerDelegate {
    
    /// 흔들림 감지 시 호출되는 delegate 메서드
    func didDetectShake() {
        // 미션이 이미 완료되었으면 무시
        guard !isMissionCompleted else { return }
        
        shakeCount += 1
        
        print("📱 흔들림 감지! 현재 카운트: \(shakeCount)/\(targetCount)")
        
        // 목표 달성 체크
        if shakeCount >= targetCount {
            handleMissionComplete()
        }
    }
}
