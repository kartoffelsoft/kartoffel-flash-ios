import UIKit

extension UIFont {
    public static let theme = UIFontTheme()
}

public struct UIFontTheme {
    
    public let headline1 = UIFont.systemFont(ofSize: 28, weight: .bold)
    public let title1 = UIFont.systemFont(ofSize: 24, weight: .bold)
    public let subhead1 = UIFont.systemFont(ofSize: 18, weight: .semibold)
    public let body1 = UIFont.systemFont(ofSize: 16, weight: .medium)
    public let caption1 = UIFont.systemFont(ofSize: 12, weight: .regular)
    public let mono1 = UIFont.monospacedSystemFont(ofSize: 16, weight: .semibold)
}
