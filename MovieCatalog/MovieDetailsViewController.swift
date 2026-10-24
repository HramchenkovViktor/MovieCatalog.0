//
//  MovieDetailsViewController.swift
//  MovieCatalog
//
//  Created by Виктор on 24.10.2026.
//

import UIKit
import SnapKit

final class MovieDetailsViewController: UIViewController {

    var movie: Movie?

    private let titleLabel = UILabel()
    private let yearLabel = UILabel()
    private let ratingLabel = UILabel()
    private let directorLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setupUI()
        configureMovie()
    }

    private func setupUI() {
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.numberOfLines = 0

        yearLabel.font = .systemFont(ofSize: 18)
        ratingLabel.font = .systemFont(ofSize: 18)
        directorLabel.font = .systemFont(ofSize: 18)
        directorLabel.numberOfLines = 0

        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            yearLabel,
            ratingLabel,
            directorLabel
        ])

        stackView.axis = .vertical
        stackView.spacing = 16

        view.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }

    private func configureMovie() {
        guard let movie = movie else { return }

        titleLabel.text = movie.title
        yearLabel.text = "Год: \(movie.year)"
        ratingLabel.text = "Рейтинг: ⭐ \(movie.rating)"
        directorLabel.text = "Режиссёр: \(movie.director ?? "Неизвестен")"
    }
}
