//
//  TableViewCell.swift
//  PARSE_JSON_TABLE
//
//  Created by Hoang Tung Lam on 9/1/20.
//  Copyright © 2020 Hoang Tung Lam. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(data:Post){
        lblUsername.text = data.userName!
        lblLocation.text = data.location!
        lblAge.text = "\(data.age!)"
        lblGender.text = data.gender!
        
        let imageURL = URL(string: data.image)
        let task = URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
            if error == nil {
                guard let imageData = data else {return}
                let loadedImage = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.imgImage.image = loadedImage
                }
            }
        }
        task.resume()
    }
}
