import Foundation

struct Characters: Decodable {
    let characters: [Character]
}

struct Character: Decodable {
    let id: Int
    let name: String
    let description: String
}
