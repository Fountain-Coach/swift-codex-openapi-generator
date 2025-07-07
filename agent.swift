/*
 SwiftCodexOpenAPIGenerator Agent
 --------------------------------
 The purpose of this agent is to generate deterministic Swift client and server
 code from the OpenAPI specification at `OpenAPI/api.yaml` using only native
 Swift 6 tooling.

 Trigger: whenever `OpenAPI/api.yaml` or the generator sources change, Codex
 should run:

     swift run generator --input OpenAPI/api.yaml --output Generated/

 The command emits Swift files under `Generated/Client/` and
 `Generated/Server/`. All generated files must be committed so Codex can
 inspect diffs.

 After generation, Codex runs `swift test` to ensure the output builds and the
 server integration tests pass. If tests fail, no commit is made.

 Commit messages should note the spec change followed by `Regenerate client and
 server`.

 Fallback: re-run the generator and tests manually with the commands above and
 verify that the resulting files remain deterministic.
*/

import Foundation

@main
struct CodexAgent {
    static func main() throws {
        try runGenerator()
        try runTests()
    }

    private static func runGenerator() throws {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = ["swift", "run", "generator", "--input", "OpenAPI/api.yaml", "--output", "Generated/"]
        try process.run()
        process.waitUntilExit()
        if process.terminationStatus != 0 {
            throw RuntimeError("generation failed")
        }
    }

    private static func runTests() throws {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = ["swift", "test"]
        try process.run()
        process.waitUntilExit()
        if process.terminationStatus != 0 {
            throw RuntimeError("tests failed")
        }
    }
}

struct RuntimeError: Error, CustomStringConvertible {
    var description: String
    init(_ description: String) { self.description = description }
}
