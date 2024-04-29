import Foundation
struct Headline : Codable {
	let main : String?

	enum CodingKeys: String, CodingKey {
		case main = "main"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		main = try values.decodeIfPresent(String.self, forKey: .main)
	}

}
