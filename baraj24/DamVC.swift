//
//  DamVC.swift
//  baraj24
//
//  Created by Emir AKSU on 24.02.2024.
//

import UIKit
import Charts
import GoogleMobileAds
import DGCharts
class DamVC: UIViewController, ChartViewDelegate {
    var bannerView: GADBannerView!

    var dam : Dam?
    var pieChart = PieChartView()
    var lineChart = LineChartView()
   
    //MARK: - ScrollView
    
    private func configureScrollView(){
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            
            scrollStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            scrollStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            scrollStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            scrollStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20),
            scrollStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        configureStackView()
        
      
    }
    
    private let scrollView : UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    //MARK: - Stack View
    private let scrollStackView : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 10
        return view
        
    }()
    private func configureStackView(){
        scrollStackView.addArrangedSubview(imageMap)
        scrollStackView.addArrangedSubview(pieGraph)
        scrollStackView.addArrangedSubview(lineChartView)
        

    }
    
    
    //MARK: - Image & Map
    
    
    private let imageMap : UIView = {
       
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        return view
        
    }()
    
    private func configureImageMap(){
        let imageView = EAImageView(frame: .zero)
//        imageView.getImage(url: dam?.image ?? "")
        let textBaraj = EATitle(textAlignment: .left, fontSize: 28)
        let textCity = EALabel(textAlignment: .left, fontSize: 24)
        let blur = addBlur()

        imageMap.addSubview(imageView)
        imageMap.addSubview(blur)
        imageMap.addSubview(textCity)
        imageMap.addSubview(textBaraj)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            imageView.topAnchor.constraint(equalTo: imageMap.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageMap.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageMap.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageMap.bottomAnchor),
            
            textBaraj.leadingAnchor.constraint(equalTo: imageMap.leadingAnchor, constant: 10),
            textBaraj.widthAnchor.constraint(equalTo: imageMap.widthAnchor),
            textBaraj.bottomAnchor.constraint(equalTo: imageMap.bottomAnchor, constant: -50),
            textBaraj.heightAnchor.constraint(equalToConstant: 40),
            
            textCity.leadingAnchor.constraint(equalTo: imageMap.leadingAnchor, constant: 10),
            textCity.widthAnchor.constraint(equalToConstant: 200),
            textCity.topAnchor.constraint(equalTo: textBaraj.bottomAnchor, constant: 0),
            textCity.heightAnchor.constraint(equalToConstant: 40),
            
            blur.leadingAnchor.constraint(equalTo: imageMap.leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: imageMap.trailingAnchor),
            blur.topAnchor.constraint(equalTo: textBaraj.topAnchor, constant: -10),
            blur.bottomAnchor.constraint(equalTo: textCity.bottomAnchor, constant: 10)

        ])
        
        textBaraj.text =  dam?.dam
    }
   
    //MARK: - Pie Graph
    private let pieGraph : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 10

        return view
    }()
    
    
    private func configurePieGraph(){
        let titlePastaGrafigi = EALabel(textAlignment: .left, fontSize: 16)
        pieGraph.addSubview(titlePastaGrafigi)
        NSLayoutConstraint.activate([
            titlePastaGrafigi.topAnchor.constraint(equalTo: pieGraph.topAnchor, constant: 20),
            titlePastaGrafigi.leadingAnchor.constraint(equalTo: pieGraph.leadingAnchor, constant: 20),
            titlePastaGrafigi.widthAnchor.constraint(equalTo: pieGraph.widthAnchor, constant: -60),
            titlePastaGrafigi.heightAnchor.constraint(equalToConstant: 20)
    
        
        ])
        
        
        titlePastaGrafigi.text = "Pasta Grafiği"
    
       
        //Pie Graph
        guard let dam = dam else {return}
        createPieChart(dolu: PieChartDataEntry(value: dam.activeFullnessAmount, label: "Dolu"), bos: PieChartDataEntry(value: 100-dam.activeFullnessAmount, label: "Boş"), surface: pieGraph, pieChart: pieChart)
        
        pieChart.delegate = self
    }
    
    //MARK: - LineChart
    
    private let lineChartView : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.heightAnchor.constraint(equalToConstant: 450).isActive = true
        view.layer.cornerRadius = 10

       return view
    }()
    let titleCizgiGrafigi = EALabel(textAlignment: .left, fontSize: 16)

    private func configureLineChart(){
        lineChartView.addSubview(titleCizgiGrafigi)
        
        
        NSLayoutConstraint.activate([
            titleCizgiGrafigi.topAnchor.constraint(equalTo: lineChartView.topAnchor, constant: 20),
            titleCizgiGrafigi.leadingAnchor.constraint(equalTo: lineChartView.leadingAnchor, constant: 20),
            titleCizgiGrafigi.widthAnchor.constraint(equalTo: lineChartView.widthAnchor, constant: -60),
            titleCizgiGrafigi.heightAnchor.constraint(equalToConstant: 20)
    
        
        ])
        
        titleCizgiGrafigi.text = "Çizgi Grafiği"
        setData(suffix: 5)
        lineChart.delegate = self
    }
    
    private func setData(suffix : Int){
        
        var entries = [ChartDataEntry]()
        var dates = [String]()
        
        
        guard let historicalData = dam?.historicalData else { return }
        for (index, data) in historicalData.enumerated(){
            print(entries)
            entries.append(ChartDataEntry(x: Double(index), y: Double(data.activeFullnessAmount)))
            
            dates.append("\(data.date)")
            
        }
        createLineChart(data: entries.suffix(suffix), surface: lineChartView, lineChart: lineChart)
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
    }
    
    private let segmentedControl : UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["5 gün","10 gün","15 gün","30 gün"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private func configureSegmentedControl(){
        lineChartView.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
        
            segmentedControl.topAnchor.constraint(equalTo: titleCizgiGrafigi.topAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: titleCizgiGrafigi.leadingAnchor, constant: 20),
            segmentedControl.widthAnchor.constraint(equalTo: lineChartView.widthAnchor, constant: -60),
            segmentedControl.heightAnchor.constraint(equalToConstant: 20)
            
            
        
        ])
        segmentedControl.addTarget(self, action: #selector(segmentSelect), for: .valueChanged )
        segmentedControl.setEnabled(true, forSegmentAt: 0)

    }
    
    @objc func segmentSelect(){
        print(segmentedControl.selectedSegmentIndex)
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            setData(suffix: 5)

        case 1:
            setData(suffix: 10)
        case 2:
            setData(suffix: 15)
        case 3:
            setData(suffix: 30)
   
        default:
            setData(suffix: 30)
        }
       
    
    }
    
    //MARK: - FetchData
    private func fetchData(){
        guard let dam = dam else{return}
      
      
           self.updateUI()
      
    }
   
    //MARK: - Update UI
    private func updateUI(){
        DispatchQueue.main.async {
            self.configureScrollView()
            self.configurePieGraph()
            self.configureLineChart()
            self.configureSegmentedControl()
            self.adConfigure()
        }
     
    }
    
    
    //MARK: - Life Cycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureImageMap()
        fetchData()
        self.navigationItem.title = "Grafikler"
    }
    
    
    private func adConfigure(){
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-4730844635676967/6479839980"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
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
    
}
