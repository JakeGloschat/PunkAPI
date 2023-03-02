//
//  BeerListTableViewController.swift
//  BYOA2iOS4
//
//  Created by Jake Gloschat on 3/1/23.
//

import UIKit

class BeerListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBeerList()
    }

    
    // MARK: - Properties
    var beers: [Beer] = []
    
    // MARK: - Functions
    func fetchBeerList() {
        NetworkingController.fetchAllBeers { [weak self] result in
            switch result {
            case .success(let beerList):
                self?.beers = beerList
                DispatchQueue.main.async { self?.tableView.reloadData() }
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unkownError)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath) as? BeerListTableViewCell else { return UITableViewCell() }
        let beer = beers[indexPath.row]
        cell.updateViews(beer: beer)
        return cell
    }
  
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBeerDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? BeerDetailViewController else { return }
            let beer = beers[indexPath.row]
            destinationVC.beer = beer
        }
    }
}
