//
//  GoogleSignInCredentialsModel.swift
//  findux
//
//  Created by Péricles Narbal on 06/09/23.
//

import Foundation

struct GoogleSignInCredentialsModel: Decodable {
    let clientId: String
    let reversedClientId: String
    let plistVersion: String
    let bundleId: String
    
    enum CodingKeys: String, CodingKey {
        case clientId = "CLIENT_ID"
        case reversedClientId = "REVERSED_CLIENT_ID"
        case plistVersion = "PLIST_VERSION"
        case bundleId = "BUNDLE_ID"
    }
}
