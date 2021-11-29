import Foundation
import TransmissionRpcClient
import Combine
import Logging

var logger = Logger(label: "swift-transmission-rpc-client")
logger.logLevel = .debug

let client = TransmissionSwiftRpcClient(configuration: .default, logger: logger)

var cancels: [AnyCancellable] = []

Task {
    do {
        let response = try await client.getFullTorrent(ids: .allTorrents)
        logger.log(level: .debug, "\(response.arguments!)")
        logger.log(level: .info, "Success")
    }
    catch {
        logger.log(level: .error, "Failure: \(error)")
    }
}

RunLoop.main.run()
