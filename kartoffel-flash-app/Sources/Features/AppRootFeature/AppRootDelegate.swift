import ComposableArchitecture
import Foundation

public struct AppRootDelegate: ReducerProtocol {
    
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action: Equatable {
        case didFinishLaunching
    }
    
    public init() {}
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .didFinishLaunching:
                print(".didFinishLaunching")
                return .none
            }
        }
    }
}
