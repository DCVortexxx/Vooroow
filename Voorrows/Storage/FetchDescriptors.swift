import Foundation
import SwiftData

extension FetchDescriptor {

    static func all<C: Comparable>(by keyPath: KeyPath<T, C>) -> Self {
        let sortDescriptor: SortDescriptor<T> = .init(keyPath, order: .reverse)
        var fetchDescriptor: Self = .init(sortBy: [sortDescriptor])
        return fetchDescriptor
    }
    static func max<C: Comparable>(by keyPath: KeyPath<T, C>) -> Self {
        let sortDescriptor: SortDescriptor<T> = .init(keyPath, order: .reverse)
        var fetchDescriptor: Self = .init(sortBy: [sortDescriptor])
        fetchDescriptor.fetchLimit = 1
        return fetchDescriptor
    }

}
