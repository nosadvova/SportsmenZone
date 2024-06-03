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
            VStack(spacing: 20) {
                Button {
                    viewModel.showNotificationScreen = true
                } label: {
                    Text("Create notification")
                        .font(.sport.system(.button))
                        .frame(width: 200)
                }
                .buttonStyle(RoundButtonStyle(backgroundColor: .green, foregroundStyle: .white))
                
                Divider()

                notificationList
                    .ignoresSafeArea(.all)
            }
        }
        .sheet(isPresented: $viewModel.showNotificationScreen) {
            CreateNotificationView()
                .environmentObject(viewModel)
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
                    UserRow(isInteractionAllowed: true, userImage: notification.type?.image, fullName: notification.title ?? "", info: notification.message ?? "") {
                        OptionButton(image: "trash", imageColor: .red, title: "Delete notification") {
                            viewModel.deleteNotification(id: notification.id ?? "")
                        }
                    }
                    .foregroundStyle(notification.type?.rawValue == "Major" ? .yellow : .green)
                    .modifier(RoundedViewModifier(color: .white))
                }
                .padding(.vertical, 2)
                .ignoresSafeArea(.all)
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    NotificationView()
}
