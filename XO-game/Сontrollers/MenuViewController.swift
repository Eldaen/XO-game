//
//  MenuViewController.swift
//  XO-game
//
//  Created by Денис Сизов on 09.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

final class MenuViewController: UIViewController {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "classicGame" {
			if let controller = segue.destination as? GameViewController {
				controller.strategy = ClassicGameStrategy()
			}
		}
	}
}
