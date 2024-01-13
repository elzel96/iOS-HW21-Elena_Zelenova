import UIKit

class DetailController: UIViewController {
    
    var detailView = DetailView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        view = detailView
        detailView.backgroundColor = .systemBackground
    }
}
