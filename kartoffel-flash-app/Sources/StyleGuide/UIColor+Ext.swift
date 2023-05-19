import UIKit

extension UIColor {
    public static let theme = UIColorTheme()
}

public struct UIColorTheme {
    
    public let background500 = UIColor(
        named: "background-500", in: Bundle.module, compatibleWith: nil
    )!
    public let background400 = UIColor(
        named: "background-400", in: Bundle.module, compatibleWith: nil
    )!
    public let background300 = UIColor(
        named: "background-300", in: Bundle.module, compatibleWith: nil
    )!
    public let background200 = UIColor(
        named: "background-200", in: Bundle.module, compatibleWith: nil
    )!
    public let background100 = UIColor(
        named: "background-100", in: Bundle.module, compatibleWith: nil
    )!
    public let primary500 = UIColor(
        named: "primary-500", in: Bundle.module, compatibleWith: nil
    )!
    public let primary600 = UIColor(
        named: "primary-600", in: Bundle.module, compatibleWith: nil
    )!
    public let secondary500 = UIColor(
        named: "secondary-500", in: Bundle.module, compatibleWith: nil
    )!
    public let tertiary500 = UIColor(
        named: "tertiary-500", in: Bundle.module, compatibleWith: nil
    )!
    public let tertiary600 = UIColor(
        named: "tertiary-600", in: Bundle.module, compatibleWith: nil
    )!
    public let tertiary700 = UIColor(
        named: "tertiary-700", in: Bundle.module, compatibleWith: nil
    )!
}
