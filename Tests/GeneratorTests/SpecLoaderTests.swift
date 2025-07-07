import XCTest
@testable import Generator

final class SpecLoaderTests: XCTestCase {
    func testLoadValidSpec() throws {
        let url = Bundle.module.url(forResource: "valid",
                                    withExtension: "yaml",
                                    subdirectory: "Fixtures")!
        let spec = try SpecLoader.load(from: url)
        XCTAssertEqual(spec.info.title, "Valid API")
    }

    func testLoadInvalidSpecThrows() throws {
        let url = Bundle.module.url(forResource: "invalid",
                                    withExtension: "yaml",
                                    subdirectory: "Fixtures")!
        XCTAssertThrowsError(try SpecLoader.load(from: url))
    }

    func testLoadPartialSpec() throws {
        let url = Bundle.module.url(forResource: "partial",
                                    withExtension: "yaml",
                                    subdirectory: "Fixtures")!
        let spec = try SpecLoader.load(from: url)
        XCTAssertNil(spec.paths)
        XCTAssertNil(spec.components)
    }
}
