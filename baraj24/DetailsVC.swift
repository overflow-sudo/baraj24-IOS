import UIKit
import DGCharts
import Charts
import GoogleMobileAds

class DetailsVC: UIViewController, ChartViewDelegate{
    
 
   
    var bannerView: GADBannerView!
    var city = String()
    var dams = [Dam]()
    let tableViewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Barajlar"
        label.font = UIFont(name: "Poppins-Bold", size: 24)
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let tableViewSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Konumdaki barajlar"
        label.font = UIFont(name: "Poppins", size: 16)
        label.textColor = UIColor.lightGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tableView = UITableView()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(city: String){
        super.init(nibName: nil, bundle: nil)
        self.city = city
    }

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = city
        navigationController?.navigationBar.titleTextAttributes = [
            
            .font: UIFont(name: "Poppins-Bold", size: 24),
            .foregroundColor: UIColor(resource: .titleLabel)
        
        
        ]
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "building.2.crop.circle.fill"), style: .done, target: self, action: #selector(leftButtonClicked))
        
        navigationController?.navigationBar.tintColor = .lightGray
        view.backgroundColor = UIColor(resource: .oxfordBlue)
        tableView.delegate = self
        tableView.dataSource = self
        
        configureBannerAd()
        
        let scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // Adjust content inset to handle tabbar and top safe area
        scrollView.contentInsetAdjustmentBehavior = .always
        scrollView.backgroundColor = UIColor(resource: .eaBlue)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
       
       
        
      
        
        NSLayoutConstraint.activate([
            
            tableViewSubtitleLabel.topAnchor.constraint(equalTo: tableViewTitleLabel.bottomAnchor, constant: 10),
            tableViewSubtitleLabel.leadingAnchor.constraint(equalTo: tableViewTitleLabel.leadingAnchor),
            tableViewSubtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            tableViewSubtitleLabel.heightAnchor.constraint(equalToConstant: 17)
            
        ])
        
        tableView.backgroundColor = UIColor(resource: .oxfordBlue)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BarajlarTableViewCell.self, forCellReuseIdentifier: BarajlarTableViewCell.id)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: tableViewSubtitleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
       
    }
    
    @objc func leftButtonClicked() {
        navigationController?.pushViewController(PickCityVC(), animated: true)
    }
    
    // MARK: - ADMOB Banner Settings
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints([
            NSLayoutConstraint(item: bannerView,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: view.safeAreaLayoutGuide,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: 0),
            NSLayoutConstraint(item: bannerView,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .centerX,
                               multiplier: 1,
                               constant: 0)
        ])
    }
    
    func configureBannerAd(){
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-4730844635676967/9589219055"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
}

extension DetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BarajlarTableViewCell.id) as! BarajlarTableViewCell
        cell.set(dam: self.dams[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DamVC()
        vc.dam = self.dams[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
