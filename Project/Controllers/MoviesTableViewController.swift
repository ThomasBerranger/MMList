//
//  MoviesTableViewController.swift
//  Project
//
//  Created by Thomas BERRANGER on 07/12/2017.
//  Copyright © 2017 Thomas BERRANGER. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    
    var book: MovieBook?
    // Les ! ne sont pas conseillés mais dans notre cas, on est sûr de toujours avoir un "book"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let moviebook = read() {
            book = moviebook
        }
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {}
        
        let notifCenter = NotificationCenter.default
        notifCenter.addObserver(forName: Notification.Name("MovieDataChanged"), object: nil, queue: nil) { (notification) in
            print(notification.name)
            self.refresh()
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func addMovie(_ sender: Any) {
        let newMovie = Movie()
        newMovie.title = "Nouveau film ?"
        newMovie.synopsis = "Qu'en pensez-vous ?"
        book?.add(movie: newMovie)
        save()
        tableView.reloadData()
    }
    

    // Tableau
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  book!.listMovies().count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { fatalError("Wrong type") }
        
        let tabMovie = book!.listMovies()
        let currentMovie = tabMovie[indexPath.row]
        
        cell.configure(with: currentMovie)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete){
            book?.remove(index: indexPath.row)
            self.tableView.reloadData()
            save()
        }
    }
    
    
    
    // Changement de page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            guard let destination = segue.destination as? DetailViewController else { return }
            guard let cell = sender as? UITableViewCell else {return}
            guard let indexPath = tableView.indexPath(for: cell) else {return}
            
            let tabMovie = book!.listMovies()
            let movie = tabMovie[indexPath.row]
            
            destination.currentMovie = movie;
        }
    }
    

    func refresh() {
        tableView.reloadData()
        save()
    }
    
    
    @IBAction func disconnect(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // Fonction pour save data
    func save() {
        //Méthode pour prendre le livre de films
        guard let json = try? JSONEncoder().encode(book) else {return}
        //Méthode pour encoder les informations
        guard let documentFolderURL = doculentFolderURL() else {return}
        //Création de l'url
        let jsonUrl = documentFolderURL.appendingPathComponent("moviebook.json")
        //Ecriture sur l'url donnée
        try? json.write(to: jsonUrl)
    }
    
    func read() -> MovieBook? {
        guard let documentFolderURL = doculentFolderURL() else {return nil}
        let jsonUrl = documentFolderURL.appendingPathComponent("moviebook.json")
        guard let dataRead = try? Data(contentsOf: jsonUrl) else {return nil}
        return try? JSONDecoder().decode(MovieBook.self, from: dataRead)
    }

    func doculentFolderURL() -> URL? {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return url
    }
    
    
}
