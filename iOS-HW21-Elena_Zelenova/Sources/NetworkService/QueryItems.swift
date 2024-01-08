import Foundation

let ts = 1
let publicKey = "d1f0ddc73668f1ef8f98913382c79f94"
private let privateKey = "c8e0726564477b1d8d7363c92a8ce33205288f09"
    
let hash = "\(ts)\(privateKey)\(publicKey)".md5
