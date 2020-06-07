import Foundation

public enum TransmissionResponseTorrentsFormat: Encodable {
  /// "torrents" will be an array of objects, each of which contains
  /// the key/value pairs matching the request's "fields" arg. This was
  /// the only format before Transmission 3 and has some obvious programmer
  /// conveniences, such as parsing directly into Javascript objects.
  case objects


  /// "torrents" will be an array of arrays. The first row holds the keys and
  /// each remaining row holds a torrent's values for those keys. This format
  /// is more efficient in terms of JSON generation and JSON parsing.
  case table

  public func encode(to encoder: Encoder) throws {
    var c = encoder.singleValueContainer()
    switch self {
    case .objects:
      try c.encode("objects")
    case .table:
      try c.encode("table")
    }
  }
}
