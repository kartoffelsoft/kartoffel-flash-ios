import ComposableArchitecture
import XCTest
@testable import AppRootFeature

final class AppRootFeatureTests: XCTestCase {
    
    var store: TestStore<AppRoot.State, AppRoot.Action,
                         AppRoot.State, AppRoot.Action,
                         ()>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        store = TestStore(initialState: AppRoot.State(), reducer: AppRoot())
    }
    
}
