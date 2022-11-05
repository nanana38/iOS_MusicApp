//
//  MusicCollectionViewCell.swift
//  [iOS] MusicApp
//
//  Created by 유현이 on 2022/11/04.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var mainImageView: UIImageView!
    
    var imageUrl: String? {
        didSet {
            loadImage()
        }
    }
    
    func loadImage() {
        guard let urlString = imageUrl else { return }
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            guard self.imageUrl! == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.mainImageView.image = nil
    }
    
    
}
