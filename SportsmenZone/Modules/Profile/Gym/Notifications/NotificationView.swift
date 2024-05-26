//
//  NotificationView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 24.05.2024.
//

import SwiftUI
import SportUI

struct NotificationView: View {
    var body: some View {
        PrimaryScreenStyle(title: "Notifications", dismissButton: .back, backgroundColor: .black) {
            
        }
    }
}

private extension NotificationView {
//    var notificationList: some View {
//        ScrollView(.vertical) {
//            ForEach() { notification in
//                UserRow(isInteractionAllowed: false, fullName: "Notification 1", info: "New notification") {
//                    //
//                }
//                .modifier(RoundedViewModifier(color: .white))
//            }
//        }
//    }
}

#Preview {
        NotificationView()
}
