//
//  MovieDetailViewController.swift
//  TheMovieApp
//
//  Created by Indocyber on 11/09/23.
//

import UIKit
import Kingfisher
import TTGSnackbar

class MovieDetailViewController: UIViewController, MovieDetailPresenterToView, UIScrollViewDelegate {
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var genreValueLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var durationValueLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingValueLabel: UILabel!
    
    @IBOutlet weak var movieTitleValueLabel: UILabel!
    @IBOutlet weak var overviewValueLabel: UILabel!
    @IBOutlet weak var reviewTableView: AutoSizeTableview!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func playButtonAction(_ sender: Any) {
        presenter?.fetchMovieVideo(movieId: movieId!)
    }
    
    public var movieId: Int?
    var presenter: MovieDetailViewToPresenter?
    var currentPage: Int = 1
    var reviews: [ReviewViewModel] = []
    var viewIsLoading: Bool = false
    var hasMoreData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableview()
        guard let movieId else {
            let snackBar = TTGSnackbar(message: "No Movie ID Found!", duration: .middle)
            snackBar.backgroundColor = .red
            snackBar.show()
            return
        }
        viewIsLoading = true
        presenter?.fetchReview(movieId: movieId, page: currentPage)
        presenter?.fetchMovieDetail(movieId: movieId)
    }
    
    func updateMovieDetail(movieDetail: MovieDetailViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let processor = RoundCornerImageProcessor(cornerRadius: 12)
            backdropImage.kf.setImage(with: URL(string: movieDetail.backdropURL))
            posterImage.kf.setImage(with: URL(string: movieDetail.imageURL), options:  [.processor(processor)])
            genreValueLabel.text = movieDetail.genres.joined(separator: ",")
            durationValueLabel.text = "\(movieDetail.duration) minutes"
            ratingValueLabel.text = "\(movieDetail.rating)"
            overviewValueLabel.text = movieDetail.overview
            movieTitleValueLabel.text = movieDetail.title
        }
    }
    
    func updateReview(review: [ReviewViewModel]) {
        hasMoreData = reviews.count != 0
        if hasMoreData {
            currentPage += 1
        }
        reviews += review
        reviewTableView.reloadData()
        viewIsLoading = false
    }
    
    
    func showError(error: Error) {
        viewIsLoading = false
        let snackBar = TTGSnackbar(message: error.localizedDescription, duration: .middle)
        snackBar.backgroundColor = .red
        snackBar.show()
    }
    
    private func setupTableview() {
        reviewTableView.dataSource = self
        reviewTableView.delegate = self
    }
    
    private func setup() {
        playButton.imageView?.layer.transform = CATransform3DMakeScale(3, 3, 3)
        scrollView.delegate = self
        let presenter = MovieDetailPresenter()
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        
        self.presenter = presenter
        presenter.view = self
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
    }
    
    private func loadMoreReviews() {
        guard !viewIsLoading, hasMoreData else {
            return
        }
        viewIsLoading = true
        presenter?.fetchReview(movieId: movieId!, page: currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight {
            loadMoreReviews()
        }
    }

}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
        cell.reviewBackgroundView.backgroundColor = .systemGray6
        cell.reviewBackgroundView.layer.cornerRadius = 8
        cell.setupCell(reviewViewModel: reviews[indexPath.row])
        return cell
    }
    
    
    
    
}
