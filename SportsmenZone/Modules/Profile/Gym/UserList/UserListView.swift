//
//  UserListView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 08.03.2024.
//

import SwiftUI
import SportUI
import SportExtensions
import Models

struct UserListView: View {
    @StateObject var viewModel: GymViewModel
    
    var body: some View {
        PrimaryScreenStyle(title: S.ChooseUser.sportsmen, description: "", dismissButton: .back) {
            VStack {
                ForEach(viewModel.sportsmen) { user in
                    UserRow(
                        isInteractionAllowed: true,
                        userImage: user.userImage,
                        fullName: user.fullName,
                        info: user.email ?? "")
                    {
                        OptionButton(image: "trash.fill", imageColor: .red, title: "Delete user") {
                            print("User deleted")
                        }
                        
                        Divider()
                        
                        OptionButton(image: "pencil.line", imageColor: .yellow, title: "Change user") {
                            //
                        }
                        
                        Divider()
                        
                        OptionButton(image: "person.crop.circle", imageColor: .oliveColor, title: "Visit user profile") {
                            //
                        }
                        .padding(.bottom, 5)
                    }
                }
            }
        }
    }
}

struct OptionButton: View {
    private var image: String
    private var imageColor: Color
    private var title: String
    private var action: () -> ()
    
    init(image: String, imageColor: Color, title: String, action: @escaping () -> ()) {
        self.image = image
        self.imageColor = imageColor
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 20) {
                Image(systemName: image)
                    .resizable()
                    .frame(width: 13, height: 13)
                    .foregroundStyle(imageColor)
                
                Text(title)
                    .font(.sport.system(.caption))
                    .foregroundStyle(Color.mainTextColor)
            }
            .padding(.vertical, 5)
        }
        
    }
}

#Preview {
    UserListView(viewModel: GymViewModel())
}
