import ComposableArchitecture
import XCTest
@testable import AppRootFeature

final class AppRootFeatureTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        store = TestStore(initialState: AppRoot.State(), reducer: AppRoot())
    }
    
}
