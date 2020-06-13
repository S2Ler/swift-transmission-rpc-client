import Foundation
import TransmissionSwiftRpcClient
import Combine
import Logging

var logger = Logger(label: "TransmissionSwiftRpcClient")
logger.logLevel = .debug

let client = TransmissionSwiftRpcClient(configuration: .default, logger: logger)

var cancels: [AnyCancellable] = []
client.getFullTorrent(ids: .allTorrents).sink(receiveCompletion: { (completion) in
  logger.log(level: .info, "Completion called: \(completion)")
}) { (response) in
  switch response.result {
  case .success:
    logger.log(level: .debug, "\(response.arguments!)")
    logger.log(level: .info, "Success")
  case .failure(let error):
    logger.log(level: .error, "Failure: \(error)")
  }
}.store(in: &cancels)

RunLoop.main.run()
