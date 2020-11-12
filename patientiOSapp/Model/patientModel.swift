//
//  patientModel.swift
//  patientiOSapp
//
//  Created by Venkata harsha Balla on 11/10/20.
//

import Foundation
import UIKit

// Complete model is build so that any fields can be parsed out with the same model in the future corresponding to the JSON tree structure
// confirmed to decodable to easily parse and the propoerties are made optional to make sure the parsing wont fail even if some keys and/or values are missing in the incoming data from the API

struct PateintInfo: Decodable {
    let resourceType, id: String?
    let meta: PateintInfoMeta?
    let type: String?
    let link: [Link]?
    let entry: [Entry]?
}

struct Entry: Decodable {
    let fullURL: String?
    let resource: Resource?
    let search: Search?

}

struct Resource: Decodable {
    let resourceType: String?
    let id: String?
    let meta: ResourceMeta?
    let text: Text?
    let name: [Name]?
    let telecom: [Telecom]?
    let gender: String?
    let birthDate: String?
    let address: [Address]?
}

struct Address: Decodable {
    let line: [String]?
    let city: String?
    let state: String?
    let postalCode: String?
    let country: String?
}



struct ResourceMeta: Decodable {
    let metaExtension: [Extension]?
    let versionID, lastUpdated: String?

}

struct Extension: Decodable {
    let url: String?
    let valueURI: String?

}

struct Name: Decodable {
    let given: [String]?
    let use: String?
    let text: String?
    let family: String?
}


struct Telecom: Decodable {
    let system: String?
    let value: String?
    let use: String?
}



struct Text: Decodable {
    let status: String?
    let div: String?
}


struct Search: Decodable {
    let mode: String?
}

struct Link: Decodable {
    let relation: String?
    let url: String?
}

struct PateintInfoMeta: Decodable {
    let lastUpdated: String?
}

