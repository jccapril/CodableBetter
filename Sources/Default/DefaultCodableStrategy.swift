/// Provides a default value for missing `Decodable` data.
///
/// `DefaultCodableStrategy` provides a generic strategy type that the `DefaultCodable` property wrapper can use to provide
/// a reasonable default value for missing Decodable data.
public protocol DefaultCodableStrategy {
    associatedtype DefaultValue: Decodable

    /// The fallback value used when decoding fails
    static var defaultValue: DefaultValue { get }
}
