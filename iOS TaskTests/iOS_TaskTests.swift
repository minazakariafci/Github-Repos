//
//  iOS_TaskTests.swift
//  iOS TaskTests
//
//  Created by mac on 5/28/21.
//

import XCTest
import RxSwift
import RxCocoa
@testable import iOS_Task

class iOS_TaskTests: XCTestCase {
    var controller : RepositoryViewController!
    override func setUpWithError() throws {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(identifier:"RepositoryViewController")
        controller?.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        controller = nil
    }
   
    func testTableViewDelegates() {
        XCTAssertNotNil(controller.repositoryTableView.delegate)
        XCTAssertNotNil(controller.repositoryTableView.dataSource)
    }
   
    func testNumberOfRowsShouldBe10() {
        XCTAssertEqual(controller.repositoryTableView.numberOfRows(inSection: 0), 10)
    }

    func testCellForRow0() {
        let cell = controller.repositoryTableView.getCellAt(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.titleLabel.text, "Animate")
        XCTAssertEqual(cell.descriptionLabel.text, "Declarative UIView animations without nested closures")
        XCTAssertEqual(cell.forksCountLabel.text, "22")
        XCTAssertEqual(cell.languageLabel.text, "Swift")
        XCTAssertEqual(cell.creationDateLabel.text, "2017-07-23T17:50:37Z")

}
    func test_itemSelected() {
        let tableView = controller.repositoryTableView

           var resultIndexPath: IndexPath? = nil

        let subscription = tableView?.rx.itemSelected
               .subscribe(onNext: { indexPath in
                   resultIndexPath = indexPath
               })

           let testRow = IndexPath(row: 1, section: 0)
        tableView?.delegate!.tableView!(tableView!, didSelectRowAt: testRow)

           XCTAssertEqual(resultIndexPath, testRow)
        subscription?.dispose()
       }



}

