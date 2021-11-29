import Networker

typealias TransmissionRequest<RequestArguments: Encodable, ResponseArguments: Decodable>
  = Networker.Request<TransmissionResponse<ResponseArguments>, TransmissionResponseDecoder>
