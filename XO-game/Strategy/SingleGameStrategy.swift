//
//  SingleGameStrategy.swift
//  XO-game
//
//  Created by Денис Сизов on 09.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

/// Класс для одиночной игры с компьютером
final class SingleGameStrategy: StrategyProtocol {
	
	weak var computer: ComputerMindProtocol?
	
	/// Текущее состояние игры
	var currentState: GameState? {
		didSet {
			self.currentState?.begin()
		}
	}

	weak var controller: GameViewControllerDelegate?
	
	/// Класс - Судья, определяет победителей или конец игры
	private lazy var referee = Referee(gameboard: controller?.gameboard)
	
	func goToNextState() {
		
		// Проверяем, не закончилась ли ещё игра
		if let winner = self.referee.determineWinner(),
			let controller = controller {
			self.currentState = GameEndedState(winner: winner, gameViewController: controller)
			return
		}
		
		// Проверяем, не заполнены ли все поля
		if referee.endByTurns() {
			if let controller = controller {
				self.currentState = GameEndedState(winner: nil, gameViewController: controller)
				return
			}
		}
		
		if let _ = currentState as? PlayerInputState,
			let controller = controller {
			let player = Player.computer
			
			self.currentState = ComputerTurnState(
				markViewPrototype: player.markViewPrototype,
				gameViewController: controller,
				gameboard: controller.gameboard,
				gameboardView: controller.getGameboardView()
			)
			self.currentState?.begin()
			controller.computerTurn()
			referee.nextTurn()
		}
	}
	
	func restart() {
		referee.clearTurns()
	}
	
	/// Возвращает позицию, в которую пошёл компьютер
	func getComputerTurn() -> GameboardPosition {
		return GameboardPosition(column: 1, row: 1)
	}
}
