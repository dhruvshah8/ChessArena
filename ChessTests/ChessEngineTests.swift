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

}
