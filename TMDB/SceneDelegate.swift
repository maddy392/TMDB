//
//  SceneDelegate.swift
//
//  Created by Madhu Babu Adiki on 5/29/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        print("Scene opened with URL: \(url)")
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if components?.scheme == "themoviemanager" && components?.path == "authenticate" {
            print("we are here; URL components confirmed")
            let loginVC = self.window?.rootViewController as! LoginViewController
            TMDBClient.createSession(completionHandler: loginVC.handleSessionResponse(success:error:))
        }
        
    }


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//        guard let _ = (scene as? UIWindowScene) else { return }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

               // Ensure the window is properly initialized
               window = UIWindow(windowScene: windowScene)
               
               // Assuming your main storyboard's initial view controller is the root view controller
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               if let rootVC = storyboard.instantiateInitialViewController() {
                   window?.rootViewController = rootVC
                   window?.makeKeyAndVisible()
               }
               
               // Check the root view controller
               if let rootViewController = window?.rootViewController {
                   print("Root View Controller: \(rootViewController)")
               }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

