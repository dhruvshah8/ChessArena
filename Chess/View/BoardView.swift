//
//  BoardView.swift
//  Chess
//
//  Created by Dhruv Shah on 2022-01-06.
//

import UIKit

class BoardView: UIView {
    
    // Variables to hold previous location of piece
    var fromCol: Int? = nil // Current Moving Piece
    var fromRow: Int? = nil
    var movingImage: UIImage? = nil // Dragable Piece
    var movingPieceX: CGFloat = 0
    var movingPieceY: CGFloat = 0
    
    
    // To change layout -> Put Black player on top or bottom
    var blackOnTop = true
    
    // Board and Piece Dimensions:
    let ratio: CGFloat = 0.95
    var originX: CGFloat = 0.0
    var originY: CGFloat = 0.0
    var cellSize: CGFloat = 0.0
    
    
    // Mirrors Pieces from Model using Delegate:
    var shawdowPiece: Set<ChessPiece> = Set<ChessPiece>()
    var chessDelegate: ChessDelegate? = nil // Takes input from user and updates the model
    
    
    
    // draw: overrides function of drawing the UIView each time
    override func draw(_ rect: CGRect) {
        cellSize = bounds.width * ratio / 8
        originX = bounds.width * (1-ratio)/2
        originY = bounds.height * (1-ratio)/2
        drawBoard()
        drawPieces()
    }
    
    
    // DRAW BOARD:
    func drawBoard()  {
        for row in 0..<4 {
            for col in 0..<4 {
                drawSquare(col: col*2, row: row * 2, color: UIColor.white)
                drawSquare(col: 1 + col * 2, row: row * 2, color: UIColor.lightGray)
                drawSquare(col: 1 + col * 2, row: 1 + row * 2, color: UIColor.white)
                drawSquare(col: col*2, row: 1 + row * 2, color: UIColor.lightGray)
            }
        }
    }
    
    // DRAW EACH SQUARE ON BOARD
    func drawSquare(col: Int, row: Int, color:UIColor) {
        let path = UIBezierPath(rect: CGRect(x: originX + CGFloat(col) * cellSize, y: originY + CGFloat(row) * cellSize, width: cellSize, height: cellSize))
        color.setFill()
        path.fill()
    }
    
    
    // DRAW PIECES
    func drawPieces() {
        // Hide Piece if its moving as it is already rendered
        for piece in shawdowPiece where piece.col != fromCol || piece.row != fromRow {
            let pieceImage = UIImage(named: piece.imageName)
            
            pieceImage?.draw(in: CGRect(x: originX + CGFloat(flipBoard(piece.col)) * cellSize, y: originY + CGFloat(flipBoard(piece.row)) * cellSize, width: cellSize, height: cellSize))
        }
        
        movingImage?.draw(in: CGRect(x: movingPieceX - cellSize/2, y: movingPieceY - cellSize/2, width: cellSize, height: cellSize))
    }
    
    
    // If Black on Top then essentially flip all the pieces on board
    // Use whenever dealing with a cordinate (row or col)
    func flipBoard(_ coordinate: Int) -> Int {
        return blackOnTop ? coordinate : 7 - coordinate
    }
    
}


// MARK: User Input

extension BoardView {
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let fingerLocation = touch.location(in: self)
        movingPieceX = fingerLocation.x
        movingPieceY = fingerLocation.y
        setNeedsDisplay() // trigger drawing draw(_ rect:CGRect)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first! // one touch is always going to be in set thus ! is safe
        let fingerLocation = touch.location(in: self)
        fromCol = flipBoard(Int((fingerLocation.x - originX) / cellSize))
        fromRow = flipBoard(Int((fingerLocation.y - originY) / cellSize))
        
        if let fromCol = fromCol, let fromRow = fromRow, let movingPiece = chessDelegate?.pieceAt(col: fromCol, row: fromRow) {
            movingImage = UIImage(named: movingPiece.imageName)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let fingerLocation = touch.location(in: self)
        let toCol = flipBoard(Int((fingerLocation.x - originX) / cellSize))
        let toRow = flipBoard(Int((fingerLocation.y - originY) / cellSize))
        
        if let fromCol = fromCol, let fromRow = fromRow, fromCol != toCol || fromRow != toRow {
            chessDelegate?.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        }
        
        movingImage = nil
        fromCol = nil
        fromRow = nil
        setNeedsDisplay()
    }
}
