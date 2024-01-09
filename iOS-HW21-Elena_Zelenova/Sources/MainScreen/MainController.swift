import UIKit
import Alamofire

class MainController: UIViewController {
    
    private var model: [Character] = []
    
    private var mainView = MainView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        view = mainView
        mainView.backgroundColor = .systemBackground
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        NetworkService.shared.fetchCharacter { data in
            self.model = data
            
            DispatchQueue.main.async{
                self.mainView.tableView.reloadData()
            }
        }
    }
}

// MARK: - Extensions

extension MainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MarvelCell
        cell?.model = model[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension MainController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let viewController = DetailController()
//        viewController.model = model[indexPath.row]
//        navigationController?.pushViewController(viewController, animated: true)
    }
}

