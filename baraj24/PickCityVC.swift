//
//  PickCityVC.swift
//  baraj24
//
//  Created by Emir AKSU on 24.02.2024.
//

import UIKit
import GoogleMobileAds

class PickCityVC: UIViewController ,GADFullScreenContentDelegate, UITableViewDelegate, UITableViewDataSource {
 
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedCities.values.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sortedKeys = groupedCities.keys.sorted()
        let sectionKey = sortedKeys[section]
        return sectionKey
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let groupKeys = groupedCities.keys.sorted()
        let sectionKey = groupKeys[indexPath.section]
        let selectedCity = groupedCities[sectionKey]?[indexPath.row] ?? ""
        takeDams(city: selectedCity) { Result in
            switch Result {
            case .success(let success):
                DispatchQueue.main.async {
                    let detailsVC = DamsPC(dams: success, city: selectedCity)
                    self.navigationController?.pushViewController(detailsVC, animated: true)
                }
            case .failure(let failure):
                print("Hata: \(failure.localizedDescription)")
            }
        }

    }
    
    private func takeDams(city: String, completion: @escaping (Result<AllDams, Error>) -> Void) {
        
        APIManager.shared.takeDams(city: city) { Result in
            switch Result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                print("Veri gelmedi")
                
            }
        }
        
    }

    
    private var interstitial: GADInterstitialAd?

    var pickerView : UIPickerView?
    var cities : [Cities] = []
    var groupedCities: [String:[String]] = [:]
    var choosenCity : String?
    var bannerView: GADBannerView!
    var tableView = UITableView()
    
    let pickCityTitle: EATitle = {
        let label = EATitle(textAlignment: .left, fontSize: 24)
        label.font = UIFont(name: "Poppins-Bold", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(resource: .eaBlue)
        return label

    }()
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-4730844635676967/7298915875"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())

        Task{
            
            
            do {
                interstitial = try await GADInterstitialAd.load(
                    withAdUnitID: "ca-app-pub-4730844635676967/2434315662", request: GADRequest())
                interstitial?.fullScreenContentDelegate = self
            } catch {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
            }
            
        }
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Şehir Seçin"
        let textAttributes : [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(resource: .titleLabel),
            .font: UIFont(name: "Poppins-Bold", size: 30)
        ]
        
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        self.navigationItem.hidesBackButton = true
        fetchData()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CitiesTableViewCell.self, forCellReuseIdentifier: CitiesTableViewCell.id)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            
        ])
      
    }
    
    
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
      print("Ad did fail to present full screen content.")
    }

    /// Tells the delegate that the ad will present full screen content.
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad will present full screen content.")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad did dismiss full screen content.")
    }
    
  

    
    
    private func fetchData(){
        
        guard let url = URL(string: "https://baraj24api.emiraksu.net/cities") else {
            
            print("Geçersiz URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // Check for error
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            // Check if data is available
            guard let jsonData = data else {
                print("No data received")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            do {
                
                let decodedData = try decoder.decode([Cities].self, from: jsonData)
                self.cities = decodedData.sorted(by: {$0.city?.lowercased() ?? "" < $1.city?.lowercased() ?? ""})
                
                
                for city in self.cities{
                    guard let city = city.city else { continue }
                    
                    let firstLetter = city.prefix(1)
                   
                    if self.groupedCities[String(firstLetter)] == nil {
                        self.groupedCities[String(firstLetter)] = [city]
                    } else {
                        self.groupedCities[String(firstLetter)]?.append(city)

                    }
                    
                }
                
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
        
            } catch {
                print("Hata: \(error.localizedDescription)")
            }
        }

        task.resume()

       
        
        
        
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
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
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let city = self.groupedCities.keys.sorted()[section]
        return groupedCities[city]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CitiesTableViewCell.id) as! CitiesTableViewCell
        let sortedKeys = groupedCities.keys.sorted()
        let key = sortedKeys[indexPath.section]
        let city = groupedCities[key]?[indexPath.row] ?? "Unknown City"
        cell.set(city: city)
        return cell
    }
    
    
}
