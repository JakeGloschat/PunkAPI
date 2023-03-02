//
//  BeerDetailViewController.swift
//  BYOA2iOS4
//
//  Created by Jake Gloschat on 3/1/23.
//

import UIKit

class BeerDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerTagLineLabel: UILabel!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerAbvLabel: UILabel!
    @IBOutlet weak var beerIbuLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Properties
    var beer: Beer?
    
    // MARK: - Functions
    func updateUI(withBeer beer: Beer) {
        beerTagLineLabel.text = beer.tagline
        beerNameLabel.text = beer.name
        beerAbvLabel.text = "abv: \(beer.abv)"
        beerIbuLabel.text = "ibu: \(beer.ibu ?? 0.0)"
        beerDescriptionLabel.text = beer.description
        fetchBeerImage()
    }
    
    func fetchBeerImage() {
        NetworkingController.fetchImage(for: beer?.image) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async { self?.beerImageView.image = image }
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unkownError )
            }
        }
    }
}
