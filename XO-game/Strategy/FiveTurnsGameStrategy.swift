//
//  FiveTurnsGameStrategy.swift
//  XO-game
//
//  Created by Денис Сизов on 10.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

/// Стратегия игры для двух игроков, когда те указывают по 5 клеток
final class FiveTurnsGameStrategy: ClassicGameStrategy {
	
	/// Инвокер выполнения команд
	lazy var invoker: GameInvoker = GameInvoker(gameboard: controller?.gameboard,
												gameboardView: controller?.getGameboardView())
	
	/// Кол-во ходов, которые сделал игрок
	var turnsPerformed: Int = 0
	
	/// Кол-во игроков, которые закончили свои ходы
	var playersFinished: Int = 0
	
	
	override func goToNextState() {
		if turnsPerformed >= 4 {
			playersFinished += 1
			turnsPerformed = 0
			
			if playersFinished >= 2 {
				goToExecutionState()
				return
			}
			
			if let playerInputState = currentState as? FiveTurnsState,
				let controller = controller {
				let player = playerInputState.player.next
				
				self.currentState = FiveTurnsState(
					player: player,
					invoker: invoker,
					markViewPrototype: player.markViewPrototype,
					gameViewController: controller,
					gameboard: controller.gameboard,
					gameboardView: controller.getGameboardView()
				)
			}
		} else {
			turnsPerformed += 1
		}
	
	}
	
	func goToExecutionState() {
		guard let controller = controller else { return }
		
		self.currentState = PerformGameFinishState(
			invoker: invoker,
			gameViewController: controller,
			gameboard: controller.gameboard,
			gameboardView: controller.getGameboardView()
		)
		
		goToWinnerState()
	}
	
	/// Находим победителя
	func goToWinnerState() {
		guard let controller = controller else { return }
		
		if let winner = self.referee.determineWinner() {
			self.currentState = GameEndedState(winner: winner, gameViewController: controller)
			return
		} else {
			self.currentState = GameEndedState(winner: nil, gameViewController: controller)
			return
		}
	}
}
