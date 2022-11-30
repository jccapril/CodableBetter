public struct DefaultFirstCaseStrategy<T: Codable & CaseIterable>: DefaultCodableStrategy {
    public static var defaultValue: T { T.allCases.first.unsafelyUnwrapped }
}

/// Decodes Enums returning the first case instead of nil if applicable
///
/// `@DefaultFirstCase` decodes Enums and returns the first case instead of nil if the Decoder is unable to decode the
/// container.
public typealias DefaultFirstCase<T> = DefaultCodable<DefaultFirstCaseStrategy<T>> where T: Codable & CaseIterable
