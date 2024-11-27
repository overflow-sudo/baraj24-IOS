import UIKit

class CitiesTableViewCell: UITableViewCell {

    static let id = "CitiesTableViewCell"
    
    let cityText: EALabel = {
        let label = EALabel(textAlignment: .left, fontSize: 16)
        label.font = UIFont(name: "Poppins-SemiBold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        return label
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
        backgroundColor = .white
        selectionStyle = .none

        contentView.addSubview(cityText)
        NSLayoutConstraint.activate([
   
            cityText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cityText.widthAnchor.constraint(equalToConstant: 240),
            cityText.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityText.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        
      
        
    }
    
    func set(city: String) {
        cityText.text = city
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
