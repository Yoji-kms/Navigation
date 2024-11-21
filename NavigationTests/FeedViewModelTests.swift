//
//  FeedViewModelTests.swift
//  NavigationTests
//
//  Created by Yoji on 19.11.2024.
//

import Testing
@testable import Navigation

struct FeedViewModelTests {
    let feedViewModel = FeedViewModel()

    @Test func checkGuessTest() async throws {
        #expect(self.feedViewModel.checkGuess(word: "pswrd"))
        #expect(!self.feedViewModel.checkGuess(word: "some word"))
        #expect(self.feedViewModel.checkGuess(word: "another word") == false)
    }
}
