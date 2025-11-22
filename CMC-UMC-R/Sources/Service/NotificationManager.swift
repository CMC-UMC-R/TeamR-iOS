//
//  NotificationManager.swift
//  CMC-UMC-R
//
//  Created by Codex on 11/22/25.
//

import Foundation
import UserNotifications

/// 관리형 싱글턴으로 로컬 푸시 스케줄링을 캡슐화합니다.
@MainActor
final class NotificationManager: NSObject {
    static let shared = NotificationManager()

    private let notificationCenter = UNUserNotificationCenter.current()
    
    private override init() {
        super.init()
        notificationCenter.delegate = self   // ← 여기서 delegate 연결
    }

    /// 알림 권한을 요청합니다. 두 번째 호출부터는 시스템이 자동으로 기존 상태를 반환합니다.
    @discardableResult
    func requestAuthorization() async -> Bool {
        do {
            return try await notificationCenter.requestAuthorization(options: [.alert, .sound, .badge])
        } catch {
            return false
        }
    }

    /// 특정 날짜/시간에 한 번 울리는 미션 알림을 등록합니다.
    /// - Parameters:
    ///   - date: 알림을 보낼 실시간 Date (예: 2025-11-23 10:10)
    ///   - title: 알림 타이틀
    ///   - body: 알림 본문
    ///   - identifier: 식별자. 기본값은 자동 생성되지만, 동일 식별자를 넘기면 기존 알림을 덮어쓸 수 있습니다.
    func scheduleMissionNotification(
        at date: Date,
        title: String,
        body: String,
        identifier: String = UUID().uuidString
    ) async throws -> String {
        let authorized = await requestAuthorization()
        guard authorized else {
            throw NotificationError.authorizationDenied
        }

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        var components = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: date
        )
        // 초 단위 미지정 시 정확한 분 단위 트리거를 위해 0으로 보정
        if components.second == nil { components.second = 0 }

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        try await notificationCenter.add(request)
        return identifier
    }

    /// 기존 알림을 식별자로 취소합니다.
    func cancelNotification(identifier: String) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
    }

    enum NotificationError: LocalizedError {
        case authorizationDenied

        var errorDescription: String? {
            switch self {
            case .authorizationDenied:
                return "알림 권한이 거부되어 푸시를 예약할 수 없습니다."
            }
        }
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {

    // foreground에서도 배너 + 소리 나오도록
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound, .list])
    }

    // 사용자가 알림 눌렀을 때 처리(원하면)
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        completionHandler()
    }
}
