//
//  MAHomeEntity.swift
//  MovieApp
//
//  Created by jose perez on 14/03/22.
//
import Foundation
import BackServices
/// Clase que sirve como metodo de llenado de tabla
final class MATVShowDataSource {
    /// Titulo de serie.
    var title: String
    ///  URL para descargar la imagen.
    var imgUrl: String
    public init (tvshow: BSTVShowsEntity) {
        self.title = tvshow.name ?? "Default"
        self.imgUrl = tvshow.image?.medium ?? ""
    }
}
/// Enumerdador de flujo
enum MAShowFlow: String {
    case all = "TV Shows"
    case favorite = "Favorites"
}
