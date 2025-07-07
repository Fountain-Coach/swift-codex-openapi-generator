# SwiftCodexOpenAPIGenerator

*A Swift 6‑only CLI tool that generates both a Swift client SDK and Vapor 4 server stubs from an OpenAPI 3.1 spec — fully Codex‑compatible*

---

## Overview 🚀

This project enables fully native, deterministic code generation for both:

- **Swift Client SDK** — `Codable` models, typed endpoint methods, `APIClient` using `URLSession`.
- **Vapor 4 Server Scaffold** — route registration, handler stubs using Vapor 4 async APIs, and integration tests with `XCTVapor`.

Everything is generated via a CLI (`swift run generator`) and *committed to Git*, enabling Codex to inspect, diff, update, and validate generated code.

---

## Swift Client SDK Details 🧭

The generated Swift client includes:

- `Codable` models from `components.schemas`
- Strongly typed endpoint operations as enums or methods
- A configurable `APIClient` using `URLSession` or custom transport
- Automatic `CodingKeys`, doc comments from OpenAPI descriptions
- Optional error decoding and HTTP status-based output enums

**Example:**
```swift
struct Todo: Codable, Equatable {
    let id: UUID
    let title: String
    let completed: Bool
}

struct GetTodoRequest: APIRequest {
    var todoId: UUID
    var path: String { "/todos/\(todoId)" }
    var method: HTTPMethod { .get }
    var responseType: Todo.Type { Todo.self }
}

class APIClient {
    func send<T: APIRequest>(_ request: T) async throws -> T.Response {
        let url = URL(string: baseURL + request.path)!
        var req = URLRequest(url: url)
        req.httpMethod = request.method.rawValue
        let (data, _) = try await URLSession.shared.data(for: req)
        return try JSONDecoder().decode(T.Response.self, from: data)
    }
}
```

Generated files:
```
Generated/Client/
├── Models.swift
├── Requests/
│   ├── GetTodo.swift
│   ├── CreateTodo.swift
│   └── ...
├── APIClient.swift
└── APIRequest.swift
```

---

## Vapor Server Stub Details 🧩

The generator creates a Vapor 4 compatible server scaffold:

- Route handlers grouped by tag
- Route registration (`Routes.registerHandlers`)
- Handler protocol (`Handler.swift`) with stubbed methods
- `req.parameters.require(...)`, `req.content.decode(...)`, etc.

**Example:**
```swift
extension Routes {
    static func registerHandlers(on app: Application, handler: Handler) throws {
        app.get("todos", ":id") { req async throws -> Todo in
            let input = try Operations.GetTodo.Input(path: .init(id: req.parameters.require("id")))
            return try await handler.getTodo(input).body.json
        }
    }
}
```

Handlers are defined in:
```
Generated/Server/
├── Models.swift
├── Handlers.swift
├── Routes.swift
└── Package.swift (Vapor 4.115.0 pinned)
```

---

## Project Structure

```
SwiftCodexOpenAPIGenerator/
├── OpenAPI/
│   └── api.yaml              ← Authoritative OpenAPI 3.1 spec
├── Sources/
│   └── Generator/            ← CLI tool that emits Swift code
├── Generated/
│   ├── Client/               ← Generated client SDK target
│   └── Server/               ← Generated Vapor server scaffold
├── Tests/
│   ├── GeneratorTests/       ← Unit + golden file tests
│   └── ServerTests/          ← `XCTVapor` route integration tests
└── README.md
```

---

## Getting Started

1. **Build the CLI generator**:
   ```bash
   swift build -c release
   ```

2. **Generate code from your OpenAPI spec**:
   ```bash
   swift run generator \
     --input OpenAPI/api.yaml \
     --output Generated/
   ```

3. **Inspect generated Swift files** in `Generated/Client/` and `Generated/Server/`.

4. **Run full test suite**:
   ```bash
   swift test
   ```

---

## Codex-Compatible Workflow

- The OpenAPI spec is version-controlled and readable
- All generated code is written to committed `.swift` files
- Codex can:
  - Edit `api.yaml`
  - Re-run the generator
  - Inspect changes
  - Add handler logic or extend clients
  - Run `swift test` and commit output

---

## Testing & Quality Assurance

- The generator is **100% tested**:
  - OpenAPI parsing
  - Code emission
  - Golden file validation
- Server code is tested using `XCTVapor`
- Ensures build + runtime correctness under **Swift 6** and **Vapor 4.115.0**

---

## License & Attribution

MIT License  
© 2025 FountainAI

All generated artifacts are version-controlled and readable. The entire pipeline is deterministic, testable, and orchestratable by Codex.

---
