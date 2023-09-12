//
//  DiscoverViewController.swift
//  TheMovieApp
//
//  Created by Indocyber on 10/09/23.
//

import Foundation
import UIKit
import TTGSnackbar

class DiscoverViewController: UIViewController, DiscoverPresenterToView {
    
    @IBOutlet weak var movieGenreCollectionView: UICollectionView!
    @IBOutlet weak var movieListTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var refreshButton: UIButton!
    
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        currentPage = 1
        presenter?.fetchMovie(genre: selectedGenre, page: currentPage)
    }
    
    private var movie: [DiscoverMovieViewModel] = []
    private var genre: [GenreViewModel] = [GenreViewModel(genre: "All", id: 0)]
    
    private var selectedGenre: String = "" {
        didSet {
            movie.removeAll()
        }
    }
    private var currentPage: Int = 1
    private var viewIsLoading: Bool = false
    private var hasMoreData: Bool = true
    
    var presenter: DiscoverViewToPresenter?
    
    func updateMovie(movies: [DiscoverMovieViewModel]) {
        hasMoreData = movies.count != 0
        if hasMoreData {
            currentPage += 1
        }
        viewIsLoading = false
        movie += movies
        movieListTableView.reloadData()
    }
    
    func updateGenre(genres: [GenreViewModel]) {
        genre += genres
        
        movieGenreCollectionView.reloadData()
        movieGenreCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .left)
    }
    
    func showError(error: Error) {
        movie.removeAll()
        refreshButton.isHidden = false
        movieListTableView.reloadData()
        let snackBar = TTGSnackbar(message: error.localizedDescription, duration: .middle)
        snackBar.backgroundColor = .red
        snackBar.show()
    }
    
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            activityIndicator.startAnimating()
            view.mask = UIView(frame: self.view.frame)
            view.mask?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
    }
    
    func dismissLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) { [weak self] in
            
            self?.activityIndicator.stopAnimating()
            self?.view.mask = nil
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCollectionView()
        setupTableView()
    
        refreshButton.isHidden = true
        activityIndicator.hidesWhenStopped = true
        presenter?.fetchMovie(genre: selectedGenre, page: currentPage)
        presenter?.fetchGenre()
    }
    
    private func setup() {
        title = "Discover"
        let presenter = DiscoverPresenter()
        let interactor = DiscoverViewInteractor()
        let router = DiscoverRouter()
        
        self.presenter = presenter
        presenter.view = self
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = self
    }
    
    private func loadMoreMovies() {
        guard !viewIsLoading, hasMoreData else {
            return
        }
        viewIsLoading = true
        presenter?.fetchMovie(genre: selectedGenre, page: currentPage)
    }
    
    private func setupTableView() {
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
    }
    
    private func setupCollectionView() {
        movieGenreCollectionView.delegate = self
        movieGenreCollectionView.dataSource = self
    }
    
}

extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        cell.initSetupCell()
        cell.selectionStyle = .none
        cell.setupCell(viewModel: movie[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToMovieDetail(movieId: movie[indexPath.row].movieId)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight {
            loadMoreMovies()
        }
    }
}

extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        genre.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath) as? GenreCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell()
        cell.genre.text = genre[indexPath.item].genre
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedGenre = "\(genre[indexPath.item].id)"
        currentPage = 1
        presenter?.fetchMovie(genre: selectedGenre, page: currentPage)
    }
    
    
}
