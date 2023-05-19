import ComposableArchitecture

public struct Home: ReducerProtocol {
    
    public struct State: Equatable {
    
        public init() {}
    }
    
    public enum Action: Equatable {
        case initialize
    }

    public init() {}
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .initialize:
                return .none
            }
        }
    }
}
