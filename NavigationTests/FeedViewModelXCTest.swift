//
//  FeedViewModelXCTest.swift
//  Navigation
//
//  Created by Yoji on 19.11.2024.
//


import XCTest
@testable import Navigation

class FeedViewModelXCTest: XCTestCase {
    var feedViewModel: FeedViewModel!
    
    override func setUp() {
        super.setUp()
        self.feedViewModel = FeedViewModel()
    }
    
    func checkGuessXCTest() {
        XCTAssertTrue(self.feedViewModel.checkGuess(word: "pswrd"))
        XCTAssertFalse(self.feedViewModel.checkGuess(word: "some word"))
        XCTAssertEqual(self.feedViewModel.checkGuess(word: "another word"), false)
    }
}
