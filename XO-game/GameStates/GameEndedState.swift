//
//  GameEndedState.swift
//  XO-game
//
//  Created by Денис Сизов on 08.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

/// Cостояние окончания игры. Либо победа одного игрока, либо ничья.
public class GameEndedState: GameState {
	
	public let isCompleted = false
	
	public let winner: Player?
	private(set) weak var gameViewController: GameViewControllerDelegate?
	
	init(winner: Player?, gameViewController: GameViewControllerDelegate) {
		self.winner = winner
		self.gameViewController = gameViewController
	}
	
	public func begin() {
		self.gameViewController?.hideWinnderLabel(false)
		if let winner = winner {
			self.gameViewController?.setWinnerText(with: self.winnerName(from: winner) + " win")
		} else {
			self.gameViewController?.setWinnerText(with: "No winner")
		}
		self.gameViewController?.hideFirstPlayerLabel(true)
		self.gameViewController?.hideSecondPlayerLabel(true)
	}
	
	public func addMark(at position: GameboardPosition) { }
	
	private func winnerName(from winner: Player) -> String {
		switch winner {
		case .first: return "1st player"
		case .second: return "2nd player"
		}
	}
}
