//
//  MATVShowCell.swift
//  MovieApp
//
//  Created by jose perez on 14/03/22.
//
import UIKit
final class MATVShowCell: UITableViewCell {
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var imgView: UIImageView!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    func setupCell(entity: MATVShowDataSource) {
        self.title.text = entity.title
        self.imgView.setImage(url: entity.imgUrl, placeholderImage: UIImage(systemName: "camera.circle"))
    }
}
