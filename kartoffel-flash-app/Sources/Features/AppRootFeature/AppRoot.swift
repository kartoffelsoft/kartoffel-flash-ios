import ComposableArchitecture
import HomeFeature

public struct AppRoot: ReducerProtocol {
    
    public struct State: Equatable {
        
        var appRootDelegate: AppRootDelegate.State = .init()
        var home: Home.State = .init()
        
        public init() {}
    }
    
    public enum Action: Equatable {
        
        case appRootDelegate(AppRootDelegate.Action)
        case home(Home.Action)
    }

    public init() {}
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .appRootDelegate:
                return .none
            case .home:
                return .none
            }
        }
        Scope(state: \.appRootDelegate, action: /Action.appRootDelegate) {
            AppRootDelegate()
        }
        Scope(state: \.home, action: /Action.home) {
            Home()
        }
    }
}
