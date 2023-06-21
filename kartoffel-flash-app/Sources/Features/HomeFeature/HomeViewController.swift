import BoxFeature
import Combine
import ComposableArchitecture
import StyleGuide
import UIKit

public class HomeViewController: UIViewController {

    private let store: StoreOf<Home>
    private let viewStore: ViewStoreOf<Home>
    private var cancellables: Set<AnyCancellable> = []
    
    
    private let collectionView = HomeCollectionView()
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    
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
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ShelfElementViewData> { cell, indexPath, data in
            var content = cell.defaultContentConfiguration()
            content.text = data.name

            content.textProperties.font = .theme.subhead1
            content.textProperties.color = .theme.primary500
            content.directionalLayoutMargins = .init(top: 4, leading: 0, bottom: 4, trailing: 0)

            
            cell.contentConfiguration = content
            cell.backgroundConfiguration?.backgroundColor = .theme.background500
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, data in
                switch(Section(rawValue: indexPath.section)) {
                case .shelf:
                    return collectionView.dequeueConfiguredReusableCell(
                        using: cellRegistration,
                        for: indexPath,
                        item: data as? ShelfElementViewData
                    )
                case .none:
                    break
                }
                return nil
            }
        )
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
            var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(data.elements, toSection: .shelf)
            self?.dataSource.apply(snapshot, animatingDifferences: data.animate)
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
            break
            
        case .none:
            break
        }
    }
}

extension HomeViewController: UICollectionViewDragDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = self.viewStore.shelfViewData.elements[indexPath.row]
        let itemProvider = NSItemProvider(object: item.id.uuidString as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
}

extension HomeViewController: UICollectionViewDropDelegate {
    
    
    public func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    public func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        var destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let row = collectionView.numberOfItems(inSection: 0)
            destinationIndexPath = IndexPath(item: row - 1, section: 0)
        }
        
        if coordinator.proposal.operation == .move {
            print("# Done")
        }
        
    }
}
