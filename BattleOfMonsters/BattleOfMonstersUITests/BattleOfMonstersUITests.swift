//
//  BattleOfMonstersUITests.swift
//  BattleOfMonstersUITests
//
//  Created by Lukas Ferreira on 03/01/23.
//

import XCTest

class BasePage {
    var app = XCUIApplication()
}

class LazyLoadPage: BasePage {
    lazy var descendants = app.descendants(matching: .any)
    lazy var scrowViews =  app.scrollViews.otherElements
    lazy var monsterListElements = scrowViews.scrollViews["MonsterListView"].otherElements
    lazy var monsterBattleCardListElements = scrowViews.scrollViews["MonsterBattleCardListView"].otherElements

    func getMonsterBattleCardName(with name: String) -> XCUIElement {
        return monsterBattleCardListElements.descendants(matching: .any).staticTexts[name].firstMatch
    }
    func tapStrongestMonsterCard() {
        let firstMonsterCard = monsterListElements.children(matching: .any).element(boundBy: 2)
        XCTAssertTrue(firstMonsterCard.waitForExistence(timeout: 5), "Third MonsterCardView does not exist.")
        firstMonsterCard.tap()
    }
    func tapWeakestMonsterCard() {
        let firstMonsterCard = monsterListElements.children(matching: .any).element(boundBy: 0)
        XCTAssertTrue(firstMonsterCard.waitForExistence(timeout: 5), "First MonsterCardView does not exist.")
        firstMonsterCard.tap()
    }
}

class BattleOfMonstersUITests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    override class func setUp() {
        let app = XCUIApplication()
        app.launchEnvironment = ["ISTESTING": "true"]
        app.launch()
    }

    func testIfElementsExist() throws {
        let lazyLoadPage = LazyLoadPage()
        let descendants = lazyLoadPage.descendants
        let scrollViews = lazyLoadPage.scrowViews
        let monsterListElements = lazyLoadPage.monsterListElements
        let monsterBattleCardListElements = lazyLoadPage.monsterBattleCardListElements
        let playerMonster = lazyLoadPage.getMonsterBattleCardName(with: "PlayerBattleCard")
        let cpuMonster = lazyLoadPage.getMonsterBattleCardName(with: "CPUBattleCard")

        let startButton = descendants["StartButtonView"]

        XCTAssertEqual(descendants.scrollViews.count, 3)
        XCTAssertEqual(scrollViews.scrollViews.count, 2)
        XCTAssertTrue(descendants["TitleTextView"].exists)
        XCTAssertTrue(descendants["SubTitleTextView"].exists)
        XCTAssertTrue(scrollViews.scrollViews["MonsterListView"].exists)
        XCTAssertTrue(monsterListElements.staticTexts["Angry Snake"].waitForExistence(timeout: 2))
        XCTAssertTrue(scrollViews.scrollViews["MonsterBattleCardListView"].exists)
        XCTAssertTrue(monsterBattleCardListElements.staticTexts.element.waitForExistence(timeout: 2))
        XCTAssertTrue(playerMonster.waitForExistence(timeout: 2))
        XCTAssertTrue(cpuMonster.waitForExistence(timeout: 2))
        XCTAssertTrue(startButton.exists)
        XCTAssertEqual(startButton.label, "Start Battle")
    }
    
    func testButtonShouldBeEnabledIfMonsterIsSelected() throws {
        let lazyLoadPage = LazyLoadPage()
        let descendants = lazyLoadPage.descendants
        let monsterListElements = lazyLoadPage.monsterListElements
        let startButton = descendants["StartButtonView"]
        
        XCTAssertTrue(startButton.exists)
        XCTAssertFalse(startButton.isEnabled)
        
        let playerMonsterStaticText = monsterListElements.staticTexts["Red Dragon"]
        XCTAssertTrue(playerMonsterStaticText.exists)
        playerMonsterStaticText.tap()
        
        XCTAssertTrue(startButton.isEnabled)
    }
    
    func testBattleResultIfPlayerWins() throws {
      let app = XCUIApplication()

      app.launch()
      
      let lazyLoadPage = LazyLoadPage()

      // Tap the first monster in the list
      lazyLoadPage.tapStrongestMonsterCard()

      // Ensure the Start button is enabled and tap it
      let startButton = lazyLoadPage.descendants["StartButtonView"]
      XCTAssertTrue(startButton.exists, "StartButtonView does not exist.")
      XCTAssertTrue(startButton.isEnabled, "Start button should be enabled.")
      startButton.tap()

      // Wait for the WinnerView to appear
      let winnerTextView = app.staticTexts["WinnerTextView"]
      XCTAssertTrue(winnerTextView.waitForExistence(timeout: 5), "WinnerTextView did not appear.")

      XCTAssertEqual(winnerTextView.label, "Red Dragon wins!", "The player should win the battle.")
  }

    
    func testBattleResultIfPlayerLoses() throws {
      let app = XCUIApplication()
      app.launch()
      
      let lazyLoadPage = LazyLoadPage()

      // Tap the first monster in the list
      lazyLoadPage.tapWeakestMonsterCard()

      // Ensure the Start button is enabled and tap it
      let startButton = lazyLoadPage.descendants["StartButtonView"]
      XCTAssertTrue(startButton.exists, "StartButtonView does not exist.")
      XCTAssertTrue(startButton.isEnabled, "Start button should be enabled.")
      startButton.tap()



      let winnerTextView = app.staticTexts["WinnerTextView"]
              XCTAssertTrue(winnerTextView.waitForExistence(timeout: 5), "WinnerTextView did not appear.")
              XCTAssertNotEqual(winnerTextView.label, "Dead unicorn wins!", "The computer should win the battle.")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                let app = XCUIApplication()
                app.launchEnvironment = ["ISTESTING": "true"]
                app.launch()
            }
        }
    }
}
