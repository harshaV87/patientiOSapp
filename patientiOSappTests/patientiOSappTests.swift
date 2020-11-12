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
        case parsing = "Problem with the parsing"
    }
    
    func testResponse() {
        // Prepare mock response.
        let name = "Tracey"

        let jsonString = """
                            {
                              "resourceType": "Bundle",
                              "id": "0c36112c-05ef-403b-a06e-bf3ba80c2430",
                              "meta": {
                                "lastUpdated": "2020-11-12T19:57:20.264+00:00"
                              },
                              "type": "searchset",
                              "link": [ {
                                "relation": "self",
                                "url": "http://hapi.fhir.org/baseR4/Patient?_count=1&_format=json&_pretty=true"
                              }, {
                                "relation": "next",
                                "url": "http://hapi.fhir.org/baseR4?_getpages=0c36112c-05ef-403b-a06e-bf3ba80c2430&_getpagesoffset=1&_count=1&_format=json&_pretty=true&_bundletype=searchset"
                              } ],
                              "entry": [ {
                                "fullUrl": "http://hapi.fhir.org/baseR4/Patient/1243787",
                                "resource": {
                                  "resourceType": "Patient",
                                  "id": "1243787",
                                  "meta": {
                                    "versionId": "1",
                                    "lastUpdated": "2020-06-22T07:30:12.916+00:00",
                                    "source": "#xxqDsKRviFEgRN38"
                                  },
                                  "text": {
                                    "status": "generated",
                                    "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><div class=\"hapiHeaderText\">Tracey <b>BAKER </b></div><table class=\"hapiPropertyTable\"><tbody><tr><td>Identifier</td><td>CT13770</td></tr></tbody></table></div>"
                                  },
                                  "identifier": [ {
                                    "type": {
                                      "coding": [ {
                                        "system": "http://terminology.hl7.org/CodeSystem/v2-0203",
                                        "code": "MR",
                                        "display": "Medical Record Number"
                                      } ],
                                      "text": "Medical Record Number"
                                    },
                                    "value": "CT13770"
                                  }, {
                                    "type": {
                                      "coding": [ {
                                        "system": "http://terminology.hl7.org/CodeSystem/v2-0203",
                                        "code": "NIIP",
                                        "display": "National Insurance Payor Identifier"
                                      } ],
                                      "text": "National Insurance Payor Identifier"
                                    },
                                    "value": "9800009087"
                                  } ],
                                  "name": [ {
                                    "family": "Baker",
                                    "given": [ "Tracey" ]
                                  } ],
                                  "gender": "female"
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
            
            print(result)
          switch result {
          case .success(let post):
            XCTAssertEqual(post.entry?.first?.resource?.name?.first?.given?.first, name, "Tracey")
            
        
          case .failure(let error):
            XCTFail("Error was not expected: \(error)")
          }
          self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
      }
    

    func testParsingFailure() {
        // Prepare response
      
        
        let data = Data()

        
        MockURLProtocol.requestHandler = { request in
          let response = HTTPURLResponse(url: self.apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
          return (response, data)
        }
        
        // Call API.
        postDetailAPI.fetchPostDetail { (result) in
          switch result {
          case .success(_):
            XCTFail("Success response was not expected.")
          case .failure(let error):
            guard let error = error as? APIResponseError else {
              XCTFail("Incorrect error received.")
              self.expectation.fulfill()
              return
            }
            
            XCTAssertEqual(error, APIResponseError.parsing, "Parsing error was expected.")
          }
          self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
      }
    
}
