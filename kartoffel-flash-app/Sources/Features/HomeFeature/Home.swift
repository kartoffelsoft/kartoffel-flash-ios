import BoxFeature
import ComposableArchitecture
import Foundation

public struct Home: ReducerProtocol {
    
    public struct State: Equatable {

        var shelfViewData: ShelfViewData = .init(
            animate: false,
            items: [
                .folder(.init(
                    name: "German",
                    items: [
                        .pack(.init(name: "Akkusative")),
                        .pack(.init(name: "Dative")),
                    ]
                )),
                .folder(.init(
                    name: "Korean",
                    items: [
                        .pack(.init(name: "KPop")),
                        .pack(.init(name: "Movies")),
                    ]
                )),
                .folder(.init(
                    name: "English",
                    items: [
                        .pack(.init(name: "Numbers")),
                        .pack(.init(name: "Idioms")),
                    ]
                )),
                .pack(.init(name: "Numbers")),
            ]
        )
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case initialize
        case toggleExpansion(UUID)
    }

    public init() {}
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .initialize:
                return .none
            case let .toggleExpansion(id):
                state.shelfViewData = ShelfViewData(
                    animate: state.shelfViewData.animate,
                    items: state.shelfViewData.items.map({ item in
                        switch item {
                        case let .folder(viewData):
                            if viewData.id == id {
                                return .folder(viewData.withToggleExpansion())
                            }
                            return item
                        case .pack:
                            return item
                        }
                    })
                )
                return .none
            }
        }
    }
}
