//
//  CoreMotionManager.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation
import CoreMotion

// MARK: - Delegate Protocol

/// CoreMotionManager의 흔들림 감지 결과를 전달하는 프로토콜
protocol CoreMotionManagerDelegate: AnyObject {
    /// 흔들림이 감지되었을 때 호출
    func didDetectShake()
}

// MARK: - CoreMotionManager

/// CoreMotion 프레임워크를 관리하는 싱글톤 매니저
final class CoreMotionManager {
    
    // MARK: - Singleton
    
    static let shared = CoreMotionManager()
    
    // MARK: - Properties
    
    /// 흔들림 감지 결과를 받을 delegate
    weak var delegate: CoreMotionManagerDelegate?
    
    /// CoreMotion 매니저
    private let motionManager = CMMotionManager()
    
    /// 강한 흔들림 감지를 위한 임계값 (값이 클수록 강한 흔들림만 감지)
    private let shakeThreshold: Double = 2.5
    
    /// 중복 감지 방지를 위한 최소 시간 간격 (초)
    private let debounceDuration: TimeInterval = 0.3
    
    /// 마지막 흔들림 감지 시간
    private var lastShakeTime: Date = .distantPast
    
    /// 감지 활성화 여부
    private(set) var isDetecting: Bool = false
    
    // MARK: - Initializer
    
    private init() {
        print("🔧 CoreMotionManager 초기화")
    }
    
    // MARK: - Public Methods
    
    /// 흔들기 감지 시작
    func startDetecting() {
        guard !isDetecting else {
            print("⚠️ 이미 감지가 진행 중입니다.")
            return
        }
        
        guard motionManager.isAccelerometerAvailable else {
            print("⚠️ 가속도계를 사용할 수 없습니다.")
            return
        }
        
        lastShakeTime = .distantPast
        
        // 가속도계 업데이트 주기 설정 (0.1초)
        motionManager.accelerometerUpdateInterval = 0.1
        
        // 가속도계 데이터 수신 시작
        motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, error in
            guard let self = self, let data = data else { return }
            
            if let error = error {
                print("❌ 가속도계 에러: \(error.localizedDescription)")
                return
            }
            
            self.processAccelerometerData(data)
        }
        
        isDetecting = true
        print("✅ 흔들기 감지 시작")
    }
    
    /// 흔들기 감지 중지
    func stopDetecting() {
        guard isDetecting else {
            print("⚠️ 감지가 진행 중이지 않습니다.")
            return
        }
        
        motionManager.stopAccelerometerUpdates()
        isDetecting = false
        lastShakeTime = .distantPast
        print("🛑 흔들기 감지 중지")
    }
    
    // MARK: - Private Methods
    
    /// 가속도계 데이터 처리
    private func processAccelerometerData(_ data: CMAccelerometerData) {
        let acceleration = data.acceleration
        
        // 가속도 벡터의 크기 계산
        let magnitude = sqrt(
            pow(acceleration.x, 2) +
            pow(acceleration.y, 2) +
            pow(acceleration.z, 2)
        )
        
        // 중력 가속도(1G) 제거
        let netAcceleration = abs(magnitude - 1.0)
        
        // 강한 흔들림 감지
        if netAcceleration > shakeThreshold {
            detectShake()
        }
    }
    
    /// 흔들림 감지 및 delegate 호출
    private func detectShake() {
        let now = Date()
        let timeSinceLastShake = now.timeIntervalSince(lastShakeTime)
        
        // 디바운싱: 최소 시간 간격 이내의 연속 감지는 무시
        guard timeSinceLastShake >= debounceDuration else { return }
        
        lastShakeTime = now
        
        print("📱 흔들림 감지!")
        
        // delegate에게 흔들림 감지 알림
        delegate?.didDetectShake()
    }
    
    // MARK: - Deinit
    
    deinit {
        stopDetecting()
        print("🗑️ CoreMotionManager 해제")
    }
}
