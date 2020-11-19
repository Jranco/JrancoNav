//
//  TabModallyPresentedProtocol.swift
//  AufmassGenerator
//
//  Created by Thomas Segkoulis on 19.11.20.
//  Copyright © 2020 Thomas Segkoulis. All rights reserved.
//

import Foundation
import JrancoMVVMC

public protocol TabModallyPresentedProtocol where Self: CoordinatorProtocol {
    var modallyPresentedCoordinator: CoordinatorProtocol { get }
}

extension TabModallyPresentedProtocol {
    func start(presenter: CoordinatorProtocol) {
        modallyPresentedCoordinator.start(presenter: presenter, withNavigationMode: .modal)
    }
}
