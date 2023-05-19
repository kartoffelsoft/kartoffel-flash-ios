import ComposableArchitecture
import UIKit

public class AppRootViewController: UIViewController {

    private let store: StoreOf<AppRoot>
    private let viewStore: ViewStoreOf<AppRoot>

    public init(store: StoreOf<AppRoot>) {
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
