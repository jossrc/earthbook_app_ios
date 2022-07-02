//
//  JSAutor.swift
//  earthbook
//
//  Created by CARLOS LOZANO ARANCIAGA on 7/2/22.
//

import Foundation

struct JSAutor: Codable {
    let id: Int
    let nombreCompleto, biografia: String

    enum CodingKeys: String, CodingKey {
        case id
        case nombreCompleto = "nombre_completo"
        case biografia
    }
}
