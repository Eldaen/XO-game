//
//  ComputerTurnState.swift
//  XO-game
//
//  Created by Денис Сизов on 09.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

/// Состояние, в котором ходит комьютер
final class ComputerTurnState: GameState {
	
	private var player: Player = .computer
	private(set) var isCompleted = false
	
	private(set) weak var gameViewController: GameViewControllerDelegate?
	private(set) weak var gameboard: Gameboard?
	private(set) weak var gameboardView: GameboardView?
	
	/// Прототип метки
	let markViewPrototype: MarkView
	
	init(markViewPrototype: MarkView,
		 gameViewController: GameViewControllerDelegate,
		 gameboard: Gameboard,
		 gameboardView: GameboardView) {
		self.markViewPrototype = markViewPrototype
		self.gameViewController = gameViewController
		self.gameboard = gameboard
		self.gameboardView = gameboardView
	}
	
	func begin() {
		self.gameViewController?.hideFirstPlayerLabel(true)
		self.gameViewController?.hideSecondPlayerLabel(false)
		self.gameViewController?.hideWinnderLabel(true)
	}
	
	func addMark(at position: GameboardPosition) {
		guard let gameboardView = self.gameboardView
			, gameboardView.canPlaceMarkView(at: position)
			else { return }
		
		self.gameboard?.setPlayer(player, at: position)
		self.gameboardView?.placeMarkView(markViewPrototype.copy(), at: position)
		self.isCompleted = true
	}
}
