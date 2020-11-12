//
//  patientiOSappTests.swift
//  patientiOSappTests
//
//  Created by Venkata harsha Balla on 11/10/20.
//

import XCTest
@testable import patientiOSapp

class patientiOSappTests: XCTestCase {

    var postDetailAPI: DataAPI!
      var expectation: XCTestExpectation!
      let apiURL = URL(string: "http://hapi.fhir.org/baseR4/Patient?_count=10&_pretty=true")!
      
      override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        postDetailAPI = DataAPI(urlSession: urlSession)
        expectation = expectation(description: "Expectation")
      }
    
    enum APIResponseError: String, Error {
        case network = "Problem with the network"
        case request = "Problem with the URL request"
    }
    
    func testResponse() {
        // Prepare mock response.
        let name = "aaa"

        let jsonString = """
                         {
                           "resourceType": "Bundle",
                           "id": "bc5be61a-9c0d-40d1-bad0-c3114d9d1b57",
                           "meta": {
                             "lastUpdated": "2020-11-12T06:22:26.688+00:00"
                           },
                           "type": "searchset",
                           "link": [ {
                             "relation": "self",
                             "url": "http://hapi.fhir.org/baseR4/Patient?_count=1&_pretty=true"
                           }, {
                             "relation": "next",
                             "url": "http://hapi.fhir.org/baseR4?_getpages=bc5be61a-9c0d-40d1-bad0-c3114d9d1b57&_getpagesoffset=1&_count=1&_pretty=true&_bundletype=searchset"
                           } ],
                           "entry": [ {
                             "fullUrl": "http://hapi.fhir.org/baseR4/Patient/619077",
                             "resource": {
                               "resourceType": "Patient",
                               "id": "619077",
                               "meta": {
                                 "versionId": "1",
                                 "lastUpdated": "2020-02-10T16:19:18.874+00:00",
                                 "source": "#x7aJ5XGr95yChaWE"
                               },
                               "language": "aa",
                               "text": {
                                 "status": "generated",
                                 "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><div class=\"hapiHeaderText\">aa <b>AA </b></div><table class=\"hapiPropertyTable\"><tbody/></table></div>"
                               },
                               "name": [ {
                                 "family": "aa",
                                 "given": [ "aaa" ]
                               } ]
                             },
                             "search": {
                               "mode": "match"
                             }
                           } ]
                           }
                         """
        let data = jsonString.data(using: .utf8)

        MockURLProtocol.requestHandler = { request in
          guard let url = request.url, url == self.apiURL else {
            throw APIResponseError.request
            
          }

          let response = HTTPURLResponse(url: self.apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
          return (response, data)
        }

        // Call API.
        postDetailAPI.fetchPostDetail { (result) in
          switch result {
          case .success(let post):
            XCTAssertEqual(post.entry?.first?.resource?.name?.first?.given?.first, name, "aaa")

          case .failure(let error):
            XCTFail("Error was not expected: \(error)")
          }
          self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
      }
    

}
