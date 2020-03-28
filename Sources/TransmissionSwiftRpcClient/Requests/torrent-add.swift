import Foundation
import Combine

public struct AddTorrentRequestArguments: Encodable {
  public let metainfo: String
  public let isPaused: Bool
  public let downloadFolderUrl: URL

  public init(content: String, isPaused: Bool, downloadFolderUrl: URL) {
    self.metainfo = Data(content.utf8).base64EncodedString()
    self.isPaused = isPaused
    self.downloadFolderUrl = downloadFolderUrl
  }
}

public struct AddTorrentResponseArguments: Decodable {

}

public extension TransmissionSwiftRpcClient {
  func addTorrent(
    _ arguments: AddTorrentRequestArguments,
    tag: TransmissionRequestTag? = nil
  ) -> AnyPublisher<TransmissionResponse<AddTorrentResponseArguments>, Error> {
    rpc(method: .addTorrent, tag: tag, arguments: arguments)
  }
}
