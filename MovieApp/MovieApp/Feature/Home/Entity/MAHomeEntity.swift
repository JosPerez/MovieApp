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
    /// Variable que almacena si es favorita
    var isFavorite: Bool
    /// Entidad completa de tvshows.
    var tvshowEntity: BSTVShowsEntity
    ///
    public init (tvshow: BSTVShowsEntity, isFavorite: Bool = false) {
        self.title = tvshow.name ?? "Default"
        self.imgUrl = tvshow.image?.medium ?? ""
        self.isFavorite = isFavorite
        self.tvshowEntity = tvshow
    }
}
/// Enumerdador de flujo
enum MAShowFlow: String {
    case all = "TV Shows"
    case favorite = "Favorites"
}
