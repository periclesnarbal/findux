//
//  Network.swift
//  findux
//
//  Created by Péricles Narbal on 30/08/23.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum ContentTypes {
    case json(content: Encodable)
    case textPlain(content: String)
    
    func rawValue() -> String{
        switch self {
        case .json:
            return "application/json"
        case .textPlain:
            return "text/plain"
        }
    }
}

enum AuthenticationType {
    case basic(loginString: String)
    case bearer(token: String)
    
    func authorizationHeaderValue() -> String {
        switch self {
        case .basic(let loginString):
            return "Basic \(loginString)"
        case .bearer(let token):
            return "Bearer \(token)"
        }
    }
}

class Network {
    
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fetchRequest<T: Decodable>(urlPath: String, authentication: AuthenticationType?, httpMethod: HTTPMethods, contentType: ContentTypes?, completion: @escaping (Result<T, Error>) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "localhost"
        urlComponents.port = 8080
        urlComponents.path = urlPath
        
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
 
        if let authentication = authentication {
            let authorizationHeaderValue = authentication.authorizationHeaderValue()
            request.setValue(authorizationHeaderValue, forHTTPHeaderField: "Authorization")
        }
        
        do {
            switch contentType {
            case .json(let content):
                request.httpBody = try JSONEncoder().encode(content)
            case .textPlain(let content):
                request.httpBody = content.data(using: .utf8)
            default:
                break
            }
            
            request.setValue(contentType?.rawValue(), forHTTPHeaderField: "Content-Type")
            
        } catch {
            print("Erro ao serializar os dados JSON: \(error)")
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else { return }
            print("STATUS CODE: \(response.statusCode) \(response.url?.absoluteString ?? "")")
            
            if let error = error {
                completion(.failure(NSError(domain: "Erro ao buscar dados: \(error.localizedDescription)", code: 0)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Não há dados para esta requisição", code: 0)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(T.self, from: data)
                completion(.success(responseData))
            } catch {
                completion(.failure(NSError(domain: "Erro ao decodificar os dados JSON: \(error)", code: 0)))
            }
        }
        task.resume()
    }
}
