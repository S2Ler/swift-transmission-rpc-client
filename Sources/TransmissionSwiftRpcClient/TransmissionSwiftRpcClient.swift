import Networker
import Combine
import Foundation
import Logging

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

  public let logger: Logger?
  private let configuration: Configuration
  private let dispatcher: Networker.Dispatcher

  @RWAtomic
  private var sessionId: String = ""

  public init(
    configuration: Configuration,
    dispatcher: Networker.Dispatcher,
    logger: Logger?
  ) {
    self.configuration = configuration
    self.dispatcher = dispatcher
    self.logger = logger
    dispatcher.add(sessionIdPluging())
  }

  public convenience init(configuration: Configuration = .default,
                          logger: Logger? = nil) {
    self.init(
      configuration: configuration,
      dispatcher: Self.createDispatcher(logger: logger),
      logger: logger
    )
  }

  internal func rpc<RequestArguments, ResponseArguments>(
    method: RpcMethod,
    tag: TransmissionRequestTag?,
    arguments: RequestArguments?
  ) -> AnyPublisher<TransmissionResponse<ResponseArguments>, Error>
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
    return dispatcher
      .dispatch(request)
      .catch { [unowned self] (error: Error) -> AnyPublisher<TransmissionResponse<ResponseArguments>, Error> in
        if let transmissionError = error as? TransmissionError {
          if case .statusCodeError(let httpResponse) = transmissionError,
            httpResponse.statusCode == 409 {
            self.sessionId = httpResponse.value(forHTTPHeaderField: "X-Transmission-Session-Id") ?? ""
            return self.dispatcher.dispatch(request)
          }
          else {
            return Fail(error: transmissionError).eraseToAnyPublisher()
          }
        }
        else {
          return Fail(error: error).eraseToAnyPublisher()
        }
    }.eraseToAnyPublisher()
  }

  private static func createDispatcher(logger: Logger?) -> Dispatcher {
    URLSessionDispatcher(jsonBodyEncoder: JSONEncoder(),
                         plugins: [],
                         logger: logger)
  }

  private func sessionIdPluging() -> DispatcherPlugin {
    InjectHeaderPlugin(headerField: "X-Transmission-Session-Id",
                       dynamicValue: { [weak self] in self?.sessionId ?? "" })
  }
}
