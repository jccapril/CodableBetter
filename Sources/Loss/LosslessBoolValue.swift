/// Decodes Codable values into their respective preferred types.
///
/// `@LosslessBoolValue` attempts to decode Codable types into their respective preferred types while preserving the data.
///
/// - Note:
///  This uses a `LosslessBooleanStrategy` in order to prioritize boolean values, and as such, some integer values will be lossy.
///
///  For instance, if you decode `{ "some_type": 1 }` then `some_type` will be `true` and not `1`. If you do not want this
///  behavior then use `@LosslessValue` or create a custom `LosslessDecodingStrategy`.
///
/// ```
/// struct Example: Codable {
///   @LosslessBoolValue var foo: Bool
///   @LosslessValue var bar: Int
/// }
///
/// // json: { "foo": 1, "bar": 2 }
/// let value = try JSONDecoder().decode(Fixture.self, from: json)
/// // value.foo == true
/// // value.bar == 2
/// ```
public typealias LosslessBoolValue<T> = LosslessValueCodable<LosslessBooleanStrategy<T>> where T: LosslessStringCodable
