//
//  NotificationView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 24.05.2024.
//

import SwiftUI
import SportUI
import Models

struct NotificationView: View {
    @StateObject var viewModel = NotificationViewModel()
    
    var body: some View {
        PrimaryScreenStyle(title: "Notifications", dismissButton: .back, backgroundColor: .white) {
            notificationList
                .ignoresSafeArea(.all)
        }
        .task {
            await viewModel.fetchNotifications()
        }
    }
}

private extension NotificationView {
    var notificationList: some View {
        List {
            if let notifications = viewModel.notifications {
                ForEach(notifications) { notification in
                    UserRow(isInteractionAllowed: false, userImage: notification.type?.image, fullName: notification.title ?? "", info: notification.message ?? "") {
                        //
                    }
                    .foregroundStyle(notification.type?.rawValue == "Major" ? .yellow : .green)
                    .modifier(RoundedViewModifier(color: .white))
                }
                .padding(.vertical, 10)
                .ignoresSafeArea(.all)
                .listRowSeparator(.hidden)
//                .onDelete(perform: viewModel.deleteNotification)
            }
        }
        .listStyle(.plain)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    NotificationView()
}
