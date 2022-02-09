//
//  ComputerMind.swift
//  XO-game
//
//  Created by Денис Сизов on 09.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

/// Класс, реализующий логику ходов компьютера
final class ComputerMind {
	var gameboard: Gameboard?
	
	init(gameboard: Gameboard?) {
		self.gameboard = gameboard
	}
	
	func makeTurn() -> GameboardPosition? {
		guard let gameboard = gameboard else {
			return nil
		}

		let sparePositions = gameboard.getSparePositions()
		return sparePositions.randomElement()
	}
}
