//
//  dataAPI.swift
//  patientiOSapp
//
//  Created by Venkata harsha Balla on 11/10/20.
//

import Foundation


final class DataAPI {
    
    // Data parsing from the URL given in the task. The implementation is for both data parsing and for writing test cases
    
    // PS: THE TEST SERVER URL gives out no data sometimes - hence you maysee that none of the fields have any names or any details associated with it. it is a result of the lack of data provided by the test server. 
    
    enum APIResponseError: String, Error {
        case network = "Problem with the network"
        case parsing = "Problem with the data parsing"
    }
    
    let urlSession: URLSession
      
      init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
      }
      
      func fetchPostDetail(completion: @escaping (_ result: Result<PateintInfo, Error>) -> Void) {
        let url = URL(string: "http://hapi.fhir.org/baseR4/Patient?_count=10&_pretty=true")!
        let dataTask = urlSession.dataTask(with:url) { (data, urlResponse, error) in
          do{
            // Check if any error occured.
            if let error = error {
              throw error
            }

            // Check response code.
            guard let httpResponse = urlResponse as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
              completion(Result.failure(APIResponseError.network))
              return
            }

            // Parse data
            if let responseData = data, let object = try? JSONDecoder().decode(PateintInfo.self, from: responseData) {
              completion(Result.success(object))
            } else {
              throw APIResponseError.parsing
            }
          }catch{
            completion(Result.failure(error))
          }
        }

        dataTask.resume()
      }
      
    
}
