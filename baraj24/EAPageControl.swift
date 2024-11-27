import UIKit

class EAPageControl: UIView {
    // MARK: - Properties
    private var titles: [String] = []
    private var currentPage: Int = 0 {
        didSet {
            updateUI()
        }
    }
    private let stackView = UIStackView()
    private let underlineView = UIView()
    
    // MARK: - Initializer
    init(titles: [String]) {
        self.titles = titles
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        // StackView setup
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
        
        // Add labels to the stack view
        for title in titles {
            let label = UILabel()
            label.text = title
            label.textAlignment = .center
            label.font = UIFont(name: "Poppins-Bold", size: 16)
            label.textColor = UIColor.white.withAlphaComponent(0.5)
            stackView.addArrangedSubview(label)
        }
        
        // Underline view setup
        underlineView.backgroundColor = .white
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(underlineView)
        
        NSLayoutConstraint.activate([
            underlineView.heightAnchor.constraint(equalToConstant: 6),
            underlineView.widthAnchor.constraint(equalToConstant: 60),
            underlineView.topAnchor.constraint(equalTo: stackView.arrangedSubviews.first!.bottomAnchor, constant: 5),
            underlineView.centerXAnchor.constraint(equalTo: stackView.arrangedSubviews.first!.centerXAnchor)
        ])
        
        updateUI()
    }
    
    // MARK: - Update UI
    private func updateUI() {
        // Update label colors
        for (index, view) in stackView.arrangedSubviews.enumerated() {
            guard let label = view as? UILabel else { continue }
            label.textColor = index == currentPage ? .white :  UIColor.white.withAlphaComponent(0.5)
        }
        
        UIView.animate(withDuration: 0.3) {
            let selectedView = self.stackView.arrangedSubviews[self.currentPage]
            let underlineWidth = self.underlineView.frame.width
            let centerX = selectedView.frame.midX
            self.underlineView.frame.origin.x = centerX - (underlineWidth / 2)
        }
    }
    
    // MARK: - Public Methods
    func setPage(index: Int) {
        guard index >= 0 && index < titles.count else { return }
        currentPage = index
    }
}
