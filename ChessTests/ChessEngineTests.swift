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
    
}
