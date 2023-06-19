import Foundation
import StyleGuide
import UIKit

protocol ActionBarDelegate: AnyObject {
    
    func actionBarDidTapCreateBox()
}

class ActionBar: UIView {
    
    weak var delegate: ActionBarDelegate?
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .theme.tertiary400
        view.image = UIImage(systemName: "plus")
        return view
    }()
    
    private let label = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .theme.tertiary400
        label.font = .theme.body1
        label.text = "New Box"
        return label
    }()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .theme.background500
        
        setupConstraints()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        ])
    }
    
    private func setupBindings() {
        addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(self.handleCreateBoxTap)
            )
        )
    }
    
    @objc private func handleCreateBoxTap() {
        delegate?.actionBarDidTapCreateBox()
    }
}
