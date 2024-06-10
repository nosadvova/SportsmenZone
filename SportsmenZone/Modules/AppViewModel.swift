//
//  AppViewModel.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 25.04.2024.
//

import Foundation
import CacheProvider
import Models
import SportUI

@MainActor
class AppViewModel: ObservableObject {
    @Published var user: User?
    @Published var gym: Gym?
    @Published var notifications: [NotificationModel] = MockData().generateNotifications(10)
    @Published var requestLoadable: Loadable<Bool> = .notRequested
    
    private let cacheProvider: CacheProvider
    private let userAPI: UserAPI
    private let gymAPI: GymAPI
    private let notificationAPI: NotificationAPI
    private let globalDataStorage: GlobalDataStorage
    
    init(
        cacheProvider: CacheProvider = ServiceFacade.getService(CacheProvider.self),
        userAPI: UserAPI = RealUserAPI(),
        gymAPI: GymAPI = RealGymAPI(),
        notificationAPI: NotificationAPI = RealNotificationAPI(),
        globalDataStorage: GlobalDataStorage = GlobalDataStorage.shared
    ) {
        self.cacheProvider = cacheProvider
        self.userAPI = userAPI
        self.gymAPI = gymAPI
        self.notificationAPI = notificationAPI
        self.globalDataStorage = globalDataStorage
    }
    
    var fullName: String {
        if let fullName = user?.personalInformation?.fullName {
            return fullName
        }
        return ""
    }
    
    var gymImage: String {
        if let image = gym?.type?.first {
            return image.image
        }
        return "figure.run"
    }
    
    var isUserAuth: Bool {
        let authToken: SimplifiedAuthToken? = cacheProvider.getSensitiveValue(forKey: Constants.StorageKey.authToken)
        guard let authToken = authToken, authToken.isValid else {
            return false
        }
        return true
    }
    
    func getUser() {
        Task {
            requestLoadable.loading()
            if let user = await globalDataStorage.user {
                await globalDataStorage.setData(user: user)
                self.user = user
                return
            }
            
            do {
                let user = try await userAPI.getUser()
                self.user = user
                await globalDataStorage.setData(user: user)
                await globalDataStorage.setData(personalInformation: user.personalInformation)
                await getGym()
                requestLoadable = .loaded(true)
            } catch {
                print("Error fetching user: \(error)")
            }
        }
    }
    
    private func getGym() async {
        if let gym = await globalDataStorage.gym {
            self.gym = gym
            return
        }
        do {
            guard let gymID = await globalDataStorage.personalInformation?.gym else {
                self.gym = nil
                return
            }
            let gym = try await gymAPI.getGym(id: gymID)
            self.gym = gym
            await globalDataStorage.setData(gym: gym)
            await fetchNotifications()
        } catch {
            print("Error fetching gym: \(error)")
        }
    }
    
    private func fetchNotifications() async {
        do {
            requestLoadable.loading()
            let notificationResponse = try await notificationAPI.fetchNotifications()
            notificationResponse.forEach { notification in
                self.notifications.append(notification)
            }
            await globalDataStorage.setData(notifications: notifications)
        } catch {
            requestLoadable = .failed(error)
            let customError = error as! NetworkError
            print("Notification error: ", customError)
        }
    }
}
