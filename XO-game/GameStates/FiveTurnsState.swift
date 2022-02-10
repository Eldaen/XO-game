//
//  FiveTurnsState.swift
//  XO-game
//
//  Created by Денис Сизов on 10.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

/// Состояние хода игрока для стратегии 5 ходов сразу
final class FiveTurnsState: PlayerInputState {
	
	/// Инвокер команд для исполнения
	var invoker: GameInvoker
	
	init(player: Player,
				  invoker: GameInvoker,
				  markViewPrototype: MarkView,
				  gameViewController: GameViewControllerDelegate,
				  gameboard: Gameboard,
				  gameboardView: GameboardView) {
		self.invoker = invoker
		
		super.init(player: player,
				   markViewPrototype: markViewPrototype,
				   gameViewController: gameViewController,
				   gameboard: gameboard,
				   gameboardView: gameboardView)
	}
	
	override func addMark(at position: GameboardPosition) {
		invoker.addCommand(for: player, at: position)
		self.isCompleted = true
	}
}

