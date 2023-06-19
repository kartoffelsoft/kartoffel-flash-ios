import ComposableArchitecture
import HomeFeature
import UIKit

public class AppRootViewController: UIViewController {

    private let store: StoreOf<AppRoot>
    private let viewStore: ViewStoreOf<AppRoot>
    
    private var contentViewController: UIViewController?

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
        
        show(HomeViewController(
            store: self.store.scope(
                state: \.home,
                action: AppRoot.Action.home
            )),
            sender: self
        )
    }
    
    public override func show(_ vc: UIViewController, sender: Any?) {
        contentViewController?.removeFromParent()
        contentViewController?.view.removeFromSuperview()

        addChild(vc)
        view.addSubview(vc.view)
        
        contentViewController = vc
    }
}
