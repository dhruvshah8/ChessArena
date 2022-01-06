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

    override func draw(_ rect: CGRect) {
        cellSide = bounds.width * ratio / 8
        originX = bounds.width * (1-ratio)/2
        originY = bounds.height * (1-ratio)/2
        drawBoard()
    }
    
    func drawPieces() {
          for row in 0..<8 {
              for col in 0..<8 {
                  if let piece = chessDelegate?.pieceAt(col: col, row: row), piece != movingPiece {
                      drawPieceAt(col: piece.col, row: piece.row, imageName: piece.imageName)
                  }
              }
          }
          
          if let movingPiece = movingPiece {
              let pieceImage = UIImage(named: movingPiece.imageName)
              pieceImage?.draw(in: CGRect(x: fingerLocationX - cellSide/2, y: fingerLocationY - cellSide/2, width: cellSide, height: cellSide))
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
