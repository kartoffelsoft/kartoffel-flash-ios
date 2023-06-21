import Foundation

struct ShelfElementViewData: Equatable, Hashable, Identifiable {
    
    let id: UUID
    let type: Kind
    let name: String

    init(
        id: UUID = UUID(),
        type: Kind,
        name: String
    ) {
        self.id = id
        self.type = type
        self.name = name
    }
}

extension ShelfElementViewData {
    
    enum Kind {
        case folder
        case pack
    }
}
