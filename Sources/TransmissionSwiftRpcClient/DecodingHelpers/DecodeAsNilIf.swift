import Foundation

public protocol DecodeAsNilIfPredicate {
  associatedtype Subject

  /// Returns true if `Subject` should be decoded as nil
  static func decodeAsNilIfPredicate(subject: Subject) -> Bool
}

@propertyWrapper
public struct DecodeAsNilIf<T: Decodable, Predicate: DecodeAsNilIfPredicate>: Decodable where Predicate.Subject == T {
  public let wrappedValue: T?

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let subject = try container.decode(T.self)
    if Predicate.decodeAsNilIfPredicate(subject: subject) {
      wrappedValue = nil
    }
    else {
      wrappedValue = subject
    }
  }
}

extension DecodeAsNilIf: CustomStringConvertible where T: CustomStringConvertible {
  public var description: String {
    wrappedValue?.description ?? "nil"
  }
}

// MARK: - Implementations

public struct DecodeAsNilForTimeInterval: DecodeAsNilIfPredicate {
  public static func decodeAsNilIfPredicate(subject: TimeInterval) -> Bool {
    subject == -1
  }
}

public struct DecodeAsNilIfEmptyString: DecodeAsNilIfPredicate {
  public static func decodeAsNilIfPredicate(subject: String) -> Bool {
    subject.isEmpty
  }
}

public struct DecodeAsNilForDate: DecodeAsNilIfPredicate {
  public static func decodeAsNilIfPredicate(subject: Date) -> Bool {
    subject.timeIntervalSince1970 == -1
  }
}
