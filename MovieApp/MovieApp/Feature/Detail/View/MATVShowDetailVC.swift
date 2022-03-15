//
//  MATVShowDetailVC.swift
//  MovieApp
//
//  Created by jose perez on 15/03/22.
//
import UIKit
import BackServices
final class MATVShowDetailVC: BaseController {
    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var tvshowTitle: UILabel!
    @IBOutlet private weak var tvshowSummary: UILabel!
    @IBOutlet private weak var tvshowRatng: UILabel!
    @IBOutlet private weak var lblRating: UILabel!
    @IBOutlet private weak var lblGenreList: UILabel!
    @IBOutlet private weak var lblCategory: UILabel!
    @IBOutlet private weak var viewIMDbLinks: UIView!
    var presenter: MATVShowDetailPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    /// Función encargada ce asignar datos a la vista
    private func setupView() {
        self.title = "Detalle del show"
        if let entity = self.presenter?.entity {
            self.setFavoriteBarButton(isFavorite: entity.isFavorite)
            self.navigationController?.setNavBarColor( .blue)
            self.tvshowTitle.text = entity.title
            self.imgView.setImage(url: entity.tvshowEntity.image?.original ?? entity.imgUrl, placeholderImage: UIImage(systemName: "cloud"),contentMode: .scaleToFill)
            setAttributedTextSummary(text: entity.tvshowEntity.summary)
            setRatinglbl(rating: entity.tvshowEntity.rating?.average)
            setListGenre(list: entity.tvshowEntity.genres)
            setExternalLinks(link: entity.tvshowEntity.externals?.codeIMDB)
        }
    }/// Función para mostrar los links necesarios
    ///
    private func setExternalLinks(link: String?) {
        self.viewIMDbLinks.isHidden = link == nil
    }
    /// Muestra el rating en caso de contar con uno
    ///  - Parameter rating: Rating del show.
    private func setRatinglbl(rating: Double?) {
        if let rating = rating {
            self.tvshowRatng.text = String(rating) + "/10"
        } else {
            self.lblRating.isHidden = true
        }
    }
    /// Asigna el texto con caracteristicas de HTML
    ///  - Parameter text: Texto con estilo HTML.
    private func setAttributedTextSummary(text: String?) {
        guard let data = text?.data(using: String.Encoding.utf8) else {
            self.tvshowSummary.text = text
            return
        }
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [.documentType: NSAttributedString.DocumentType.html,
                                                                            .characterEncoding: String.Encoding.utf8.rawValue]
        do {
            let atrributedText: NSMutableAttributedString = try NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
            atrributedText.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.label],
                                              range: NSMakeRange(0, atrributedText.length))
            self.tvshowSummary.attributedText = atrributedText
        } catch let error {
            print(error)
            self.tvshowSummary.text = text
        }
    }
    /// Función que configura  el  boton de favorito
    ///  - Parameter isFavorite: Es favorito
    func setFavoriteBarButton(isFavorite: Bool) {
        let image: UIImage? = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        let barButtom: UIBarButtonItem = UIBarButtonItem(image: image, landscapeImagePhone: image, style: .plain, target: self, action: #selector(storedShow))
        self.navigationItem.rightBarButtonItem = barButtom
    }
    /// Actualiza almacenamiento de de peliculas.
    @objc func storedShow() {
        if self.presenter?.entity?.isFavorite == true {
            self.presenter?.deleteFavorite()
        } else {
            self.presenter?.saveFavorite()
        }
    }
    private func setListGenre(list: [BSGenreType]?) {
        if let list = list {
            let bulletUnicode: String = "\u{2022} "
            var mainText: String = ""
            for item in list {
                mainText += bulletUnicode + item.rawValue + "\n"
            }
            self.lblGenreList.text = mainText
        } else {
            self.lblCategory.isHidden = true
            self.lblGenreList.isHidden = true
        }
    }
    @IBAction func showExternalLink(_ sender: Any) {
        if let id = self.presenter?.entity?.tvshowEntity.externals?.codeIMDB {
            self.presenter?.openBrowserWith(id: id)
        }
    }
}
extension MATVShowDetailVC: MATVShowDetailViewProtocol {
    func showMessageSucces(message: String, isFavorite: Bool) {
        self.showToast(message: message, font: UIFont(name: "Helvetica", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0))
        let image: UIImage? = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        self.navigationItem.rightBarButtonItem?.image = image
    }
    func showMessageFailed(message: String) {
        if self.presenter?.entity?.isFavorite == true {
            self.showMainAlert(description: "There was a problem saving/deleting this TV Show. Do you want to try again?", complation: self.presenter?.deleteFavorite)
        } else {
            self.showMainAlert(description: "There was a problem saving/deleting this TV Show. Do you want to try again?", complation: self.presenter?.saveFavorite)
        }
    }
}
