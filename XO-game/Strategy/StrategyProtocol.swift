//
//  StrategyProtocol.swift
//  XO-game
//
//  Created by Денис Сизов on 09.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

/// Протокол для стратегии игры
protocol StrategyProtocol {
	
	/// Текущее состояние игры
	var currentState: GameState? { get set }
	
	/// Делегат контроллера
	var controller: GameViewControllerDelegate? { get set }
	
	/// Переводит игру в следующее состояние
	func goToNextState()
	
	/// Перезапускает текущую игру
	func restart()
}
