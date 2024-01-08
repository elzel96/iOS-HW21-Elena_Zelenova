import Foundation
import Alamofire

let ts = 1
let privateKey = "c8e0726564477b1d8d7363c92a8ce33205288f09"
let publicKey = "d1f0ddc73668f1ef8f98913382c79f94"
let hash = "\(ts)\(privateKey)\(publicKey)".md5

class NetworkService {
    
    static let shared = NetworkService()
    
    func makeRequestUrl() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "gateway.marvel.com"
        urlComponents.path = "/v1/public/characters"
        urlComponents.queryItems = [
            URLQueryItem(name: "ts", value: "\(ts)"),
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: hash)
        ]
        
        guard let requestURL = urlComponents.url else {
            return nil
        }
        return requestURL
    }
    
    func fetchCharacter(complitionHadler: @escaping ([Character]) -> Void) {
        guard let url = makeRequestUrl() else { return }
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result {
            case .success(let data):
                do {
                    if let data = data {
                        let jsonData = try JSONDecoder().decode(Characters.self, from: data)
                        let result = jsonData.characters
                        complitionHadler(result)
                    }
                } catch {
                    print(error.localizedDescription)
                } case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
    
