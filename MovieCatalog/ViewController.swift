//
//  ViewController.swift
//  MovieCatalog
//
//  Created by Виктор on 24.10.2026.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {

    private var movies: [Movie] = []
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        setupTableView()
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
            movies = response.movies
            tableView.reloadData()
            for movie in response.movies {
                print("Фильм: \(movie.title), год: \(movie.year)")
            }
        } catch {
            print("Ошибка загрузки фильмов: \(error)")
        }
    }
    private func setupTableView() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "MovieCell"
        )
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MovieCell",
            for: indexPath
        )
        let movie = movies[indexPath.row]

           var content = cell.defaultContentConfiguration()
           content.text = movie.title
           content.secondaryText = "Год: \(movie.year)"
           cell.contentConfiguration = content

           return cell
    }
}


extension ViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let selectedMovie = movies[indexPath.row]

        let detailsVC = MovieDetailsViewController()
        detailsVC.movie = selectedMovie

        navigationController?.pushViewController(
            detailsVC,
            animated: true
        )

        tableView.deselectRow(
            at: indexPath,
            animated: true
        )
    }
}
