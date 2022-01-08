//
//  ChessEngine.swift
//  Chess
//
//  Created by Dhruv Shah on 2022-01-06.
//

import Foundation

struct ChessEngine {
    var pieces = Set<ChessPiece>()
    
    mutating func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow:Int) {
        // find piece to move
        guard let movingPiece = pieceAt(col: fromCol, row: fromRow) else {
            return
        }
        // remove piece and add the piece again at the new location
        pieces.remove(movingPiece)
        pieces.insert(ChessPiece(col: toCol, row: toRow, imageName: movingPiece.imageName))
    }
    
    
    // Find Piece at col and row
    func pieceAt(col: Int, row: Int) -> ChessPiece? {
        for piece in pieces {
            if piece.col == col && piece.row == row {
                return piece
            }
        }
        return nil // no piece found at this place
    }
    
    mutating func initializeGame() {
        pieces.removeAll()
        
        
        // MARK: Optimize using loop:
        pieces.insert(ChessPiece(col: 0, row: 0, imageName: "Rook-black"))
        pieces.insert(ChessPiece(col: 7, row: 0, imageName: "Rook-black"))
        pieces.insert(ChessPiece(col: 0, row: 7, imageName: "Rook-white"))
        pieces.insert(ChessPiece(col: 7, row: 7, imageName: "Rook-white"))
        
        pieces.insert(ChessPiece(col: 1, row: 0, imageName: "Knight-black"))
        pieces.insert(ChessPiece(col: 6, row: 0, imageName: "Knight-black"))
        pieces.insert(ChessPiece(col: 1, row: 7, imageName: "Knight-white"))
        pieces.insert(ChessPiece(col: 6, row: 7, imageName: "Knight-white"))
        
        pieces.insert(ChessPiece(col: 2, row: 0, imageName: "Bishop-black"))
        pieces.insert(ChessPiece(col: 5, row: 0, imageName: "Bishop-black"))
        pieces.insert(ChessPiece(col: 2, row: 7, imageName: "Bishop-white"))
        pieces.insert(ChessPiece(col: 5, row: 7, imageName: "Bishop-white"))
        
        pieces.insert(ChessPiece(col: 3, row: 0, imageName: "Queen-black"))
        pieces.insert(ChessPiece(col: 3, row: 7, imageName: "Queen-white"))
        
        pieces.insert(ChessPiece(col: 4, row: 0, imageName: "King-black"))
        pieces.insert(ChessPiece(col: 4, row: 7, imageName: "King-white"))
        
        pieces.insert(ChessPiece(col: 0, row: 1, imageName: "Pawn-black"))
        pieces.insert(ChessPiece(col: 1, row: 1, imageName: "Pawn-black"))
        pieces.insert(ChessPiece(col: 2, row: 1, imageName: "Pawn-black"))
        pieces.insert(ChessPiece(col: 3, row: 1, imageName: "Pawn-black"))
        pieces.insert(ChessPiece(col: 4, row: 1, imageName: "Pawn-black"))
        pieces.insert(ChessPiece(col: 5, row: 1, imageName: "Pawn-black"))
        pieces.insert(ChessPiece(col: 6, row: 1, imageName: "Pawn-black"))
        pieces.insert(ChessPiece(col: 7, row: 1, imageName: "Pawn-black"))
        
        pieces.insert(ChessPiece(col: 0, row: 6, imageName: "Pawn-white"))
        pieces.insert(ChessPiece(col: 1, row: 6, imageName: "Pawn-white"))
        pieces.insert(ChessPiece(col: 2, row: 6, imageName: "Pawn-white"))
        pieces.insert(ChessPiece(col: 3, row: 6, imageName: "Pawn-white"))
        pieces.insert(ChessPiece(col: 4, row: 6, imageName: "Pawn-white"))
        pieces.insert(ChessPiece(col: 5, row: 6, imageName: "Pawn-white"))
        pieces.insert(ChessPiece(col: 6, row: 6, imageName: "Pawn-white"))
        pieces.insert(ChessPiece(col: 7, row: 6, imageName: "Pawn-white"))
    }
}
