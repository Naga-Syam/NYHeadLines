import Foundation
struct Docs : Codable {
	let abstract : String?
	let multimedia : [Multimedia]?
	let headline : Headline?
	let pub_date : String?

	enum CodingKeys: String, CodingKey {
		case abstract = "abstract"
		case multimedia = "multimedia"
		case headline = "headline"
		case pub_date = "pub_date"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		abstract = try values.decodeIfPresent(String.self, forKey: .abstract)
		multimedia = try values.decodeIfPresent([Multimedia].self, forKey: .multimedia)
		headline = try values.decodeIfPresent(Headline.self, forKey: .headline)
		pub_date = try values.decodeIfPresent(String.self, forKey: .pub_date)
	}
    
    var humanReadableDate: String? {
        guard let pubDate = pub_date else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: pubDate)
        if let date = date {
            let humanReadableDateFormatter = DateFormatter()
            humanReadableDateFormatter.dateFormat = "MMMM dd, yyyy 'at' HH:mm:ss"
            let humanReadableDate = humanReadableDateFormatter.string(from: date)
            return humanReadableDate
        } else {
            print("Failed to convert the date string.")
        }
        return nil
    }
    
    var imageURL: String? {
        guard let media = multimedia, !media.isEmpty, let url = media.first?.url else {
            return nil
        }
        return "https://static01.nyt.com/\(url)"
    }

}
