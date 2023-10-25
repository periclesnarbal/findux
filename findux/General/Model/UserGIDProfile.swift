//
//  UserGIDProfile.swift
//  findux
//
//  Created by Péricles Narbal on 24/10/23.
//

import Foundation
import GoogleSignIn

class UserGIDProfile {
    var email: String?
    var fullName: String?
    var givenName: String?
    var familyName: String?
    var profilePicUrl: URL?
    
    static let shared = UserGIDProfile()
    
    init() {
        let user = GIDSignIn.sharedInstance.currentUser
        email = user?.profile?.email
        fullName = user?.profile?.name
        givenName = user?.profile?.givenName
        familyName = user?.profile?.familyName
        profilePicUrl = user?.profile?.imageURL(withDimension: 320)
    }
    
    func clearValues() {
        email = nil
        fullName = nil
        givenName = nil
        familyName = nil
        profilePicUrl = nil
    }
    
    func manualInsert(user: UserProfile) {
        email = user.email
        givenName = user.username
    }
}
