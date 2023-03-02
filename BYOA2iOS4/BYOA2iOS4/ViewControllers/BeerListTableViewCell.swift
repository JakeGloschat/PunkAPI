//
//  BeerListTableViewCell.swift
//  BYOA2iOS4
//
//  Created by Jake Gloschat on 3/1/23.
//

import UIKit

class BeerListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerTaglineLabel: UILabel!
    @IBOutlet weak var ibuNameLabel: UILabel!
    
    
    
    // MARK: - Functions
   func updateViews(beer: Beer) {
        beerNameLabel.text = beer.name
        beerTaglineLabel.text = beer.tagline
       ibuNameLabel.text = "ibu: \(beer.ibu ?? 0.0)"
    }
}
