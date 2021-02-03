//
//  TabContainerCoordinator.swift
//  AufmassGenerator
//
//  Created by Thomas Segkoulis on 07.11.20.
//  Copyright © 2020 Thomas Segkoulis. All rights reserved.
//

import Foundation
import UIKit
import JarMVVMC

open class TabContainerCoordinator: NSObject, CoordinatorProtocol, UITabBarControllerDelegate {
    
    public var navigationController: UINavigationController?
    public var coordinators: [String : CoordinatorProtocol] = [:]
    public var viewController: UIViewController?
    var tabBarViewController: TabContainerViewController? { return viewController as? TabContainerViewController}
    public var navigationMode: CoordinatorNavigationMode?
    public var presenter: CoordinatorProtocol?
    
    // MARK: - Private properties
    
    private let tabCoordinators: [CoordinatorProtocol]
    private let vcToCoordinatorMap: [UIViewController: CoordinatorProtocol]
    
    // MARK: - LifeCycle
    
    public init(tabFactory: TabContainerTabFactoryProtocol) {
        
        let subCoordinators = tabFactory.coordinators()
        self.tabCoordinators = subCoordinators
        self.vcToCoordinatorMap = subCoordinators.reduce(into: [UIViewController: CoordinatorProtocol](), { (result, coordinator) in
            if let viewController = coordinator.viewController {
                result[viewController] = coordinator
            }
        })
        
        let tabBarViewController = TabContainerViewController()
        
        self.viewController = tabBarViewController
        
        let tabViewControllers = subCoordinators.compactMap { $0.viewController }
        tabBarViewController.setViewControllers(tabViewControllers, animated: false)
        
        super.init()
        
        tabBarViewController.delegate = self
    }
    
    // MARK: - UITabBarControllerDelegate
    
    open func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
    
    open func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        guard let tabModallyPresentedcoordinator = self.vcToCoordinatorMap[viewController] as? TabModallyPresentedProtocol else {
            return true
        }
        
        tabModallyPresentedcoordinator.start(presenter: self)
        return false
    }
}
