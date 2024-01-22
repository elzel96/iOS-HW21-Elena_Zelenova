import UIKit

final class DetailView: UIView {
    
    var model: Character? {
        didSet {
            nameLabel.text = model?.name
            descriptionLabel.text = model?.description
            
            guard let imagePath = model?.thumbnail?.getImagePath()
            else {
                image.image = UIImage(systemName: "person")
                return
            }
            
            NetworkService.shared.getImageData(path: imagePath) { imageData in
                
                DispatchQueue.main.async{
                    self.image.image = UIImage(data: imageData)
                }
                
            }
        }
    }
    
    // MARK: - UI Elements
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.numberOfLines = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    
    private func setupHierarchy() {
        addSubview(image)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
    }
    
    private func setupLayout() { NSLayoutConstraint.activate([
        nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 80),
        nameLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        
        image.widthAnchor.constraint(equalToConstant: 340),
        image.heightAnchor.constraint(equalToConstant: 340),
        image.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
        image.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        
        descriptionLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
        descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
        descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40)
    ])
    }
}
