//
//  CopyingProtocol.swift
//  XO-game
//
//  Created by Денис Сизов on 08.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

/// Протокол для реализации паттерна Prototype
protocol Copying {
	init(_ prototype: Self)
}

// MARK: - Copying extension

extension Copying {
	func copy() -> Self {
		return type(of: self).init(self)
	}
}
