//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

/// Протокол делегата контроллера
protocol GameViewControllerDelegate: AnyObject {
	
	/// Поле для игры, на нём размещаются метки
	var gameboard: Gameboard { get }
	
	/// Устанавливает текст в лэйбле победителя
	func setWinnerText(with string: String)
	
	/// Показать/Спрятать лэйбл первого игрока
	func hideFirstPlayerLabel(_ bool: Bool)
	
	/// Показать/Спрятать лэйбл второго игрока
	func hideSecondPlayerLabel(_ bool: Bool)
	
	/// Показать/Спрятать лэйбл победителя
	func hideWinnderLabel(_ bool: Bool)
	
	/// Возвращает ссылку на текущий GameboardView
	func getGameboardView() -> GameboardView
}

/// Основной контроллер игры
final class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
	
	/// Cтратегия режима игры
	var strategy: StrategyProtocol?
	
	/// Игровое поле, на котором можно размещать метки (крестики / нолики)
	internal var gameboard = Gameboard()
    
	override func viewDidLoad() {
		super.viewDidLoad()
		self.goToFirstState()
		strategy?.controller = self
		
		
		gameboardView.onSelectPosition = { [weak self] position in
			guard let self = self,
				  let strategy = self.strategy,
				  let currentState = strategy.currentState else { return }
			
			currentState.addMark(at: position)
			
			if currentState.isCompleted {
				strategy.goToNextState()
			}
		}
		
	}
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
		gameboardView.clear()
		gameboard.clear()
		viewDidLoad()
		strategy?.restart()
    }
	
	// MARK: - Private
	
	/// Запускает первое состояние
	private func goToFirstState() {
		let player = Player.first
		
		if let strategy = strategy as? FiveTurnsGameStrategy {
			strategy.currentState = FiveTurnsState(
				player: player,
				invoker: strategy.invoker,
				markViewPrototype: player.markViewPrototype,
				gameViewController: self,
				gameboard: gameboard,
				gameboardView: gameboardView
			)
		} else {
			strategy?.currentState = PlayerInputState(
				player: player,
				markViewPrototype: player.markViewPrototype,
				gameViewController: self,
				gameboard: gameboard,
				gameboardView: gameboardView
			)
		}
	}
	
}

// MARK: - GameViewControllerDelegate

extension GameViewController: GameViewControllerDelegate {
	func setWinnerText(with string: String) {
		winnerLabel.text = string
	}
	
	func hideFirstPlayerLabel(_ bool: Bool) {
		firstPlayerTurnLabel.isHidden = bool
	}
	
	func hideSecondPlayerLabel(_ bool: Bool) {
		secondPlayerTurnLabel.isHidden = bool
	}
	
	func hideWinnderLabel(_ bool: Bool) {
		winnerLabel.isHidden = bool
	}
	
	func getGameboardView() -> GameboardView {
		self.gameboardView
	}

}

