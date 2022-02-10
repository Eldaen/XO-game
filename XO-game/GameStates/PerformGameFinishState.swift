//
//  PerformGameFInishState.swift
//  XO-game
//
//  Created by Денис Сизов on 10.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class PerformGameFinishState: GameState {

	
	/// Инвокер команд для исполнения
	var invoker: GameInvoker
	
	var isCompleted: Bool = false
	
	private(set) weak var gameViewController: GameViewControllerDelegate?
	private(set) weak var gameboard: Gameboard?
	private(set) weak var gameboardView: GameboardView?
	
	init(invoker: GameInvoker,
		 gameViewController: GameViewControllerDelegate,
		 gameboard: Gameboard,
		 gameboardView: GameboardView) {
		self.invoker = invoker
		self.gameViewController = gameViewController
		self.gameboard = gameboard
		self.gameboardView = gameboardView
	}
	
	func begin() {
		invoker.execute()
	}
	
	func addMark(at position: GameboardPosition) { }
	
}
