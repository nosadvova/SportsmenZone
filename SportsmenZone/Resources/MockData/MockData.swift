//
//  MockData.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 07.03.2024.
//

import Foundation
import Models

//MARK: - Users
struct MockData {
    static let user1 = User(id: "91", personalInformation: PersonalInformation(firstName: "Abham", lastName: "Dulabi", email: "abham1@gmail.com", userType: .Sportsman))
    static let user2 = User(id: "43", personalInformation: PersonalInformation(firstName: "Abrtryt", lastName: "Dulabi", email: "abham2@gmail.com", userType: .Sportsman))
    static let user3 = User(id: "57", personalInformation: PersonalInformation(firstName: "Vinard", lastName: "Limpare", email: "abham2@gmail.com", userType: .Sportsman))
    static let user4 = User(id: "12", personalInformation: PersonalInformation(firstName: "Elferik", lastName: "Nabari", email: "abham2@gmail.com", userType: .Trainer))
    static let user5 = User(id: "10", personalInformation: PersonalInformation(firstName: "adfdffd", lastName: "ASDweweiwoi", email: "abham2@gmail.com", userType: .Trainer))
    static let user6 = User(id: "11", personalInformation: PersonalInformation(firstName: "Absurd", lastName: "ASDweweiwoi", email: "abham2@gmail.com", userType: .Trainer))
    
    static let users = [user1, user2, user3, user4, user5]
    
    static let gym1 = Gym(id: "1112", name: "Mock Gym", description: "Text Mock data gym", trainerID: "10")
    
    func generateUsers(_ amount: Int) -> [User] {
        var users: [User] = []
        
        for _ in 0..<amount {
            let id = UUID().uuidString
            
            let firstNames = ["Abham", "Linkoln", "Fheri", "Denis", "Kyle", "Sabrina", "Kelly", "Ananas"]
            let firstName = getRandString(strArr: firstNames)
            
            let lastNames = ["Ren", "Unhetik", "Vilnew", "Grabol", "Cylen", "Ayeuwn", "Banana"]
            let lastName = getRandString(strArr: lastNames)
            
            let emails = ["Ren@gmail.com", "Unhetik@gmail.com", "Vilnew@gmail.com", "Grabol@gmail.com", "Cylen@gmail.com", "Ayeuwn@gmail.com", "Banana@gmail.com"]
            let email = getRandString(strArr: emails)
                        
            let user = User(id: id, personalInformation: PersonalInformation(firstName: firstName, lastName: lastName, email: email, userType: .Sportsman))
            
            users.append(user)
        }
        
        return users
    }
    
    func generateNotifications(_ amount: Int) -> [NotificationModel] {
        var notifications: [NotificationModel] = []
        
        for _ in 0..<amount {
            let id = UUID().uuidString
            
            let titles = [
                "New Training Session Announced",
                "Upcoming Sports Event",
                "Updated Gym Schedule",
                "Special Workshop on Nutrition",
                "One-on-One Training Slots Available",
                "New Trainer Introduction",
                "Gym Maintenance Notice",
                "Monthly Fitness Challenge",
                "Personal Best Achievements",
                "Important Safety Measures"
            ]

            let title = getRandString(strArr: titles)
            
            let descriptions = [
                "Join us for a new training session this Friday at 6 PM. Don't miss it!",
                "We have an exciting sports event coming up next week. Register now to participate and showcase your skills.",
                "Please check the updated gym schedule for this month. We've added new sessions and adjusted the timings for some classes.",
                "Attend our special workshop on nutrition and learn how to optimize your diet for better performance. Limited seats available.",
                "Take advantage of our one-on-one training sessions with your favorite trainers. Book your slot today!",
                "We are excited to introduce a new trainer to our team. Meet Coach Alex in our next session and get to know their training style.",
                "Please be aware that the gym will be closed for maintenance this weekend. We apologize for any inconvenience caused.",
                "Participate in our monthly fitness challenge and stand a chance to win exciting prizes. Challenge yourself and stay motivated!",
                "Congratulations to all members who achieved their personal bests this month. Keep up the great work and continue pushing your limits.",
                "Please adhere to the updated safety measures and guidelines to ensure a safe and healthy environment for everyone."
            ]            
            let description = getRandString(strArr: descriptions)
            
            let types: [NotificationType] = [.Major, .Minor]
            let type = types.randomElement()
                        
            let notification = NotificationModel(id: id, title: title, message: description, type: type)
            
            notifications.append(notification)
        }
        
        return notifications
    }
    
    func getRandString(strArr: [String]) -> String {
        let element = Int.random(in: 0..<strArr.count)
        
        return strArr[element]
    }
}

//MARK: - Trainings
extension MockData {
    static let training1 = Training(id: "1", name: "Practice punches", trainingDay: .Monday, duration: 2, time: .now, commentary: "Everyone have to be present but this one will be longer due to frame width")
    static let training2 = Training(id: "2", name: "Practice kicks", trainingDay: .Wednesday, duration: 2, time: .now, commentary: "Everyone have to be present")
    static let training3 = Training(id: "3", name: "Practice throws", trainingDay: .Friday, duration: 2, time: .now, commentary: "Everyone have to be present")
    
    static let trainings = [training1, training2, training3]
}
