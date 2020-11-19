//
//  TabContainerTabFactoryProtocol.swift
//  AufmassGenerator
//
//  Created by Thomas Segkoulis on 07.11.20.
//  Copyright © 2020 Thomas Segkoulis. All rights reserved.
//

import Foundation
import JrancoMVVMC

public protocol TabContainerTabFactoryProtocol {
    func coordinators() -> [CoordinatorProtocol]
}
