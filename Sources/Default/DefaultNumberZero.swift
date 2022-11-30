public struct DefaultNumberZeroStrategy<T: Codable & Numeric>: DefaultCodableStrategy {
    public static var defaultValue: T { T(exactly: 0).unsafelyUnwrapped }
}

/// Decodes Numbers returning zero instead of nil if applicable
///
/// `@DefaultNumberZero` decodes Numbers and returns zero instead of nil if the Decoder is unable to decode the
/// container.
public typealias DefaultNumberZero<T> = DefaultCodable<DefaultNumberZeroStrategy<T>> where T: Codable & Numeric
