import SwiftData

extension ModelContainer {

    static func app() -> ModelContainer {
        let schema: Schema = .app()

        let configuration: ModelConfiguration = .init(schema: schema)

        // For this tech test, I'm assuming that there won't
        // be any issue with SwiftData, since we only have one version,
        // no database migration to handle, or whatever.
        // I think it's a fair assumption given the time frame, and in
        // a real production app we can properly handle this error and
        // give it more thought.
        return try! ModelContainer(
            for: schema,
            configurations: [configuration]
        )
    }

    static func preview() -> ModelContainer {
        let schema: Schema = .app()

        let configuration: ModelConfiguration = .init(
            schema: schema,
            isStoredInMemoryOnly: true
        )

        // Placeholder to add mock data

        return try! ModelContainer(
            for: schema,
            configurations: [configuration]
        )
    }

}
