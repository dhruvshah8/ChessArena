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
        if fromCol == toCol && fromRow == toRow {
            return
        }
        
        // find piece to move
        guard let movingPiece = pieceAt(col: fromCol, row: fromRow) else {
            return
        }
        // remove piece and add the piece again at the new location
        pieces.remove(movingPiece)
        pieces.insert(ChessPiece(col: toCol, row: toRow, isWhite: movingPiece.isWhite, imageName: movingPiece.imageName))
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
        
        // MARK: Optimized using loop:
        
        // Minor Pieces:
        for i in 0..<2 {
            pieces.insert(ChessPiece(col: (i * 7), row: 0, isWhite: false, imageName: "Rook-black"))
            pieces.insert(ChessPiece(col: (i * 7), row: 7, isWhite: true, imageName: "Rook-white"))
            pieces.insert(ChessPiece(col: 1 + (i * 5), row: 0, isWhite: false, imageName: "Knight-black"))
            pieces.insert(ChessPiece(col: 1 + (i * 5), row: 7, isWhite: true, imageName: "Knight-white"))
            pieces.insert(ChessPiece(col: 2 + (i * 3), row: 0, isWhite: false, imageName: "Bishop-black"))
            pieces.insert(ChessPiece(col: 2 + (i * 3), row: 7, isWhite: true, imageName: "Bishop-white"))
        }
        
        // Pawns:
        for col in 0..<8 {
            pieces.insert(ChessPiece(col: col, row: 1, isWhite: false, imageName: "Pawn-black"))
            pieces.insert(ChessPiece(col: col, row: 6, isWhite: true, imageName: "Pawn-white"))
        }
        
        // King & Queen:
        pieces.insert(ChessPiece(col: 3, row: 0, isWhite: false, imageName: "Queen-black"))
        pieces.insert(ChessPiece(col: 3, row: 7, isWhite: true, imageName: "Queen-white"))
        
        pieces.insert(ChessPiece(col: 4, row: 0, isWhite: false, imageName: "King-black"))
        pieces.insert(ChessPiece(col: 4, row: 7, isWhite: true, imageName: "King-white"))
        
        
    }
}
