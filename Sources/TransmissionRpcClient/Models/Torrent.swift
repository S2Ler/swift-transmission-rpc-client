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

  /// If downloading, estimated Int of seconds left until the torrent is done.
  /// If seeding, estimated Int of seconds left until seed ratio is reached.
  @DecodeAsNilIf<TimeInterval, DecodeAsNilForTimeInterval> public var eta: TimeInterval?

  /// If seeding, Int of seconds left until the idle time limit is reached.
  @DecodeAsNilIf<TimeInterval, DecodeAsNilForTimeInterval> public var etaIdle: TimeInterval?

  public let files: [Torrent.File]

  public let fileStats: [Torrent.FileStats]

  /// Byte count of all the partial piece data we have for this torrent.
  ///  As pieces become complete, this value may decrease as portions of it
  ///  are moved to `corrupt' or `haveValid'.
  public let haveUnchecked: Int

  public let haveValid: Int
  public let honorsSessionLimits: Bool
  public let isFinished: Bool
  public let isPrivate: Bool
  public let isStalled: Bool
  public let labels: [String]
  public let leftUntilDone: Int
  public let magnetLink: String
  @DecodeAsNilIf<Date, DecodeAsNilForDate> public var manualAnnounceTime: Date?
  public let maxConnectedPeers: Int
  public let metadataPercentComplete: Float
  public let peerLimit: Int
  public let peers: [Torrent.Peer]
  public let peersConnected: Int
  public let peersFrom: Torrent.PeersFrom

  public let peersGettingFromUs: Int
  public let peersSendingToUs: Int
  public let percentDone: Float
  public let pieces: String
  public let pieceCount: Int
  public let pieceSize: Int
  public let priorities: [Int]
  public let queuePosition: Int
  public let rateDownload: Int
  public let rateUpload: Int
  public let recheckProgress: Float
  public let secondsDownloading: Int
  public let secondsSeeding: Int
  public let seedIdleLimit: Int
  public let seedIdleMode: Int
  public let seedRatioLimit: Float
  public let seedRatioMode: Int
  public let sizeWhenDone: Int
  public let startDate: Date
  public let status: Int
  public let trackers: [Torrent.Tracker]
  public let trackerStats: [Torrent.TrackerStats]
  public let totalSize: Int
  public let torrentFile: String
  public let uploadedEver: Int
  public let uploadLimit: Int
  public let uploadLimited: Bool
  public let uploadRatio: Float
  @DecodeArrayOfNumbersAsBools public var wanted: [Bool]
  public let webseeds: [String]
  public let webseedsSendingToUs: Int
}

public extension Torrent {
  struct File: Decodable {
    public let bytesCompleted: Int
    public let length: Int
    public let name: String
  }

  struct FileStats: Decodable {
    public let bytesCompleted: Int
    public var wanted: Bool
    public let priority: Int
  }

  struct Peer: Decodable {
    public let address: String
    public let clientName: String
    public let clientIsChoked: Bool
    public let clientIsInterested: Bool
    public let flagStr: String
    public let isDownloadingFrom: Bool
    public let isEncrypted: Bool
    public let isIncoming: Bool
    public let isUploadingTo: Bool
    public let isUTP: Bool
    public let peerIsChoked: Bool
    public let peerIsInterested: Bool
    public let port: Int
    public let progress: Float
    public let rateToClient: Int
    public let rateToPeer: Int
  }

  struct PeersFrom: Decodable {
    public let fromCache: Int
    public let fromDht: Int
    public let fromIncoming: Int
    public let fromLpd: Int
    public let fromLtep: Int
    public let fromPex: Int
    public let fromTracker: Int
  }

  struct Tracker: Decodable {
    public let announce: String
    public let id: Int
    public let scrape: String
    public let tier: Int
  }

  struct TrackerStats: Decodable {
    public let announce: String
    public let announceState: Int
    public let downloadCount: Int
    public let hasAnnounced: Bool
    public let hasScraped: Bool
    public let host: String
    public let id: Int
    public let isBackup: Bool
    public let lastAnnouncePeerCount: Int
    public let lastAnnounceResult: String
    public let lastAnnounceStartTime: Int
    public let lastAnnounceSucceeded: Bool
    public let lastAnnounceTime: Int
    public let lastAnnounceTimedOut: Bool
    public let lastScrapeResult: String
    public let lastScrapeStartTime: Int
    public let lastScrapeSucceeded: Bool
    public let lastScrapeTime: Int
    @DecodeNumberAsBool public var lastScrapeTimedOut: Bool
    public let leecherCount: Int
    public let nextAnnounceTime: Int
    public let nextScrapeTime: Int
    public let scrape: String
    public let scrapeState: Int
    public let seederCount: Int
    public let tier: Int
  }
}
