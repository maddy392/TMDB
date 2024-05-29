//
//  WatchListViewController.swift
//  TMDB
//
//  Created by Madhu Babu Adiki on 5/27/24.
//

import UIKit

class WatchListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TMDBClient.getWatchlist() { movies, error in
            MovieModel.watchlist = movies
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
        
}

extension WatchListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieModel.watchlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell")!
        
        let movie = MovieModel.watchlist[indexPath.row]
        
        cell.textLabel?.text = movie.title
        
        return cell
    }
    
    
    
}
