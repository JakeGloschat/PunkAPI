//
//  RandomBeerViewController.swift
//  BYOA2iOS4
//
//  Created by Jake Gloschat on 3/1/23.
//

import UIKit

class RandomBeerViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var randomBeerImageView: UIImageView!
    @IBOutlet weak var randomBeerName: UILabel!
    @IBOutlet weak var randomBeerTagline: UILabel!
    @IBOutlet weak var randomBeerAbv: UILabel!
    @IBOutlet weak var randomBeerIbu: UILabel!
    @IBOutlet weak var randomBeerDescription: UILabel!
    @IBOutlet weak var getRandomBeerButton: UIButton!
    @IBOutlet weak var randomBeerVolumeLabel: UILabel!
    @IBOutlet weak var randomBeerUnitLabel: UILabel!
    
    
    // MARK: - Properties
    var beer: Beer?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRandomBeer()
    }
    
    // MARK: - Functions
    func fetchRandomBeer() {
        NetworkingController.fetchRandomBeer { [weak self] result in
            switch result {
            case .success(let beer):
                self?.beer = beer
                DispatchQueue.main.async { self?.updateUI(withbeer: beer) }
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unkownError)
            }
        }
    }
    
    func updateUI(withbeer beer: Beer) {
        randomBeerName.text = beer.name
        randomBeerTagline.text = beer.tagline
        randomBeerAbv.text = "Alcohol By Volume: \(beer.abv)"
        randomBeerIbu.text = "International Biterness Units: \(beer.ibu ?? 0.0)"
        randomBeerDescription.text = beer.description
        randomBeerUnitLabel.text = "\(beer.volume.unit):"
        randomBeerVolumeLabel.text = "\(beer.volume.value)"
        fetchBeerImage()
    }
    
    func fetchBeerImage() {
        NetworkingController.fetchImage(for: beer?.image) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async { self?.randomBeerImageView.image = image }
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unkownError)
            }
        }
    }
    
    // MARK: - Action
    @IBAction func getRandomBeerButtonTapped(_ sender: Any) {
        fetchRandomBeer()
    }
}
