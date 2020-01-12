import Foundation

struct CardRemomteConfigEntity: Codable {
    let title: String
    let url: String
    let details: String
    let imageURL: String?
    let identifier: String

    enum CodingKeys: String, CodingKey {
        case title
        case url
        case details
        case imageURL = "image_url"
        case identifier
    }
}
