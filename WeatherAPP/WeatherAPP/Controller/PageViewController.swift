//
//  PageViewController.swift
//  WeatherAPP
//
//  Created by hyeri kim on 06/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    var weatherList: [WeatherInfo] = [WeatherInfo]() 
    private var currentViewControllers: [CurrentViewController] = [CurrentViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCurrentWeatherViewController()
        setupPageView()
        setupFirstPageView()
    }
    
    private func setupPageView() {
        dataSource = self
        delegate = self
    }
    
    private func createCurrentWeatherViewController() {
        for i in weatherList {
            guard let page = currentViewController() as? CurrentViewController else {
                return
            }
            page.currentWeatherData = i
            currentViewControllers.append(page)
        }
    }
    
    private func setupFirstPageView() {
        if let firstViewController = currentViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil
            )
        }
    }
    
    private func currentViewController() -> UIViewController {
        return UIStoryboard(name: "CurrentWeather", bundle: nil) .
            instantiateViewController(withIdentifier: "CurrentViewController")
    }
}

// MARK: UIPageViewControllerDataSource
extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = currentViewControllers.firstIndex(of: viewController as! CurrentViewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard currentViewControllers.count > previousIndex else {
            return nil
        }
        
        return currentViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = currentViewControllers.firstIndex(of: viewController as! CurrentViewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = currentViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return currentViewControllers[nextIndex]
    }
}

// MARK: UIPageViewControllerDelegate
extension PageViewController: UIPageViewControllerDelegate {
    
}
