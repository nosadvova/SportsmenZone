//
//  CreateNotificationView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 01.06.2024.
//

import SwiftUI
import SportUI
import Models

struct CreateNotificationView: View {
    @EnvironmentObject var viewModel: NotificationViewModel
    
    var body: some View {
        PrimaryScreenStyle(title: "Create notification", dismissButton: .close, backgroundColor: .white) {
            VStack(spacing: 20) {
                roundedTextField("Title", showTitle: true, text: $viewModel.title)
                roundedTextField("Message", showTitle: true, text: $viewModel.message)
                
                notificationType
                    .padding()
                    .modifier(RoundedViewModifier(color: .white))
                
                Spacer()
                
                Button {
                    viewModel.createNotification(notification: NotificationModel(gymID: viewModel.gym?.id, trainerID: viewModel.user?.id, title: viewModel.title, message: viewModel.message, type: viewModel.type))
                } label: {
                    Text("Save notification")
                }
                .buttonStyle(RoundButtonStyle(backgroundColor: .green, foregroundStyle: .white))

            }
        }
    }
}

extension CreateNotificationView {
    var notificationType: some View {
        HStack {
            Menu {
                ScrollView {
                    VStack {
                        ForEach(NotificationType.allCases, id: \.self) { type in
                            Button(action: {
                                viewModel.type = type
                            }) {
                                HStack {
                                    if viewModel.type == type {
                                        Image(systemName: "checkmark")
                                    }
                                    Image(systemName: type.image)
                                    Text(type.displayName)
                                }
                            }
                        }
                    }
                }
            } label: {
                Label {
                    Text(viewModel.notificationTypeLabel)
                        .padding(.leading, 15)
                } icon: {
                    Image(systemName: "chevron.down.circle")
                        .imageScale(.medium)
                        .padding(.bottom, 5)
                }
            }
            
            Spacer()
        }
        .foregroundStyle(.black)
        .font(.sport.system(.button))
        .padding(.horizontal, 5)
    }
    
    func roundedTextField(_ title: String, showTitle: Bool = false, text: Binding<String>) -> some View {
        DefaultTextField(text: text, placeholder: title)
            .padding()
            .modifier(RoundedViewModifier(title: showTitle ? "\(title):" : "", color: .white))
    }
}

#Preview {
    CreateNotificationView()
}
