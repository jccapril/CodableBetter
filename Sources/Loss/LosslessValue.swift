/// Decodes Codable values into their respective preferred types.
///
/// `@LosslessValue` attempts to decode Codable types into their respective preferred types while preserving the data.
///
/// This is useful when data may return unpredictable values when a consumer is expecting a certain type. For instance,
/// if an API sends SKUs as either an `Int` or `String`, then a `@LosslessValue` can ensure the types are always decoded
/// as `String`s.
///
/// ```
/// struct Product: Codable {
///   @LosslessValue var sku: String
///   @LosslessValue var id: String
/// }
///
/// // json: { "sku": 87, "id": 123 }
/// let value = try JSONDecoder().decode(Product.self, from: json)
/// // value.sku == "87"
/// // value.id == "123"
/// ```
public typealias LosslessValue<T> = LosslessValueCodable<LosslessDefaultStrategy<T>> where T: LosslessStringCodable
