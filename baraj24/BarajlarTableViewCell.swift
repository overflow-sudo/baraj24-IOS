import UIKit

enum RateDirection {
    case up
    case down
}

class BarajlarTableViewCell: UITableViewCell {

    static let id = "TableViewCell"
    
    let damText: EALabel = {
        let label = EALabel(textAlignment: .left, fontSize: 16)
        label.font = UIFont(name: "Poppins-SemiBold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        return label
    }()
    
    let damRateText: EALabel = {
        let label = EALabel(textAlignment: .center, fontSize: 9)
        label.font = UIFont(name: "Poppins-Bold", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        return label
    }()
    
    //Create Arrow
    private func createArrow(direction: RateDirection) -> UIImageView{
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        switch direction {
        case .up:
            imageView.image = UIImage(systemName: "arrowshape.up.fill")
            imageView.tintColor = .green
        case .down:
            imageView.image = UIImage(systemName: "arrowshape.down.fill")
            imageView.tintColor = .red

        }
        
        return imageView
        
    }
    
    let damImage: EAImageView = {
        let imageView = EAImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let whiteBrighter: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "whiteBright"))
        
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
    }

    
    
    private func configure() {
        contentView.backgroundColor = UIColor(resource: .eaGray)
        contentView.layer.borderColor = UIColor.systemGray6.cgColor
        contentView.layer.borderWidth = 2
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        
        selectionStyle = .none

        contentView.addSubview(damText)
        
        NSLayoutConstraint.activate([
   
            damText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            damText.widthAnchor.constraint(equalToConstant: 240),
            damText.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            damText.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        
        
        contentView.addSubview(damRateText)
        damRateText.textColor = .red
        damRateText.text = "%30"
        NSLayoutConstraint.activate([
            
            damRateText.widthAnchor.constraint(equalToConstant: 40),
            damRateText.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            damRateText.heightAnchor.constraint(equalToConstant: 20),
            damRateText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
            
        ])
        
    }
    
    func set(dam: Dam) {
        damText.text = dam.dam
       
        damImage.image = UIImage(named: "placeholder") // Placeholder image if no URL
        
        
        
        damRateText.text = "\(dam.activeFullnessAmount) %"
        
        switch dam.activeFullnessAmount {
        case 0..<25:
            damRateText.textColor = .red
        case 25 ..< 50:
            damRateText.textColor = .orange
        default:
            damRateText.textColor = .systemGreen
        }
        
        let damCount = dam.historicalData?.count
        
        guard let historicalData = dam.historicalData else { return }
      
        guard historicalData.count > 2 else { return }
        
        if historicalData[historicalData.count - 1].activeFullnessAmount > historicalData[historicalData.count - 2].activeFullnessAmount {
            
            
            let image = createArrow(direction: .up)
        
            
            contentView.addSubview(image)
            
            NSLayoutConstraint.activate([
                
                image.centerYAnchor.constraint(equalTo: damRateText.centerYAnchor),
                image.trailingAnchor.constraint(equalTo: damRateText.leadingAnchor, constant: -5),
                image.widthAnchor.constraint(equalToConstant: 13),
                image.heightAnchor.constraint(equalToConstant: 13)
                
            ])
        } else {
            
            let image = createArrow(direction: .down)
        
            
            contentView.addSubview(image)
            
            NSLayoutConstraint.activate([
                
                image.centerYAnchor.constraint(equalTo: damRateText.centerYAnchor),
                image.trailingAnchor.constraint(equalTo: damRateText.leadingAnchor, constant: -5),
                image.widthAnchor.constraint(equalToConstant: 13),
                image.heightAnchor.constraint(equalToConstant: 13)
                
            ])
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
