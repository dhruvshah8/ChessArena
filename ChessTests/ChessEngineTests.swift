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
        
        
    }

    
}
