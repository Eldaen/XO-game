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
	
	private let gameboard = Gameboard()
	private var currentState: GameState! {
		didSet {
			self.currentState.begin()
		}
	}
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.goToFirstState()
		
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.gameboardView.placeMarkView(XView(), at: position)
			
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
		if let playerInputState = currentState as? PlayerInputState {
			self.currentState = PlayerInputState(
				player: playerInputState.player.next,
				gameViewController: self,
				gameboard: gameboard,
				gameboardView: gameboardView
			)
		}
	}
}

