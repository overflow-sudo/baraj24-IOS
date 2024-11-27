import UIKit
import DGCharts
import Charts
import GoogleMobileAds

class DamListVC: UIViewController, ChartViewDelegate{
    
 
   
    var bannerView: GADBannerView!
    var city = String()
    var dams = [Dam]()

    
    let tableView = UITableView()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(dams: [Dam]){
        super.init(nibName: nil, bundle: nil)
        self.dams = dams
    }

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [
            
            .font: UIFont(name: "Poppins-Bold", size: 24),
            .foregroundColor: UIColor(resource: .titleLabel)
        
        
        ]
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "building.2.crop.circle.fill"), style: .done, target: self, action: #selector(leftButtonClicked))
        
        navigationController?.navigationBar.tintColor = .lightGray
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        
        configureBannerAd()
       
    
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BarajlarTableViewCell.self, forCellReuseIdentifier: BarajlarTableViewCell.id)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
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

extension DamListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BarajlarTableViewCell.id) as! BarajlarTableViewCell
        cell.set(dam: self.dams[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DamVC()
        vc.dam = self.dams[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}
