import Foundation
import TransmissionSwiftRpcClient
import Combine

let client = TransmissionSwiftRpcClient(configuration: .default)
let params = GetTorrentRequestArguments(ids: nil, fields: ["name", "hashString", "id"], format: .objects)

var cancels: [AnyCancellable] = []
client.getTorrent(params).sink(receiveCompletion: { (completion) in
  print(completion)
}) { (response) in
  switch response.result {
  case .success:
    let arguments = response.arguments!
    print(dump(arguments))
  case .failure(let error):
    print(error)
  }
  print(response)
}.store(in: &cancels)

RunLoop.main.run()
