//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
	
	/// Игровое поле, на котором можно размещать метки (крестики / нолики)
	private let gameboard = Gameboard()
	
	/// Текущее состояние игры
	private var currentState: GameState! {
		didSet {
			self.currentState.begin()
		}
	}
	
	/// Номер хода
	private var turn: Int = 1
	
	/// Класс - Судья, определяет победителей или конец игры
	private lazy var referee = Referee(gameboard: self.gameboard)
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.goToFirstState()
		
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
			self.currentState.addMark(at: position)
			
			if self.currentState.isCompleted {
				self.goToNextState()
			}
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        
    }
	
	// MARK: - Private
	
	/// Запускает первое состояние
	private func goToFirstState() {
		self.currentState = PlayerInputState(
			player: .first,
			gameViewController: self,
			gameboard: gameboard,
			gameboardView: gameboardView
		)
	}
	
	/// Переходит в следующее состояние со следующим игроком, если сейчас стостояние PlayerInputState
	private func goToNextState() {
		
		// Проверяем, не закончилась ли ещё игра
		if let winner = self.referee.determineWinner() {
			self.currentState = GameEndedState(winner: winner, gameViewController: self)
			return
		}
		
		// Проверяем, не заполнены ли все поле
		if turn == 9 {
			self.currentState = GameEndedState(winner: nil, gameViewController: self)
			return
		}
		
		if let playerInputState = currentState as? PlayerInputState {
			self.currentState = PlayerInputState(
				player: playerInputState.player.next,
				gameViewController: self,
				gameboard: gameboard,
				gameboardView: gameboardView
			)
			self.turn += 1
		}
	}
}

