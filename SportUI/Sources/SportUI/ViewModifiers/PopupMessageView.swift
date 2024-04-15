//
//  PopupMessageView.swift
//
//
//  Created by Vova Novosad on 17.03.2024.
//
//
//import SwiftUI
//
//public struct PopupMessageView: View {
//    @Binding var errorItem: ErrorItem?
//    let type: PopupMessageType
//    let message: String
//    @State var isActive = true
//    
//    public init(isPresented: Binding<ErrorItem?>, type: PopupMessageType, message: String) {
//        self._errorItem = isPresented
//        self.type = type
//        self.message = message
//    }
//    
//    public var body: some View {
//            if isActive {
//                HStack {
//                    type.image
//                        .padding(.trailing)
//                        .foregroundStyle(type == .failure ? .red : .green)
//                        .font(.system(size: 25))
//                    
//                    Text(message)
//                        .font(.sport.system(.body))
//                }
//                .padding()
//                .frame(maxWidth: .infinity)
//                .modifier(RoundedViewModifier(color: .white))
//                .padding([.horizontal, .top])
//                .zIndex(1)
//                .animation(.spring().delay(0.2), value: isActive)
//                .onAppear {
//                    withAnimation { isActive = true }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                        withAnimation { isActive = false }
//                    }
//                }
//                .onTapGesture {
//                    withAnimation { isActive = false }
//                }
//                .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
//            }
//            .animation(.spring, value: isActive)
//        }
//}
//
//
//
//
//#Preview {
//    VStack {
//        PopupMessageView(isPresented: .constant(true), type: .success, message: "Your operation was successfull!")
//    }
//}
