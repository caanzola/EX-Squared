import XCTest
@testable import EX_Squared

class CatBreedViewModelTests: XCTestCase {
    
    var viewModel: BreedListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = BreedListViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFetchBreeds() {
        let expectation = self.expectation(description: "Fetching breeds")
        
        viewModel.fetchBreeds()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(self.viewModel.breeds.count > 0, "Breeds should be fetched")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
