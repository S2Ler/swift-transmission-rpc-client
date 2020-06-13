import Foundation

public struct Torrent: Decodable {
  public let id: TorrentId
  public let name: String
  public let hash: TorrentHash
  public let activityDate: Date
  public let addedDate: Date
  public let bandwidthPriority: Int
  public let comment: String
  public let corruptEver: Int
  public let creator: String
  public let dateCreated: Date
  public let desiredAvailable: Int
  public let doneDate: Date
  public let downloadDir: String
  public let downloadedEver: Int
  public let downloadLimit: Int
  public let downloadLimited: Bool
  public let editDate: Date?
  public let error: Int
  @DecodeAsNilIf<String, DecodeAsNilIfEmptyString>  public var errorString: String?

  /// If downloading, estimated number of seconds left until the torrent is done.
  /// If seeding, estimated number of seconds left until seed ratio is reached.
  @DecodeAsNilIf<TimeInterval, DecodeAsNilForTimeInterval> public var eta: TimeInterval?

  /// If seeding, number of seconds left until the idle time limit is reached.
  @DecodeAsNilIf<TimeInterval, DecodeAsNilForTimeInterval> public var etaIdle: TimeInterval?

  public let files: [Torrent.File]

  public let fileStats: [Torrent.FileStats]
}

public extension Torrent {
  struct File: Decodable {
    public let bytesCompleted: Int
    public let length: Int
    public let name: String
  }

  struct FileStats: Decodable {
    public let bytesCompleted: Int
    public let wanted: Bool
    public let priority: Int
  }
}
