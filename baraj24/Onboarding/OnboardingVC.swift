//
//  ViewController.swift
//  pagecontrol
//
//  Created by Emir AKSU on 26.09.2024.
//

import UIKit






class OnboardingVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle = .scroll, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: options)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex > 0 {
            return pages[currentIndex - 1]
        } else{
            return nil
        }
        
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else{
            return nil
        }

    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        
        if completed, let currentViewController = pageViewController.viewControllers?.first, let index = pages.firstIndex(of: currentViewController) {
            
            
            pageControl.currentPage = index
        }
        
    }
    

    var pages = [UIViewController]()
    
    let pageControl = UIPageControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(resource: .eaGray)
        let firstViewController = Onboarding1VC()
        let secondViewController = Onboarding2VC()
        
     
        pages.append(firstViewController)
        pages.append(secondViewController)
        self.dataSource = self
        self.delegate = self
        
        if let firstIndex = pages.first{
            setViewControllers([firstIndex], direction: .forward, animated: false)
            
            pageControl.currentPage = 0
            
        }
 
        
        pageControl.numberOfPages = pages.count
          pageControl.currentPage = 0
          pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = UIColor.white // Color for non-selected pages
        pageControl.currentPageIndicatorTintColor = UIColor.systemBlue // Color for the current page

          // Add pageControl to the view hierarchy
          self.view.addSubview(pageControl)
          
          // Add constraints to center the pageControl at the bottom
          NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            pageControl.widthAnchor.constraint(equalToConstant: 100),
            pageControl.heightAnchor.constraint(equalToConstant: 20)
          ])
        

        
    }

    
  
}

