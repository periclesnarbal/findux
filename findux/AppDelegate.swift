//
//  AppDelegate.swift
//  findux
//
//  Created by Péricles Narbal on 28/06/23.
//

import UIKit
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        googleSignInSetup()
        googleSignInRestoreSeccion()
        
        UINavigationBar.appearance().tintColor = .black
        
        return true
    }
    
    private func googleSignInSetup() {
        if let credentials = try? googleSignInLoadCredentials() {
            let configuration = GIDConfiguration(clientID: credentials.clientId)
            GIDSignIn.sharedInstance.configuration = configuration
        }
    }
    
    private func googleSignInLoadCredentials() throws -> GoogleSignInCredentialsModel {
        if let path = Bundle.main.path(forResource: "credentials", ofType: "plist") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = PropertyListDecoder()
                let credentials = try decoder.decode(GoogleSignInCredentialsModel.self, from: data)
                return credentials
            } catch {
               throw error
            }
        }
        throw NSError(domain: "File named credentials.plist cant`t be load or doesn't exists.", code: 0)
    }
    
    private func googleSignInRestoreSeccion() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                print("SIGNED-OUT STATE")
            } else {
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    sceneDelegate.coordinator?.goToHomeCoordinator()
                }
            }
        }
    }
    
//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//        return GIDSignIn.sharedInstance.handle(url)
//    }
//
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//      return GIDSignIn.sharedInstance.handle(url)
//    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

