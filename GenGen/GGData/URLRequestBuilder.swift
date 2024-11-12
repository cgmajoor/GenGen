//
//  URLRequestBuilder.swift
//  GenGen
//
//  Created by Ceren Majoor on 12/11/2024.
//

import Foundation

class URLRequestBuilder {
    private var url: URL
    private var httpMethod: String
    private var headers: [String: String]
    private var body: [String: Any]?

    init(url: URL) {
        self.url = url
        self.httpMethod = "GET"
        self.headers = [:]
    }

    func setMethod(_ method: String) -> Self {
        self.httpMethod = method
        return self
    }

    func addHeader(key: String, value: String) -> Self {
        self.headers[key] = value
        return self
    }

    func setBody(_ body: [String: Any]) -> Self {
        self.body = body
        return self
    }

    func build() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }

        return request
    }
}
