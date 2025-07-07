import Foundation

// Minimal subset of OpenAPI 3.1 specification required for generator
struct OpenAPISpec: Decodable {
    struct Info: Decodable {
        let title: String
        let version: String
    }

    struct Components: Decodable {
        var schemas: [String: JSONSchema]? = nil
    }

    struct JSONSchema: Codable {}

    let openapi: String
    let info: Info
    var paths: [String: PathItem]? = nil
    var components: Components? = nil
}

struct PathItem: Decodable {
    var summary: String? = nil
}
