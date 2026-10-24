//
//  movie.swift
//  MovieCatalog
//
//  Created by Виктор on 24.10.2026.
//

struct Movie: Codable {
    let title: String
    let year: Int
    let rating: Double
    let director: String?
}

struct MovieResponse: Codable {
    let movies: [Movie]
}
