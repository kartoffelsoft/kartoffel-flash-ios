import ComposableArchitecture
import UIKit

public class HomeViewController: UIViewController {

    private let store: StoreOf<Home>
    private let viewStore: ViewStoreOf<Home>

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
        view.backgroundColor = .cyan
    }

}
