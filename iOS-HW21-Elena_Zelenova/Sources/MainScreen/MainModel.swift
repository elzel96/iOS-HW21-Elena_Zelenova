import Foundation

struct CharacterDataWrapper: Decodable {
    let data: CharacterDataContainer?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct CharacterDataContainer: Decodable {
    let results: [Character]?
}

struct Character: Decodable {
    let name: String?
    let description: String?
    let thumbnail: Image?
}

struct Image: Decodable {
    var path: String?
    var `extension`: String?
    
    func getImagePath() -> String {
        (path ?? "") + "." + (`extension` ?? "")
    }
}
