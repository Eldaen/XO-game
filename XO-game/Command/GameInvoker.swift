//
//  GameInvoker.swift
//  XO-game
//
//  Created by Денис Сизов on 10.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

/// Инвокер команд игры
final class GameInvoker {
	var commands: [TurnCommand] = []
	var gameboard: Gameboard?
	var gameboardView: GameboardView?
	
	init(gameboard: Gameboard?, gameboardView: GameboardView?) {
		self.gameboard = gameboard
		self.gameboardView = gameboardView
	}
	
	/// Добавляет команду в список команд
	func addCommand(for player: Player, at position: GameboardPosition) {
		guard let gameboard = gameboard,
			let gameboardView = gameboardView else {
			return
		}

		commands.append(TurnCommand(player: player,
									position: position,
									gamebaord: gameboard,
									gameBoardView: gameboardView))
	}
	
	/// Запускает все комманды
	func execute() {
		commands.forEach { $0.execute() }
	}
}
