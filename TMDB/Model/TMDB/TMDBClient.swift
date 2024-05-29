//
//  TMDBClient.swift
//  TMDB
//
//  Created by Madhu Babu Adiki on 5/27/24.
//

import Foundation

class TMDBClient {
    
    static let apiKey = "cb2876a8f6d530cbd609d0f92d1dc003"
    
    struct Auth {
        static var accountId = 21289638
        static var requestToken = ""
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://api.themoviedb.org/3"
        static let apiKeyParam = "?api_key=\(TMDBClient.apiKey)"
        static let getRequestTokenPath = "/authentication/token/new"
        static let getCreateSessionWithLoginPath = "/authentication/token/validate_with_login"
        static let createSessionPath = "/authentication/session/new"
        
        case getWatchlist
        case getRequestToken
        case login
        case createSessionId
        case webAuth
        
        var stringValue: String {
            switch self {
            case .getWatchlist: return Endpoints.base + "/account/\(Auth.accountId)/watchlist/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
            case .getRequestToken: return Endpoints.base + Endpoints.getRequestTokenPath + Endpoints.apiKeyParam
            case .login: return Endpoints.base + Endpoints.getCreateSessionWithLoginPath + Endpoints.apiKeyParam
            case .createSessionId: return Endpoints.base + Endpoints.createSessionPath + Endpoints.apiKeyParam
            case .webAuth: return "https://www.themoviedb.org/authenticate/" + Auth.requestToken + "?redirect_to=themoviemanager:authenticate"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func createSession(completionHandler: @escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.createSessionId.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(PostSession(requestToken: Auth.requestToken))
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data else {
                print("Error creating session Id")
                completionHandler(false, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(SessionResponse.self, from: data)
//                print(responseObject)
                Auth.sessionId = responseObject.sessionId
                print("Auth successful")
                completionHandler(true, nil)
            } catch {
                completionHandler(false, error)
            }
        }
        task.resume()
    }
    
    class func login(username: String, password: String, completionHandler: @escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(LoginRequest(username: username, password: password, requestToken: Auth.requestToken))
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data else {
                print("Error Loggin in")
                completionHandler(false, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(RequestTokenResponse.self, from: data)
//                print(responseObject)
                Auth.requestToken = responseObject.requestToken
                completionHandler(true, nil)
            } catch {
                print("Error in logging in! Username/password is incorrect")
                completionHandler(false, error)
                print(error)
            }
        }
        task.resume()
    }
    
    class func getRequestToken(completionHandler: @escaping (Bool, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.getRequestToken.url) {
            data, response, error in
            guard let data = data else {
                print("Error in getting response token")
                completionHandler(false, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(RequestTokenResponse.self, from: data)
//                print(responseObject)
                Auth.requestToken = responseObject.requestToken
                completionHandler(true, nil)
            } catch {
                print("Error in getting a request token. Check API Key or url")
                print(error)
            }
        }
        task.resume()
    }
    
    class func getWatchlist(completionHandler: @escaping ([Movie], Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: Endpoints.getWatchlist.url) {
            data, response, error in
            
            guard let data = data else {
                print("Error in fetching WatchList Data")
                completionHandler([], error)
                return
            }
                        
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(MovieResults.self, from: data)
//                print(responseObject)
                completionHandler(responseObject.results, nil)
            } catch {
                print("Decoding Error: \(error)")
            }
        }
        task.resume()
    }
}
