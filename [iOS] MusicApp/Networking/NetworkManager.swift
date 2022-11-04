//
//  NetworkManager.swift
//  [iOS] MusicApp
//
//  Created by 유현이 on 2022/11/04.
//

import Foundation

enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    typealias NetworkCompletion = (Result<[Music], NetworkError>) -> Void
    
    func fetchMusic(searchTerm: String, completion: @escaping NetworkCompletion) {
        let urlString = "\(MusicApi.requestUrl)\(MusicApi.mediaParam)&term=\(searchTerm)"
        print(urlString)
        performRequest(with: urlString) { result in
            completion(result)
        }
    }
    
    func performRequest(with urlString: String, completion: @escaping NetworkCompletion) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print(response!)
                return
            }
            
            if let musics = self.parseJSON(safeData) {
                print("parse 성공")
                completion(.success(musics))
            } else {
                print("parse 실패")
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    func parseJSON(_ musicData: Data) -> [Music]? {
        do {
            let musicData = try JSONDecoder().decode(MusicData.self, from: musicData)
            return musicData.results
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
