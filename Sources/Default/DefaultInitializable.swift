public protocol Initializable: Codable {
    init()
}

public enum DefaultInitializableStrategy<T: Initializable>: DefaultCodableStrategy {
    public static var defaultValue: T { T() }
}

/// Decodes values with `T()` value of `Initializable` protocol conformed type instead of nil if applicable
///
/// `@DefaultInit` decodes values and returns an `T()` value instead of nil if the Decoder is unable to decode the container.
public typealias DefaultInitialize<T> = DefaultCodable<DefaultInitializableStrategy<T>> where T: Initializable
