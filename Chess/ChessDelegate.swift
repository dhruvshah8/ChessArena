//
//  ChessDelegate.swift
//  Chess
//
//  Created by Dhruv Shah on 2022-01-07.
//

import Foundation

// Protocal:
// Essentially a contract to provice a service
protocol ChessDelegate {
  func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int)
}
