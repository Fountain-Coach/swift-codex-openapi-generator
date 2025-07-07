import Foundation
import Yams

enum SpecLoader {
    static func load(from url: URL) throws -> OpenAPISpec {
        let data = try Data(contentsOf: url)
        if url.pathExtension.lowercased() == "json" {
            return try JSONDecoder().decode(OpenAPISpec.self, from: data)
        } else {
            let yamlString = String(decoding: data, as: UTF8.self)
            return try YAMLDecoder().decode(OpenAPISpec.self, from: yamlString)
        }
    }
}
