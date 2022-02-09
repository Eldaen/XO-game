//
//  ClassicGameStrategy.swift
//  XO-game
//
//  Created by Денис Сизов on 09.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

/// Стратегия классической игры с 2 игроками
final class ClassicGameStrategy: StrategyProtocol {
	
	/// Текущее состояние игры
	var currentState: GameState? {
		didSet {
			self.currentState?.begin()
		}
	}

	weak var controller: GameViewControllerDelegate?
	
	/// Класс - Судья, определяет победителей или конец игры
	private lazy var referee = Referee(gameboard: controller?.gameboard)
	
	/// Переходит в следующее состояние со следующим игроком, если сейчас стостояние PlayerInputState
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
		
		if let playerInputState = currentState as? PlayerInputState,
			let controller = controller {
			let player = playerInputState.player.next
			
			self.currentState = PlayerInputState(
				player: player,
				markViewPrototype: player.markViewPrototype,
				gameViewController: controller,
				gameboard: controller.gameboard,
				gameboardView: controller.getGameboardView()
			)
			referee.nextTurn()
		}
	}
	
	func restart() {
		referee.clearTurns()
	}
}
