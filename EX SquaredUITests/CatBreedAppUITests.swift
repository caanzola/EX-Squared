import XCTest

class CatBreedAppUITests: XCTestCase {
    
    func testNavigateToDetailPage() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.tables["Cat Breeds List"].exists)
        app.tables.cells.firstMatch.tap()
        XCTAssertTrue(app.staticTexts["Details"].exists)
    }
}
