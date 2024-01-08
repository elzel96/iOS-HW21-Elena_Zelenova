import Foundation
import Alamofire

let ts = 1
let privateKey = "c8e0726564477b1d8d7363c92a8ce33205288f09"
let publicKey = "d1f0ddc73668f1ef8f98913382c79f94"

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
            URLQueryItem(name: "hash", value: md5Hex)
        ]
        
        guard let requestURL = urlComponents.url else {
            return nil
        }
        return requestURL
    }
    
    func fetchCharacter() {
        let url = makeRequestUrl()
        let request = AF.request(url)
        request.responseDecodable(of: Characters.self) { (data) in
            guard let characters = data.value
        }
    }
}
    
