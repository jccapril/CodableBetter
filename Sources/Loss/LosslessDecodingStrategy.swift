/// Provides an ordered list of types for decoding the lossless value, prioritizing the first type that successfully decodes as the inferred type.
///
/// `LosslessDecodingStrategy` provides a generic strategy that the `LosslessValueCodable` property wrapper can use to provide
/// the ordered list of decodable types in order to maximize preservation for the inferred type.
public protocol LosslessDecodingStrategy {
    associatedtype Value: LosslessStringCodable

    /// An ordered list of decodable scenarios used to infer the encoded type
    static var losslessDecodableTypes: [(Decoder) -> LosslessStringCodable?] { get }
}
