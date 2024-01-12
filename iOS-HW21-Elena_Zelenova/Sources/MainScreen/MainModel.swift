import Foundation

struct CharacterDataContainer: Decodable {
    let results: [Character]
    
    enum CodingKeys: String, CodingKey {
        case results
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
