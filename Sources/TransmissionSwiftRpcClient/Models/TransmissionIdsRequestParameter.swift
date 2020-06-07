import Foundation

public enum TransmissionIdsRequestParameter: Encodable {
  public enum HashOrId: Encodable {
    case hash(TorrentHash)
    case id(TorrentId)

    public func encode(to encoder: Encoder) throws {
      var container = encoder.singleValueContainer()
      switch self {
      case .hash(let hash):
        try container.encode(hash)
      case .id(let id):
        try container.encode(id)
      }
    }
  }
  case torrent(id: TorrentId)
  case torrentIds([TorrentId])
  case torrentHashes([TorrentHash])
  case torrentHashOrIds([HashOrId])
  case recentlyActive

  public func encode(to encoder: Encoder) throws {
    switch self {
    case .torrent(id: let torrentId):
      var container = encoder.singleValueContainer()
      try container.encode(torrentId)
    case .torrentIds(let torrentIds):
      var container = encoder.unkeyedContainer()
      try container.encode(contentsOf: torrentIds)
    case .torrentHashes(let torrentHashes):
      var container = encoder.unkeyedContainer()
      try container.encode(contentsOf: torrentHashes)
    case .torrentHashOrIds(let hashOrIds):
      var container = encoder.unkeyedContainer()
      try container.encode(contentsOf: hashOrIds)
    case .recentlyActive:
      var container = encoder.singleValueContainer()
      try container.encode("recently-active")
    }
  }
}
