//
//  ChessPiece.swift
//  Chess
//
//  Created by Dhruv Shah on 2022-01-06.
//

import Foundation

struct ChessPiece: Hashable {
    let col: Int
    let row: Int
//    let player: ChessPlayer
    let imageName: String
}