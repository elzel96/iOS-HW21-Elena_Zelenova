import Foundation

struct Characters: Decodable {
    let characters: [Character]
    
    enum CodingKeys: String, CodingKey {
        case characters
    }
}

struct Character: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
       case id
       case name
       case description
       case imageURL
    }
}
