//
//  ChessEngine.swift
//  Chess
//
//  Created by Dhruv Shah on 2022-01-06.
//

import Foundation

struct ChessEngine {
    var pieces = Set<ChessPiece>()
    var whitesTurn: Bool = true // Who's Turn Var
    
    mutating func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow:Int) {
   
        if !canMovePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow) {
            return
        }
        
        // find piece to move
        guard let movingPiece = pieceAt(col: fromCol, row: fromRow) else {
            return
        }
        
        
        if let target = pieceAt(col: toCol, row: toRow) {
            pieces.remove(target)
        }
        
        // remove piece and add the piece again at the new location
        pieces.remove(movingPiece)
        pieces.insert(ChessPiece(col: toCol, row: toRow, isWhite: movingPiece.isWhite, imageName: movingPiece.imageName, rank: movingPiece.rank))
        
        whitesTurn = !whitesTurn // Change Turn 
        
    }
    
    func canMovePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow:Int) -> Bool{
        
        if toCol < 0 || toCol > 7 || toRow < 0 || toRow > 7 {
            return false
        }
        
        if fromCol == toCol && fromRow == toRow {
            return false
        }
        
        guard let movingPiece = pieceAt(col: fromCol, row: fromRow) else {
            return false
        }
        
        if let target = pieceAt(col: toCol, row: toRow), target.isWhite == movingPiece.isWhite {
                return false
        }
        
        if movingPiece.isWhite != whitesTurn {
            return false // wrong player's turn
        }
        
        switch movingPiece.rank {
        case .knight:
            return canMoveKnight(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        case .rook:
            return canMoveRook(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        case .bishop:
            return canMoveBishop(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        default:
            return true
        }

    }
    
    func canMoveKnight(fromCol: Int, fromRow: Int, toCol: Int, toRow:Int) -> Bool{
        
        return (abs(fromCol - toCol) == 1 && abs(fromRow - toRow) == 2) || (abs(fromRow - toRow) == 1 && abs(fromCol - toCol) == 2)
    
    }
    
    func canMoveRook(fromCol: Int, fromRow: Int, toCol: Int, toRow:Int) -> Bool{
        
        // Check path is empty:
        if fromRow == toRow { // HORIZONTAL
            
            let minCol = min(fromCol, toCol)
            let maxCol = max(fromCol, toCol)
            
            // One square away:
            if (maxCol - minCol) < 2 {
                return true
            }
            
            for i in (minCol+1)..<(maxCol) {
                if (pieceAt(col: i, row: fromRow)) != nil {
                    return false
                }
            }
            
            return true
        } else if fromCol == toCol { // VERTICAL
            
            let minRow = min(fromRow, toRow)
            let maxRow = max(fromRow, toRow)
            
            // One square away:
            if (maxRow - minRow) < 2 {
                return true
            }
            
            for i in (minRow+1)..<(maxRow) {
                if (pieceAt(col: fromCol, row: i)) != nil {
                    return false
                }
            }
            
            return true
        
        } else {
            return false
        }
    
    }
    // col = vertical row = horizontal
    
    func canMoveBishop(fromCol: Int, fromRow: Int, toCol: Int, toRow:Int) -> Bool {
        
        if abs(fromCol - toCol) == abs(fromRow - toRow) {
            
            let deltaX = fromCol > toCol ? -1 : 1
            let deltaY = fromRow > toRow ? -1 : 1
            
            var fromColPos = fromCol
            var fromRowPos = fromRow
            
            fromColPos += deltaX
            fromRowPos += deltaY
            
            while fromColPos != toCol {
                if (pieceAt(col: fromColPos, row: fromRowPos)) != nil {
                    return false
                }
                fromColPos += deltaX
                fromRowPos += deltaY
            }
            
            return true
            
        } else {
            return false
        }
        
    }
    func isPathEmpty(fromCol: Int, fromRow: Int, toCol: Int, toRow:Int) -> Bool {
        
        // Check same row:
        if fromRow == toRow { // HORIZONTAL
            
            let minCol = min(fromCol, toCol)
            let maxCol = max(fromCol, toCol)
            
            // One square away:
            if (maxCol - minCol) < 2 {
                return true
            }
            
            for i in (minCol+1)..<(maxCol-1) {
                if (pieceAt(col: i, row: fromRow)) != nil {
                    return false
                }
            }
            
            return true
            
        } else if fromCol == toCol { // VERTICAL
            
            let minRow = min(fromRow, toRow)
            let maxRow = max(fromRow, toRow)
            
            // One square away:
            if (maxRow - minRow) < 2 {
                return true
            }
            
            for i in (minRow+1)..<(maxRow-1) {
                if (pieceAt(col: fromCol, row: i)) != nil {
                    return false
                }
            }
            
            return true
        } else if abs(fromCol - toCol) == abs(fromRow - toRow) { // vertical 
            let minCol = min(fromCol, toCol)
            let maxCol = max(fromCol, toCol)
            let minRow = min(fromRow, toRow)
            let maxRow = max(fromRow, toRow)
            
            // Top Left to Bottom Right
            if (fromRow - toRow) == (fromCol - toCol) {
                // One square away:
                if (maxCol - minCol) < 2 {
                    return true
                }
                
                for i in 1..<abs(fromCol - toCol) {
                    if (pieceAt(col: minCol + i, row: minRow + i)) != nil {
                        return false
                    }
                }
            } else {
                // Bottom Left to Top Right
    
                
                // One square away:
                if (maxCol - minCol) < 2 {
                    return true
                }
                
                for i in 1..<abs(fromCol - toCol) {
                    if (pieceAt(col: minCol + i, row: maxRow - i)) != nil {
                        return false
                    }
                }
                
            }
            
            
            
            
           
        }
        
        return false
        
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
        whitesTurn = true 
        pieces.removeAll()
        
        // MARK: Optimized using loop:
        
        // Minor Pieces:
        for i in 0..<2 {
            pieces.insert(ChessPiece(col: (i * 7), row: 0, isWhite: false, imageName: "Rook-black", rank: .rook))
            pieces.insert(ChessPiece(col: (i * 7), row: 7, isWhite: true, imageName: "Rook-white", rank: .rook))
            pieces.insert(ChessPiece(col: 1 + (i * 5), row: 0, isWhite: false, imageName: "Knight-black", rank: .knight))
            pieces.insert(ChessPiece(col: 1 + (i * 5), row: 7, isWhite: true, imageName: "Knight-white", rank: .knight))
            pieces.insert(ChessPiece(col: 2 + (i * 3), row: 0, isWhite: false, imageName: "Bishop-black", rank: .bishop))
            pieces.insert(ChessPiece(col: 2 + (i * 3), row: 7, isWhite: true, imageName: "Bishop-white", rank: .bishop))
        }
        
        // Pawns:
        for col in 0..<8 {
            pieces.insert(ChessPiece(col: col, row: 1, isWhite: false, imageName: "Pawn-black", rank: .pawn))
            pieces.insert(ChessPiece(col: col, row: 6, isWhite: true, imageName: "Pawn-white", rank: .pawn))
        }
        
        // King & Queen:
        pieces.insert(ChessPiece(col: 3, row: 0, isWhite: false, imageName: "Queen-black", rank: .queen))
        pieces.insert(ChessPiece(col: 3, row: 7, isWhite: true, imageName: "Queen-white", rank: .queen))
        
        pieces.insert(ChessPiece(col: 4, row: 0, isWhite: false, imageName: "King-black", rank: .king))
        pieces.insert(ChessPiece(col: 4, row: 7, isWhite: true, imageName: "King-white", rank: .king))
        
        
    }
}


extension ChessEngine: CustomStringConvertible {
    var description: String {
        var desc = ""
        
        desc += "  0 1 2 3 4 5 6 7\n"
        for row in 0..<8 {
            desc += "\(row)"
            for col in 0..<8 {
                if let piece = pieceAt(col: col, row: row) {
                    switch piece.rank {
                    case .king:
                        desc += piece.isWhite ? " k" : " K"
                    case .queen:
                        desc += piece.isWhite ? " q" : " Q"
                    case .bishop:
                        desc += piece.isWhite ? " b" : " B"
                    case .knight:
                        desc += piece.isWhite ? " n" : " N"
                    case .rook:
                        desc += piece.isWhite ? " r" : " R"
                    case .pawn:
                        desc += piece.isWhite ? " p" : " P"
                    }
                } else {
                    desc += " ."
                }
                
           
            }
            desc += "\n"
        }
     
        
        return desc
    }
    
    
}
