//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Денис Сизов on 08.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

/// Состояние хода игрока
public class PlayerInputState: GameState {
	
	public var isCompleted = false
	
	public let player: Player
	private(set) weak var gameViewController: GameViewControllerDelegate?
	private(set) weak var gameboard: Gameboard?
	private(set) weak var gameboardView: GameboardView?
	
	/// Прототип метки
	public let markViewPrototype: MarkView
	
	init(player: Player,
		 markViewPrototype: MarkView,
		 gameViewController: GameViewControllerDelegate,
		 gameboard: Gameboard,
		 gameboardView: GameboardView) {
		self.player = player
		self.markViewPrototype = markViewPrototype
		self.gameViewController = gameViewController
		self.gameboard = gameboard
		self.gameboardView = gameboardView
	}
	
	public func begin() {
		switch self.player {
		case .first:
			self.gameViewController?.hideFirstPlayerLabel(false)
			self.gameViewController?.hideSecondPlayerLabel(true)
		case .second:
			self.gameViewController?.hideFirstPlayerLabel(true)
			self.gameViewController?.hideSecondPlayerLabel(false)
		case .computer:
			return
		}
		self.gameViewController?.hideWinnderLabel(true)
	}
	
	public func addMark(at position: GameboardPosition) {
		guard let gameboardView = self.gameboardView
			, gameboardView.canPlaceMarkView(at: position)
			else { return }
		
		self.gameboard?.setPlayer(self.player, at: position)
		self.gameboardView?.placeMarkView(markViewPrototype.copy(), at: position)
		self.isCompleted = true
	}
}
