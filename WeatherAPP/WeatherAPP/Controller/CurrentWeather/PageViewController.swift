//
//  PageViewController.swift
//  WeatherAPP
//
//  Created by hyeri kim on 06/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    private var currentViewControllers: [CurrentViewController] = [CurrentViewController]()
    var startIndex: Int = 0
    var weatherList: [WeatherInfo] = [WeatherInfo]() 
    
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
        var count = 0
        for i in weatherList {
            guard let eachPage = currentViewController() as? CurrentViewController else {
                return
            }
            eachPage.currentWeatherData = i
            eachPage.currentIndex = count
            eachPage.totalPage = weatherList.count
            currentViewControllers.append(eachPage)
            count += 1
        }
    }
    
    private func setupFirstPageView() {
        let firstViewController = currentViewControllers[startIndex] 
        setViewControllers([firstViewController],
                           direction: .forward,
                           animated: true,
                           completion: nil
        )
    }
    
    private func currentViewController() -> UIViewController {
        let st = UIStoryboard(name: "CurrentWeather", bundle: nil)
        return st.instantiateViewController(withIdentifier: "CurrentViewController")
    }
}

// MARK: UIPageViewControllerDataSource
extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? { 
        guard let current = viewController as? CurrentViewController,
            let viewControllerIndex = currentViewControllers.firstIndex(of: current) else { 
                return nil
        }
        
        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0,
            currentViewControllers.count > previousIndex else {
            return nil
        }
        return currentViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? { 
        guard let current = viewController as? CurrentViewController,
            let viewControllerIndex = currentViewControllers.firstIndex(of: current) else { 
                return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = currentViewControllers.count
        
        guard orderedViewControllersCount != nextIndex,
            orderedViewControllersCount > nextIndex else {
            return nil
        }
        return currentViewControllers[nextIndex]
    }
}

// MARK: UIPageViewControllerDelegate
extension PageViewController: UIPageViewControllerDelegate {}
