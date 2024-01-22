import Foundation
import Alamofire

class NetworkService {
    
    static let shared = NetworkService()
    
    func makeRequestUrl(_ forName: String?) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "gateway.marvel.com"
        urlComponents.path = "/v1/public/characters"
        if let name = forName {
            urlComponents.queryItems = [
                URLQueryItem(name: "ts", value: "\(ts)"),
                URLQueryItem(name: "apikey", value: publicKey),
                URLQueryItem(name: "hash", value: hash),
                URLQueryItem(name: "nameStartsWith", value: name)
            ]
        } else {
            urlComponents.queryItems = [
                URLQueryItem(name: "ts", value: "\(ts)"),
                URLQueryItem(name: "apikey", value: publicKey),
                URLQueryItem(name: "hash", value: hash)
                ]
        }
        
        guard let requestURL = urlComponents.url else {
            return nil
        }
        return requestURL
    }
    
    func fetchCharacter(_ forName: String?, complitionHadler: @escaping ([Character]?) -> Void) {
        guard let url = makeRequestUrl(forName) else { return }
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result {
            case .success(let data):
                do {
                    if let data = data {
                        let jsonData = try JSONDecoder().decode(CharacterDataWrapper.self, from: data)
                        let result = jsonData.data?.results
                        if result != nil { complitionHadler(result!) }
                        }
                } catch {
                    print(error.localizedDescription)
                } case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getImageData(path: String?, complitionHadler: @escaping (Data) -> Void) {
        guard let url = path else { return }
        AF.download(url).responseData { response in
            guard let image = response.value else {
                return
            }
            complitionHadler(image)
        }
    }
}
    
