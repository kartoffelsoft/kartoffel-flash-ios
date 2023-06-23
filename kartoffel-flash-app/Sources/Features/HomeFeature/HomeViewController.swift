import BoxFeature
import CasePaths
import Combine
import ComposableArchitecture
import StyleGuide
import UIKit

public class HomeViewController: UIViewController {

    private let store: StoreOf<Home>
    private let viewStore: ViewStoreOf<Home>
    private var cancellables: Set<AnyCancellable> = []
    
    
    private let collectionView = HomeCollectionView()
    private var dataSource: UICollectionViewDiffableDataSource<Section, ShelfItemViewData>!
    
    private let playButton = {
        let button = UIButton()
        button.tintColor = .theme.primary500
        button.backgroundColor = .clear
        return button
    }()
    
    private let actionBar: ActionBar = .init()
    
    public init(store: StoreOf<Home>) {
        self.store = store
        self.viewStore = ViewStore(store)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .theme.background500
        actionBar.delegate = self
        
        setupCollectionView()
        setupDatasource()
        setupConstraints()
        setupBindings()
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .theme.background500
        collectionView.dragInteractionEnabled = true
        
        collectionView.delegate = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
    }
    
    private func setupDatasource() {
        let folderCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, FolderViewData> {
            cell, indexPath, data in
            var content = cell.defaultContentConfiguration()
            content.text = data.name
            content.textProperties.font = .theme.subhead1
            content.textProperties.color = .theme.primary500
            content.directionalLayoutMargins = .init(top: 4, leading: 0, bottom: 4, trailing: 0)
            
            cell.contentConfiguration = content
            cell.backgroundConfiguration?.backgroundColor = .theme.background500
            
            cell.accessories = [
                .outlineDisclosure(
                    options: UICellAccessory.OutlineDisclosureOptions(style: .header)
//                    actionHandler: {
//                        print("@: ", indexPath)
//                        guard let item = self.dataSource.itemIdentifier(for: indexPath),
//                              let viewData = (/ShelfItemViewData.folder).extract(from: item)
//                        else { return }
//
//                        self.viewStore.send(.toggleExpansion(viewData.id))
//                        print("@: ", item)
//                    }
                )
            ]
        }
        
        let packCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, PackViewData> {
            cell, indexPath, data in
            var content = cell.defaultContentConfiguration()
            content.text = data.name
            content.textProperties.font = .theme.subhead1
            content.textProperties.color = .theme.primary500
            content.directionalLayoutMargins = .init(top: 4, leading: 0, bottom: 4, trailing: 0)
            
            cell.contentConfiguration = content
            cell.backgroundConfiguration?.backgroundColor = .theme.background500
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, ShelfItemViewData>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, data in
                switch data {
                case let .folder(folder):
                    return collectionView.dequeueConfiguredReusableCell(
                        using: folderCellRegistration,
                        for: indexPath,
                        item: folder
                    )
                case let .pack(pack):
                    return collectionView.dequeueConfiguredReusableCell(
                        using: packCellRegistration,
                        for: indexPath,
                        item: pack
                    )
                }
            }
        )
        
        dataSource.sectionSnapshotHandlers.willExpandItem = { item in
            print("###### ", item)
        }
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        actionBar.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(collectionView)
        view.addSubview(actionBar)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: actionBar.topAnchor),
            
            actionBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            actionBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            actionBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            actionBar.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    private func setupBindings() {
        self.viewStore.publisher.shelfViewData.sink { [weak self] data in
            var snapshot = NSDiffableDataSourceSnapshot<Section, ShelfItemViewData>()
            snapshot.appendSections([.shelf])
            
//            snapshot.appendItems(data.elements, toSection: .shelf)
//            self?.dataSource.apply(snapshot, animatingDifferences: data.animate)
            
            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<ShelfItemViewData>()
            
            for item in data.items {
                
                switch(item) {
                case let .folder(viewData):
                    sectionSnapshot.append([item])
                    sectionSnapshot.append(viewData.items, to: item)
                    print("# IsExpanded", sectionSnapshot.isExpanded(item))
                    if viewData.isExpanded {
                        sectionSnapshot.expand([item])
                    } else {
                        sectionSnapshot.collapse([item])
                    }
//                    sectionSnapshot.expand([shelfElementViewData])
//                    self?.dataSource.apply(sectionSnapshot, to: .shelf, animatingDifferences: true)
                case let .pack(viewData):
                    sectionSnapshot.append([item])
                }
                
//                dataSource.reorderingHandlers
                
                self?.dataSource.apply(sectionSnapshot, to: .shelf, animatingDifferences: false)
            }
        }
        .store(in: &self.cancellables)
    }
}

extension HomeViewController: ActionBarDelegate {
    
    func actionBarDidTapCreateBox() {
        print("@")
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch(Section(rawValue: indexPath.section)) {
        case .shelf:
            guard let item = dataSource.itemIdentifier(for: indexPath) else {
                return
            }
            
            print("# Tap: ", indexPath)
            print("# item: ", item)
            break
            
        case .none:
            break
        }
    }
}

extension HomeViewController: UICollectionViewDragDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        let item = self.viewStore.shelfViewData.elements[indexPath.row]
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return []
        }
        
        let id: String
        switch item {
        case let .folder(folder):
            id = folder.id.uuidString
        case let .pack(pack):
            id = pack.id.uuidString
        }
        let itemProvider = NSItemProvider(object: id as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
}

extension HomeViewController: UICollectionViewDropDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        guard let indexPath = destinationIndexPath,
              let item =  dataSource.itemIdentifier(for: indexPath),
              collectionView.hasActiveDrag
        else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
        
        print("#: ", session.items[0].localObject)
        switch item {
        case .folder:
            print("# It's a folder")
            return UICollectionViewDropProposal(operation: .move, intent: .insertIntoDestinationIndexPath)
        case .pack:
            print("# It's a pack")
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        print("# performDrop: ", coordinator.destinationIndexPath)
        
        guard let indexPath = coordinator.destinationIndexPath,
              let item =  dataSource.itemIdentifier(for: indexPath)
        else { return }
        
        switch item {
        case let .folder(viewData):
            print("# It's a folder: ", viewData.name)
        case let .pack(viewData):
            print("# It's a pack: ", viewData.name)
        }
        
        
        if coordinator.proposal.operation == .move {
            print("# Done")
        }
        
        print("###---:", coordinator.proposal.operation)
    }
}
