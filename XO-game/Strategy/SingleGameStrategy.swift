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
	
	private lazy var computer = ComputerMind(gameboard: controller?.gameboard)
	
	/// Текущее состояние игры
	var currentState: GameState? {
		didSet {
			self.currentState?.begin()
			if let currentState = currentState as? ComputerTurnState,
			   let position = getComputerTurn() {
				currentState.addMark(at: position)
				
				if currentState.isCompleted {
					goToNextState()
				}
			}
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
			referee.nextTurn()
		} else if currentState is ComputerTurnState,
				  let controller = controller {
			let player = Player.first
			
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
	
	/// Возвращает позицию, в которую пошёл компьютер
	func getComputerTurn() -> GameboardPosition? {
		let position = computer.makeTurn()
		return position
	}
}
