//
//  Movie.swift
//  Project
//
//  Created by Thomas BERRANGER on 07/12/2017.
//  Copyright © 2017 Thomas BERRANGER. All rights reserved.
//

import Foundation

class Movie: Codable {
    var title: String = ""
    var synopsis: String = ""
    var date: Date = Date()
    var watched: Bool = true
    var note: Int = 5
    var image: String = ""
}


