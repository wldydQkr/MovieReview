//
//  MovieUITests.swift
//  MovieUITests
//
//  Created by 박지용 on 2022/07/05.
//

import XCTest

class MovieUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false // 실패하고 나서도 실행을 할거냐
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        
        app = nil
    }
    
    func test_navigationBar의_title이_영화평점으로_설정되어있다() {
        let existNavigationBar = app.navigationBars["영화 평점"].exists
        XCTAssertTrue(existNavigationBar)
    }
    
    func test_searchBar가_존재한다() {
        let existSearchBar = app.navigationBars["영화 평점"]
            .searchFields["Search"]
            .exists
        
        XCTAssertTrue(existSearchBar)
    }
    
    func test_searchBar에_cancle버튼이_존재한다() {
        let navigationBar = app.navigationBars["영화 평점"]
        navigationBar
            .searchFields["Search"]
            .tap()
        
        let existSearchBarCancleButton = navigationBar
            .buttons["Cancle"]
            .exists
        
        XCTAssertTrue(existSearchBarCancleButton)
    }
}
