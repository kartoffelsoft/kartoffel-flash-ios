import Foundation

struct FolderViewData: Equatable, Hashable {
    
    let id: UUID
    let name: String
    let items: [ShelfItemViewData]
    let isExpanded: Bool
    
    init(
        id: UUID = UUID(),
        name: String,
        items: [ShelfItemViewData],
        isExpanded: Bool = false
    ) {
        self.id = id
        self.name = name
        self.items = items
        self.isExpanded = isExpanded
    }
}

extension FolderViewData {
    
    func withToggleExpansion() -> FolderViewData {
        return FolderViewData(
            id: id,
            name: name,
            items: items,
            isExpanded: !isExpanded
        )
    }
}
