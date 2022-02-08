//
//  GameState.swift
//  XO-game
//
//  Created by Денис Сизов on 08.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

/// Описывает одно из состояний игры
public protocol GameState {
	
	/// Выполнено ли текущее состояние, можно ли идти дальше
	var isCompleted: Bool { get }
	
	/// Реализует текущее состояние, настроить внешний вид и логику, подготовиться
	func begin()
	
	/// Добавляет либо крестик, либо нолик на игровое поле
	func addMark(at position: GameboardPosition)
}
