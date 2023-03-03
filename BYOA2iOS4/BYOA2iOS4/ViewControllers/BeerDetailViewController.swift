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
    @IBOutlet weak var beerUnitLabel: UILabel!
    @IBOutlet weak var beerVolumeLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(withBeer: beer)
    }
    
    // MARK: - Properties
    var beer: Beer?
    
    // MARK: - Functions
    func updateUI(withBeer beer: Beer?) {
        guard let beer = beer else { return }
        beerTagLineLabel.text = beer.tagline
        beerNameLabel.text = beer.name
        beerAbvLabel.text = "Alcohol By Volume: \(beer.abv)"
        beerIbuLabel.text = "International Biterness Units: \(beer.ibu ?? 0.0)"
        beerUnitLabel.text = "\(beer.volume.unit):"
        beerVolumeLabel.text = "\(beer.volume.value)"
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
