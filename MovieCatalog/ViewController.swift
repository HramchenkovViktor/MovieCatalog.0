//
//  ViewController.swift
//  MovieCatalog
//
//  Created by Виктор on 24.10.2026.
//

import UIKit

final class ViewController: UIViewController {

    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadMovies()
    }

    private func loadMovies() {
        guard let url = Bundle.main.url(
            forResource: "movies",
            withExtension: "json"
        ) else {
            print("Файл movies.json не найден")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(MovieResponse.self, from: data)

            for movie in response.movies {
                print("Фильм: \(movie.title), год: \(movie.year)")
            }
        } catch {
            print("Ошибка загрузки фильмов: \(error)")
        }
    }
}
