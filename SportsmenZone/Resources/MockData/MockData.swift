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
    static let user1 = User(id: "91", firstName: "Abham", lastName: "Dulabi", email: "abham1@gmail.com", userType: .sportsmen)
    static let user2 = User(id: "43", firstName: "Abrtryt", lastName: "Dulabi", email: "abham2@gmail.com", userType: .sportsmen)
    static let user3 = User(id: "57", firstName: "Vinard", lastName: "Limpare", email: "abham2@gmail.com", userType: .sportsmen)
    static let user4 = User(id: "12", firstName: "Elferik", lastName: "Nabari", email: "abham2@gmail.com", userType: .trainer)
    static let user5 = User(id: "10", firstName: "adfdffd", lastName: "ASDweweiwoi", email: "abham2@gmail.com", userType: .trainer)
    static let user6 = User(id: "11", firstName: "Absurd", lastName: "ASDweweiwoi", email: "abham2@gmail.com", userType: .trainer)
    
    static let users = [user1, user2, user3, user4, user5]
    
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
                        
            let user = User(id: id, firstName: firstName, lastName: lastName, email: email, userType: .sportsmen)
            
            users.append(user)
        }
        
        return users
    }
    
    func getRandString(strArr: [String]) -> String {
        let element = Int.random(in: 0..<strArr.count)
        
        return strArr[element]
    }
}

//MARK: - Trainings
extension MockData {
    static let training1 = Training(id: "1", name: "Practice punches", trainingDay: .monday, duration: 2, time: .now, commentary: "Everyone have to be present but this one will be longer due to frame width")
    static let training2 = Training(id: "2", name: "Practice kicks", trainingDay: .wednesday, duration: 2, time: .now, commentary: "Everyone have to be present")
    static let training3 = Training(id: "3", name: "Practice throws", trainingDay: .friday, duration: 2, time: .now, commentary: "Everyone have to be present")
    
    static let trainings = [training1, training2, training3]
}
