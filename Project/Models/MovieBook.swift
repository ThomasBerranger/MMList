//
//  MovieBook.swift
//  Project
//
//  Created by Thomas BERRANGER on 07/12/2017.
//  Copyright © 2017 Thomas BERRANGER. All rights reserved.
//

import Foundation

class MovieBook: Codable {
    
    var movies: [Movie] = []
    
    func add(movie: Movie) {
        movies.insert(movie, at: 0)
    }
    
    func listMovies() -> [Movie] {
        return movies
    }
    
    func remove(index:Int) {
        movies.remove(at: index)
    }
    
    func notifyChanges() {
        let notifCenter = NotificationCenter.default
        notifCenter.post(name: Notification.Name("MovieDataChanged"), object: nil)
    }
    
    
}
