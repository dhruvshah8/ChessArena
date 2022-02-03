//
//  ChessDelegateController.swift
//  Chess
//
//  Created by Dhruv Shah on 2022-02-02.
//

import Foundation

extension ViewController: ChessDelegate {
    // Whatever data we get from View, we pass -> Engine
    func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        
        updateMove(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        let move: String = "\(fromCol):\(fromRow):\(toCol):\(toRow)"
        // Encode String as UTF8 Data and send data to peers
        if let data = move.data(using: .utf8) {
            try? session.send(data, toPeers: session.connectedPeers, with: .reliable)
        }
    }
    
    func updateMove(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        chessEngine.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        boardView.shawdowPiece = chessEngine.pieces
        boardView.setNeedsDisplay()
        
        if chessEngine.whitesTurn {
            infoLabel.text = "White's Turn"
        } else {
            infoLabel.text = "Blacks Turn"
        }
    }
    
    func pieceAt(col: Int, row: Int) -> ChessPiece? {
        return chessEngine.pieceAt(col: col, row: row)
    }
}
