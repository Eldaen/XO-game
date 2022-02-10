//
//  TurnCommand.swift
//  XO-game
//
//  Created by Денис Сизов on 10.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

/// Команда для совершения хода
final class TurnCommand {
	var player: Player
	var position: GameboardPosition
	var gameboard: Gameboard
	var gameboardView: GameboardView
	
	init(player: Player, position: GameboardPosition, gamebaord: Gameboard, gameBoardView: GameboardView) {
		self.player = player
		self.position = position
		self.gameboard = gamebaord
		self.gameboardView = gameBoardView
	}
	
	/// Выполняет команду
	func execute() {
		if !gameboardView.canPlaceMarkView(at: position) {
			gameboardView.removeMarkView(at: position)
			gameboard.removePlayer(at: position)
		}
		
		gameboard.setPlayer(self.player, at: position)
		gameboardView.placeMarkView(player.markViewPrototype, at: position)
	}
}
