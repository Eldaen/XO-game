//
//  Gameboard.swift
//  XO-game
//
//  Created by Evgeny Kireev on 27/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public final class Gameboard {
    
    // MARK: - Properties
    
    private lazy var positions: [[Player?]] = initialPositions()
    
    // MARK: - public
    
    public func setPlayer(_ player: Player, at position: GameboardPosition) {
        positions[position.column][position.row] = player
    }
	
	public func removePlayer(at position: GameboardPosition) {
		positions[position.column][position.row] = nil
	}
    
    public func clear() {
        self.positions = initialPositions()
    }
    
    public func contains(player: Player, at positions: [GameboardPosition]) -> Bool {
        for position in positions {
            guard contains(player: player, at: position) else {
                return false
            }
        }
        return true
    }
    
    public func contains(player: Player, at position: GameboardPosition) -> Bool {
        let (column, row) = (position.column, position.row)
        return positions[column][row] == player
    }
	
	/// Возвращает список пустых позиций
	public func getSparePositions() -> [GameboardPosition] {
		var sparePositions: [Int: Int] = [:]
		
		for (rowIndex, row) in positions.enumerated() {
			for (columnIndex, column) in row.enumerated() {
				if column == nil {
					sparePositions.updateValue(rowIndex, forKey: columnIndex)
				}
			}
		}
		
		return sparePositions.map { GameboardPosition(column: $1, row: $0) }
	}
    
    // MARK: - Private
    
    private func initialPositions() -> [[Player?]] {
        var positions: [[Player?]] = []
        for _ in 0 ..< GameboardSize.columns {
            let rows = Array<Player?>(repeating: nil, count: GameboardSize.rows)
            positions.append(rows)
        }
        return positions
    }

}
