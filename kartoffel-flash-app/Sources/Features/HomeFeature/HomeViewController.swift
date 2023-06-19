import BoxFeature
import ComposableArchitecture
import StyleGuide
import UIKit

public class HomeViewController: UIViewController {

    private let store: StoreOf<Home>
    private let viewStore: ViewStoreOf<Home>
    
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
        setupConstraints()
    }
    
    private func setupConstraints() {
        actionBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(actionBar)
        
        NSLayoutConstraint.activate([
            actionBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            actionBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            actionBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            actionBar.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
}

extension HomeViewController: ActionBarDelegate {
    
    func actionBarDidTapCreateBox() {
        print("@")
    }
}
