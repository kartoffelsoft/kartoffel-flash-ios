import BoxFeature
import ComposableArchitecture

public struct Home: ReducerProtocol {
    
    public struct State: Equatable {
    
        struct ShelfViewData: Equatable {
            
            let animate: Bool
            let elements: [ShelfElementViewData]
        }
        
        var shelfViewData: ShelfViewData = .init(
            animate: false,
            elements: [
                .init(type: .folder, name: "Folder 1"),
                .init(type: .folder, name: "Folder 2"),
                .init(type: .pack, name: "Pack 1"),
                .init(type: .pack, name: "Pack 2")
            ]
        )
        
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
