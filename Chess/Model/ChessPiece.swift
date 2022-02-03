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
    let isWhite: Bool // true: white, false: black
    let imageName: String
    let rank: ChessRank
}


/*         C
           O
           L
 
           0 1 2 3 4 5 6 7
  ROW    0 R N B Q K B N R
         1 P P P P P P P P
         2 . . . . . . . .
         3 . . . . . . . .
         4 . . . . . . . .
         5 . . . . . . . .
         6 p p p p p p p p
         7 r n b q k b n r
 
         
 */
