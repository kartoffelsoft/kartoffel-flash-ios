import Foundation

enum ShelfItemViewData: Equatable, Hashable {
    
    case folder(FolderViewData)
    case pack(PackViewData)
}
