//
//  TrainingView.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 13.03.2024.
//

import SwiftUI
import SportUI
import Models

struct TrainingView: View {
    @StateObject var viewModel: TrainingViewModel
    @State var isChanged = false
    @State var showMessage = false
    
    var body: some View {
        if let training = viewModel.training {
            PrimaryScreenStyle(title: "Training", dismissButton: .close, backgroundColor: .white) {
                VStack(spacing: 30) {
                    VStack {
                        trainingDayMenu
                        
                        Divider()
                            .padding(.horizontal, 10)
                        
                        timeField("Time", text: training.time.trainingTime())
                            .onTapGesture {
                                print("Tap time")
                            }
                        
                        Divider()
                            .padding(.horizontal, 10)
                        
                        timeField("Duration", text: "\(training.duration) hours")
                            .onTapGesture {
                                print("Tap duration")
                            }
                    }
                    .disabled(!viewModel.isOwner)
                    .modifier(RoundedViewModifier(title: "Date and time:", color: .white))
                    
                    if viewModel.isOwner {
                        editableTextField("Name", text: $viewModel.name)
                        editableTextField("Comment", text: $viewModel.commentary)
                        Button(action: {
                            viewModel.saveTraining()
                            showMessage = true
                            isChanged = false
                        }, label: {
                            Text(S.save)
                                .frame(width: 200)
                        })
                        .buttonStyle(RoundButtonStyle(backgroundColor: .green, foregroundStyle: .white))
                        .disabled(!isChanged)
                    } else {
                        staticText("Name", text: training.name)
                        staticText("Comment", text: training.commentary)
                    }
                }
            }
            .modifier(PopupMessageViewModifier(isPresented: $showMessage, type: .success, message: "Information saved successfully"))
        }
    }
}

//MARK: - Custom menu
private extension TrainingView {
    var trainingDayMenu: some View {
        HStack {
            Menu {
                ScrollView {
                    VStack {
                        ForEach(TrainingDay.allCases, id: \.self) { trainingDay in
                            Button(action: {
                                viewModel.trainingDay = trainingDay
                            }) {
                                HStack {
                                    if viewModel.trainingDay == trainingDay {
                                        Image(systemName: "checkmark")
                                    }
                                    Text(trainingDay.displayName)
                                }
                            }
                        }
                    }
                }
            } label: {
                timeField("Day of the week", text: viewModel.trainingDayLabel)
            }
        }
        .foregroundStyle(.black)
        .font(.sport.system(.button))
        .padding(.horizontal, 5)
    }
}

//MARK: - TextFields
private extension TrainingView {
    func timeField(_ title: String, text: String) -> some View {
        HStack {
            Text(title)
                .font(.sport.system(.body).bold())
            
            Spacer()
            
            Text(text)
                .font(.sport.system(.body))
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                .frame(alignment: .center)
                .modifier(RoundedViewModifier(color: .oliveColor, opacity: 0.35))
        }
        .padding(10)
    }
    
    func editableTextField(_ title: String, text: Binding<String>) -> some View {
        TextField(title, text: text, axis: .vertical)
            .padding()
            .font(.sport.system(.body))
            .frame(maxWidth: .infinity, alignment: .leading)
            .modifier(RoundedViewModifier(title: "\(title):", color: .white))
            .onChange(of: text.wrappedValue) { oldValue, newValue in
                isChanged = newValue != oldValue ? true : false
            }
    }
    
    func staticText(_ title: String, text: String) -> some View {
        Text(text)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .modifier(RoundedViewModifier(title: "\(title):", color: .white))
            .font(.sport.system(.body))
            .lineLimit(nil)
    }
}

#Preview {
    TrainingView(viewModel: TrainingViewModel(training: MockData.training1, isOwner: true))
}
