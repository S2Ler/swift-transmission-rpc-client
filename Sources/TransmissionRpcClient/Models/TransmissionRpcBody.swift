import Foundation

internal struct TransmissionRpcBody<Arguments: Encodable>: Encodable {
  let arguments: Arguments?
  let tag: TransmissionRequestTag?
  let method: RpcMethod
}
