//
//  ChessEngineTests.swift
//  ChessTests
//
//  Created by Dhruv Shah on 2022-02-01.
//

import XCTest
@testable import Chess


class ChessEngineTests: XCTestCase {
    
    func testPrintingEmptyBoard() {
        var game = ChessEngine()
        game.initializeGame()
        print(game)
    }
    
    func testPieceNotOutOfBounds() {
        var game = ChessEngine()
        game.initializeGame()
        XCTAssertFalse(game.canMovePiece(fromCol: 0, fromRow: 7, toCol: -1, toRow: 7))
        XCTAssertFalse(game.canMovePiece(fromCol: 0, fromRow: 7, toCol: 8, toRow: 7))
        XCTAssertFalse(game.canMovePiece(fromCol: 0, fromRow: 7, toCol: 0, toRow: 8))
        XCTAssertFalse(game.canMovePiece(fromCol: 0, fromRow: 7, toCol: 0, toRow: -1))
    }
    
    func testAvoidCapturingOwnPiece() {
        var game = ChessEngine()
        game.initializeGame()
        
        XCTAssertFalse(game.canMovePiece(fromCol: 0, fromRow: 7, toCol: 0, toRow: 6))
        
    }
    
    func testKnightRules() {
        var game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 1, row: 7, isWhite: true, imageName: "", rank: .knight))
        
        
        XCTAssertFalse(game.canMovePiece(fromCol: 1, fromRow: 7, toCol: 1, toRow: 5))
        
    }
    
    func testRookRules() {
        var game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 0, row: 7, isWhite: true, imageName: "", rank: .rook))
        
        
        XCTAssertFalse(game.canMovePiece(fromCol: 0, fromRow: 7, toCol: 1, toRow: 6))
        XCTAssertTrue(game.canMovePiece(fromCol: 0, fromRow: 7, toCol: 0, toRow: 5))
    }
    
    
    
    func testBishopRules() {
        
        var game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 2, row: 7, isWhite: true, imageName: "", rank: .bishop))
        
        XCTAssertFalse(game.canMovePiece(fromCol: 2, fromRow: 7, toCol: 3, toRow: 5))
        game.pieces.insert(ChessPiece(col: 3, row: 6, isWhite: true, imageName: "", rank: .pawn))
        XCTAssertFalse(game.canMovePiece(fromCol: 2, fromRow: 7, toCol: 4, toRow: 5))
        XCTAssertFalse(game.canMovePiece(fromCol: 2, fromRow: 7, toCol: 7, toRow: 2))
        
        
        game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 2, row: 7, isWhite: true, imageName: "", rank: .bishop))
        
        /*
         + 0 1 2 3 4 5 6 7
         0 . . . . . . . .
         1 . . . . . . . .
         2 . . . . . . . .
         3 . . . . . . . .
         4 . . . . . . . .
         5 . . . x . . . .
         6 . . . . . . . .
         7 . . b . . . . .
         */
        XCTAssertFalse(game.canMovePiece(fromCol: 2, fromRow: 7, toCol: 3, toRow: 5))
        
        /*
         + 0 1 2 3 4 5 6 7
         0 . . . . . . . .
         1 . . . . . . . .
         2 . . . . . . . .
         3 . . . . . . . .
         4 . . . . . . . .
         5 . . . . x . . .
         6 . . . . . . . .
         7 . . b . . . . .
         */
        XCTAssertTrue(game.canMovePiece(fromCol: 2, fromRow: 7, toCol: 4, toRow: 5))
        
        /*
         + 0 1 2 3 4 5 6 7
         0 . . . . . . . .
         1 . . . . . . . .
         2 . . . . . . . x
         3 . . . . . . . .
         4 . . . . . . . .
         5 . . . . . . . .
         6 . . . . . . . .
         7 . . b . . . . .
         */
        XCTAssertTrue(game.canMovePiece(fromCol: 2, fromRow: 7, toCol: 7, toRow: 2))
        
        /*
         + 0 1 2 3 4 5 6 7
         0 . . . . . . . .
         1 . . . . . . . .
         2 . . . . . . . .
         3 . . . . . . . .
         4 . . . . . . . .
         5 . . . . x . . .
         6 . . . p . . . .
         7 . . b . . . . .
         */
        game.pieces.insert(ChessPiece(col: 3, row: 6, isWhite: true, imageName: "", rank: .pawn))
        XCTAssertFalse(game.canMovePiece(fromCol: 2, fromRow: 7, toCol: 4, toRow: 5))
        
        /*
         + 0 1 2 3 4 5 6 7
         0 . . . . . . . .
         1 . . . . . . . .
         2 . . . . . . . x
         3 . . . . . . . .
         4 . . . . . . . .
         5 . . . . . . . .
         6 . . . p . . . .
         7 . . b . . . . .
         */
        XCTAssertFalse(game.canMovePiece(fromCol: 2, fromRow: 7, toCol: 7, toRow: 2))
        
        game = ChessEngine()
        game.pieces.insert(ChessPiece(col: 3, row: 3, isWhite: true, imageName: "", rank: .bishop))
        /*
         + 0 1 2 3 4 5 6 7
         0 x . . . . . x .
         1 . n . . . . . .
         2 . . . . n . . .
         3 . . . b . . . .
         4 . . . . . . . .
         5 . n . . . . . .
         6 x . . . . . n .
         7 . . . . . . . x
         */
        game.pieces.insert(ChessPiece(col: 1, row: 1, isWhite: true, imageName: "", rank: .knight))
        game.pieces.insert(ChessPiece(col: 4, row: 2, isWhite: true, imageName: "", rank: .knight))
        game.pieces.insert(ChessPiece(col: 6, row: 6, isWhite: true, imageName: "", rank: .knight))
        game.pieces.insert(ChessPiece(col: 1, row: 5, isWhite: true, imageName: "", rank: .knight))
        XCTAssertFalse(game.canMovePiece(fromCol: 3, fromRow: 3, toCol: 0, toRow: 0))
        XCTAssertFalse(game.canMovePiece(fromCol: 3, fromRow: 3, toCol: 6, toRow: 0))
        XCTAssertFalse(game.canMovePiece(fromCol: 3, fromRow: 3, toCol: 7, toRow: 7))
        XCTAssertFalse(game.canMovePiece(fromCol: 3, fromRow: 3, toCol: 0, toRow: 6))
    }
    
}
