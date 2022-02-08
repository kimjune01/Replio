//
//  Evaluator.swift
//  Replios
//
//  Created by June Kim on 2/8/22.
//

import Foundation
import Alamofire

struct RequestParams: Encodable {
  let language: String = "python"
  let command: String
}

struct ResponseParams: Decodable {
  let result: String
}

class Evaluator {
  static let endpointUrl = URL(string:"https://eval-backend.junekim6.repl.co/exec")!
  static var request: DataRequest? {
    didSet {
      oldValue?.cancel()
    }
  }
  static var isRequesting: Bool {
    return request != nil
  }
  static func evaluate(_ command: String, _ completion: @escaping (String?)->()) {
    let params = RequestParams(command: command)
    request = AF.request(endpointUrl, method: .put, parameters: params, encoder: .json) { request in
      request.timeoutInterval = 5
    }.responseDecodable(of: ResponseParams.self) { response in
      switch response.result {
      case .failure(let e):
        completion(nil)
      case .success(let jsonResponse):
        completion(jsonResponse.result)
      }
      self.request = nil
    }
  }
}
