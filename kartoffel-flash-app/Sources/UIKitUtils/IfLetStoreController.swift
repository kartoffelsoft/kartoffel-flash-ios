import Combine
import ComposableArchitecture
import UIKit

public final class IfLetStoreController<State, Action>: UIViewController {
    let store: Store<State?, Action>
    let detents: [UISheetPresentationController.Detent]?
    let ifDestination: (Store<State, Action>) -> UIViewController
    let elseDestination: () -> UIViewController
    
    private var cancellables: Set<AnyCancellable> = []
    private var viewController = UIViewController() {
        willSet {
            self.viewController.willMove(toParent: nil)
            self.viewController.view.removeFromSuperview()
            self.viewController.removeFromParent()
            self.addChild(newValue)
            self.view.addSubview(newValue.view)
            newValue.didMove(toParent: self)
        }
    }
    
    public init(
        store: Store<State?, Action>,
        detents: [UISheetPresentationController.Detent]? = nil,
        then ifDestination: @escaping (Store<State, Action>) -> UIViewController,
        else elseDestination: @escaping () -> UIViewController
    ) {
        self.store = store
        self.detents = detents
        self.ifDestination = ifDestination
        self.elseDestination = elseDestination
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        if let detents = detents,
            let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = detents
        }
        
        self.store.ifLet(
            then: { [weak self] store in
                guard let self = self else { return }
                self.viewController = self.ifDestination(store)
            },
            else: { [weak self] in
                guard let self = self else { return }
                self.viewController = self.elseDestination()
            }
        )
        .store(in: &self.cancellables)
    }
}
