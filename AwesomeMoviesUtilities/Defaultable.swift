public protocol Defaultable: RawRepresentable, Hashable where RawValue == String {
    static var `default`: Self { get }
}
