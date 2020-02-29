import Networker
import Combine
import Foundation

public class TransmissionSwiftRpcClient {
  public struct Configuration {
    public let cachePolicy: URLRequest.CachePolicy
    public let timeout: TimeInterval
    public let rpcUrl: URL

    public static var `default`: Configuration {
      .init(
        cachePolicy: .useProtocolCachePolicy,
        timeout: 60,
        rpcUrl: URL(string: "http://localhost:9091/transmission/rpc")!
      )
    }

    public init(cachePolicy: URLRequest.CachePolicy, timeout: TimeInterval, rpcUrl: URL) {
      self.cachePolicy = cachePolicy
      self.timeout = timeout
      self.rpcUrl = rpcUrl
    }
  }

  private let configuration: Configuration
  private let dispatcher: Networker.Dispatcher

  public init(
    configuration: Configuration,
    dispatcher: Networker.Dispatcher
  ) {
    self.configuration = configuration
    self.dispatcher = dispatcher
  }

  public init(configuration: Configuration = .default) {
    self.configuration = .default
    self.dispatcher = Self.createDispatcher()
  }

  internal func rpc<RequestArguments, ResponseArguments>(
    method: RpcMethod,
    tag: TransmissionRequestTag?,
    arguments: RequestArguments?
  ) -> AnyPublisher<TransmissionResponse<ResponseArguments>, TransmissionError>
    where
    RequestArguments: Encodable,
    ResponseArguments: Decodable
  {
    let body = TransmissionRpcBody<RequestArguments>(arguments: arguments, tag: tag, method: method)
      let request: TransmissionRequest<RequestArguments, ResponseArguments> = .init(
        baseUrl: configuration.rpcUrl,
        path: "",
        urlParams: nil,
        httpMethod: .post,
        body: .json(body),
        headers: [:],
        timeout: configuration.timeout,
        cachePolicy: configuration.cachePolicy
      )
      return dispatcher.dispatch(request)
  }

  private static func createDispatcher() -> Dispatcher {
    URLSessionDispatcher(plugins: [])
  }
}
