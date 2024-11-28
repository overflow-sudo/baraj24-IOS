import UIKit
import GoogleMobileAds

class DamsPC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var pages: [UIViewController] = []
    let myPageControl = EAPageControl(titles: ["Doluluk", "Barajlar"])
    var bannerView: GADBannerView!
   
    
    
    init(dams: AllDams, city: String) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pages = [DamRateVC(dams: dams, city: city), DamListVC(dams: dams.dams)]
        self.delegate = self
        self.dataSource = self
      
        if let firstViewController = pages.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
     
        
        view.backgroundColor = UIColor.white
    
        view.addSubview(myPageControl)
        myPageControl.backgroundColor = UIColor(resource: .eaBlue)
        NSLayoutConstraint.activate([
            myPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myPageControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            myPageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            myPageControl.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        let backButton = UIButton(type: .custom)
        backButton.setTitle("<", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 36)
        backButton.tintColor = .white.withAlphaComponent(0.5)
        backButton.backgroundColor = .clear
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        let backButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backButtonItem
        
        configureBannerAd()

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
    
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex < pages.count - 1 else {
            return nil
        }
        return pages[currentIndex + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            if let previousViewController = previousViewControllers.first, let previousIndex = pages.firstIndex(of: previousViewController) {
                pageViewController.setViewControllers([previousViewController], direction: .reverse, animated: false)
                myPageControl.setPage(index: previousIndex)
            }
        } else {
            if let currentViewController = viewControllers?.first, let index = pages.firstIndex(of: currentViewController) {
                myPageControl.setPage(index: index)
            }
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let nextViewController = pendingViewControllers.first, let index = pages.firstIndex(of: nextViewController) {
            myPageControl.setPage(index: index)
        }
    }
}
