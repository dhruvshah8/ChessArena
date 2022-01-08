//
//  BoardView.swift
//  Chess
//
//  Created by Dhruv Shah on 2022-01-06.
//

import UIKit

class BoardView: UIView {
    
    let ratio: CGFloat = 0.8
    var originX: CGFloat = 0
    var originY: CGFloat = 0
    var cellSide: CGFloat = 35
    
    var shawdowPiece: Set<ChessPiece> = Set<ChessPiece>()

    override func draw(_ rect: CGRect) {
        cellSide = bounds.width * ratio / 8
        originX = bounds.width * (1-ratio)/2
        originY = bounds.height * (1-ratio)/2
        drawBoard()
        drawPieces()
    }
    
    func drawPieces() {
        for piece in shawdowPiece {
            let pieceImage = UIImage(named: piece.imageName)
            pieceImage?.draw(in: CGRect(x: originX + CGFloat(piece.col) * cellSide, y: originY + CGFloat(piece.row) * cellSide, width: cellSide, height: cellSide))
        }
      }
    
    func drawBoard()  {
        
        
        for row in 0..<4 {
            for col in 0..<4 {
                drawSquare(col: col*2, row: row * 2, color: UIColor.white)
                drawSquare(col: 1 + col * 2, row: row * 2, color: UIColor.lightGray)
                drawSquare(col: col*2, row: 1 + row * 2, color: UIColor.lightGray)
                drawSquare(col: 1 + col * 2, row: 1 + row * 2, color: UIColor.white)
            }
        }
    }
    
    func drawSquare(col: Int, row: Int, color:UIColor) {
        let path = UIBezierPath(rect: CGRect(x: originX + CGFloat(col) * cellSide, y: originY + CGFloat(row) * cellSide, width: cellSide, height: cellSide))
        color.setFill()
        path.fill()
    }


}
