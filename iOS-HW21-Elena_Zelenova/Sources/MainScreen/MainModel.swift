import Foundation

struct Characters: Decodable {
    let characters: [Character]
    
    enum CodingKeys: String, CodingKey {
        case characters
    }
}

struct Character: Decodable {
    let name: String?
    let description: String?
    let thumbnail: Thumbnail?
    
    enum CodingKeys: String, CodingKey {
       case name
       case description
       case thumbnail
    }
}

struct Thumbnail: Decodable {
    var path: String?
    var `extension`: String?
    
    func getImagePath() -> String {
        (path ?? "") + "." + (`extension` ?? "")
    }
}
