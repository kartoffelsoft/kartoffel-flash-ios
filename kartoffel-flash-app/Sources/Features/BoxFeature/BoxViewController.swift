import ComposableArchitecture
import StyleGuide
import UIKit

public class BoxViewController: UIViewController {

    private let store: StoreOf<Box>
    private let viewStore: ViewStoreOf<Box>

    public init(store: StoreOf<Box>) {
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
    }
}
