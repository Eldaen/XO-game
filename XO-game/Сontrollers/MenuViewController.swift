//
//  MenuViewController.swift
//  XO-game
//
//  Created by Денис Сизов on 09.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

/// Контроллер меню игры
final class MenuViewController: UIViewController {
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "classicGame" {
			if let controller = segue.destination as? GameViewController {
				controller.strategy = ClassicGameStrategy()
			}
		} else if segue.identifier == "singleGame" {
			if let controller = segue.destination as? GameViewController {
				controller.strategy = SingleGameStrategy()
			}
		}
	}
}
