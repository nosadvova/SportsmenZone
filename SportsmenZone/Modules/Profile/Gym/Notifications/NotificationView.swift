//
//  NotificationView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 24.05.2024.
//

import SwiftUI
import SportUI

struct NotificationView: View {
    @StateObject private var viewModel = NotificationViewModel()
    
    var body: some View {
        PrimaryScreenStyle(title: "Notifications", dismissButton: .back, backgroundColor: .black) {
            
        }
        .task {
            await viewModel.fetchNotifications()
        }
    }
}

private extension NotificationView {
    var notificationList: some View {
        ScrollView(.vertical) {
            ForEach(viewModel.notifications) { notification in
                UserRow(isInteractionAllowed: false, fullName: notification.title ?? "", info: notification.message ?? "") {
                    //
                }
                .modifier(RoundedViewModifier(color: .white))
            }
        }
    }
}

#Preview {
        NotificationView()
}
