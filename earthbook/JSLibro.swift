//
//  JSLibro.swift
//  earthbook
//
//  Created by CARLOS LOZANO ARANCIAGA on 7/2/22.
//

import Foundation

struct JSLibro: Codable {
    let id: Int
    let titulo, descripcion: String
    let paginas: Int
    let imagen: String
    let autor: JSAutor
    let editorial: String
    let categoria: JSCategoria
    let isbn, sku: String
}
