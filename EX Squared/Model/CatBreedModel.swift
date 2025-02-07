import Foundation

struct CatBreed: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let referenceImageID: String?
    var imageURL: String?
    var energyLevel: Int?
    var wikipediaURL: String?
    var temperament: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, temperament, energyLevel = "energy_level"
        case wikipediaURL = "wikipedia_url"
        case referenceImageID = "reference_image_id"
    }
    
    static func == (lhs: CatBreed, rhs: CatBreed) -> Bool {
        return lhs.id == rhs.id && lhs.imageURL == rhs.imageURL
    }
}
