import UIKit

class HomeCollectionView: UICollectionView {
    
    init() {
        super.init(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout()
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { section, _ in
        switch(Section(rawValue: section)) {
        case .shelf:
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(80)
                )
            )
            item.contentInsets = .init(top: 4, leading: 0, bottom: 4, trailing: 0)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(500)
                ),
                subitems: [ item ]
            )

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 8, leading: 8, bottom: 60, trailing: 8)
            return section

        default:
            return nil
        }
    }
}
