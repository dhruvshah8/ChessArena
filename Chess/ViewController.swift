//
//  ViewController.swift
//  Chess
//
//  Created by Dhruv Shah on 2022-01-06.
//

import UIKit

class ViewController: UIViewController, ChessDelegate{
    
    // Model:
    var chessEngine: ChessEngine = ChessEngine()
    
    // View:
    @IBOutlet weak var boardView: BoardView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Gives the delegate a func for move piece from the current instance (self) which we provide below
        boardView.chessDelegate = self
        
        chessEngine.initializeGame()
        boardView.shawdowPiece = chessEngine.pieces
        boardView.setNeedsDisplay()
    }

    
    // Whatever data we get from View, we pass -> Engine
    func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        chessEngine.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        boardView.shawdowPiece = chessEngine.pieces
        boardView.setNeedsDisplay()
    }
    
}

