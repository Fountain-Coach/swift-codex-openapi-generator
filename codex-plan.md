# Codex Execution Plan: swift-codex-openapi-generator

This document defines the full step-by-step plan Codex should follow to implement the promise of this repository.

---

## 🪪 Phase 0 · Repository Identity

- [x] Create `agent.swift` to define Codex behavior and generation triggers.
- [x] Create `.codex` manifest with:
  - `repo`: swift-codex-openapi-generator
  - `entrypoint`: `swift run generator --input OpenAPI/api.yaml --output Generated/`
  - `generates`: `Generated/Client/`, `Generated/Server/`
  - `dependencies`: `vapor@4.115.0`
  - `triggers`: `OpenAPI/api.yaml`
  - `tests`: `swift test`

---

## 🧱 Phase 1 · Project Scaffolding

- [x] Initialize `Package.swift` with CLI and test targets.
- [x] Create `Sources/Generator/main.swift`.
- [x] Create `Tests/GeneratorTests/` and `Tests/ServerTests/`.
- [x] Add example `OpenAPI/api.yaml`.
- [x] Add `.gitignore`.

---

## 📜 Phase 2 · OpenAPI Spec Parser

- [x] `OpenAPISpec.swift`: Swift structs for OpenAPI 3.1 fields.
- [x] `SpecLoader.swift`: load and decode YAML/JSON from file.
- [x] Test valid/invalid/partial schema loading.

---

## 🧬 Phase 3 · Model Emitter (Shared)

- [ ] `ModelEmitter.swift`: emit `Codable` models from `components.schemas`.
- [ ] Support `CodingKeys`, enums, nullable fields, `oneOf`.
- [ ] Emit to both `Generated/Client/Models.swift` and `Generated/Server/Models.swift`.
- [ ] Golden file tests for emitted models.

---

## 🔌 Phase 4 · Client SDK Generator

- [ ] Create `APIRequest.swift` protocol.
- [ ] Create `APIClient.swift` using `URLSession` with async/await.
- [ ] Emit typed requests (e.g. `GetUser.swift`) per path.
- [ ] Group under `Generated/Client/Requests/`.
- [ ] Write client-side unit and integration tests.

---

## 🌀 Phase 5 · Vapor Server Generator

- [ ] `HandlerProtocol.swift`: defines stub methods for each operation.
- [ ] `Handlers.swift`: stubbed implementations.
- [ ] `Routes.swift`: register routes with Vapor 4.115.x API.
- [ ] Use `req.parameters.require(...)`, `req.content.decode(...)`.
- [ ] Emit to `Generated/Server/`.
- [ ] Add integration tests using `XCTVapor`.

---

## 🧪 Phase 6 · Testing & Validation

- [ ] Unit tests for the generator logic.
- [ ] Golden tests for generated Swift files.
- [ ] Runtime tests for Vapor server using `XCTVapor`.
- [ ] End-to-end coverage: `api.yaml` → CLI → emitted code → validated tests.

---

## 📦 Phase 7 · Documentation & Developer Experience

- [ ] Inline doc comments across generator source files.
- [ ] Add `Examples/` folder with sample specs and outputs.
- [ ] Ensure `README.md` shows complete usage.
- [ ] Optional: GitHub Actions CI to run `swift test`.

---

This plan defines the full loop Codex can follow to author, validate, and extend the generator in a self-contained and repeatable way.
