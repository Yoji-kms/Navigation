import XCTest
@testable import Navigation

class FeedViewModelXCTest: XCTestCase {
    var feedViewModel: FeedViewModel!
    
    override func setUp() {
        super.setUp()
        self.feedViewModel = FeedViewModel()
    }
    
    func checkGuessTest() {
        XCTAssertTrue(self.feedViewModel.checkGuess(word: "pswrd"))
        XCTAssertEqual(self.feedViewModel.checkGuess(word: "pswrd"), true)
    }
}