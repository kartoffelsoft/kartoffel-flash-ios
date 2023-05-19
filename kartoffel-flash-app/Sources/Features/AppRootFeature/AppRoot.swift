import ComposableArchitecture

public struct AppRoot: ReducerProtocol {
    
    public struct State: Equatable {
        var appRootDelegate: AppRootDelegate.State = .init()
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case appRootDelegate(AppRootDelegate.Action)
    }

    public init() {}
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .appRootDelegate:
                return .none
            }
        }
        Scope(state: \.appRootDelegate, action: /Action.appRootDelegate) {
            AppRootDelegate()
        }
    }
}
