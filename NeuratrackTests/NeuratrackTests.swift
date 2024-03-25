//
//  NeuratrackTests.swift
//  NeuratrackTests
//
//  Created by Kyle Galloway on 15/01/2024.
//

import XCTest
import OrderedCollections

@testable import Neuratrack

final class NeuratrackTests: XCTestCase {
    
    
    let testYear: Int = 2023
    let testEventsData: [HeadacheEvent] = [HeadacheEvent(date: try! Date("2023-01-01T00:30:00Z",strategy: .iso8601) , analgesiaTaken: false, analgesics: [], note: ""),
                                           HeadacheEvent(date: try! Date("2023-01-02T00:00:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: [], note: ""),
                                           HeadacheEvent(date: try! Date("2023-01-03T00:00:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: [], note: ""),
                                           HeadacheEvent(date: try! Date("2023-01-10T00:00:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: [], note: ""),
                                           HeadacheEvent(date: try! Date("2023-01-11T00:00:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: [], note: ""),
                                           HeadacheEvent(date: try! Date("2023-01-20T00:00:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: [], note: ""),
                                           HeadacheEvent(date: try! Date("2023-01-22T00:00:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: [], note: ""),
                                           HeadacheEvent(date: try! Date("2023-01-23T00:00:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: [], note: ""),
                                           HeadacheEvent(date: try! Date("2023-01-24T00:00:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: [], note: ""),
                                           HeadacheEvent(date: try! Date("2023-01-25T00:00:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: [], note: "")]
    
    
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWeeksCountfilterCalculation() throws
    {
        let expectedResult: OrderedDictionary<Int, Int> = [1:2,2:2,3:2,4:3,5:0,6:0,7:0,8:0,9:0,10:0,11:0,12:0,13:0,14:0,15:0,16:0,17:0,18:0,19:0,20:0,21:0,22:0,23:0,24:0,25:0,26:0,27:0,28:0,29:0,30:0,31:0,32:0,33:0,34:0,35:0,36:0,37:0,38:0,39:0,40:0,41:0,42:0,43:0,44:0,45:0,46:0,47:0,48:0,49:0,50:0,51:0,52:1,53:0]
        
        let result = testEventsData.getEventCountsByWeekOfYear_Filter()
        
        XCTAssertEqual(result, expectedResult)
        
    }
    
    func testWeeksCountReduceCalculation() throws
    {
        let expectedResult: OrderedDictionary<Int, Int> = [1:2,2:2,3:2,4:3,52:1]
        let result = testEventsData.getEventCountsByWeekOfYear_Reduce()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testWeeksCountFilterPerformance() throws
    {
        
        let testMaxEventsData: [HeadacheEvent] = [HeadacheEvent].init(repeating: HeadacheEvent(date: try! Date("2023-01-01T00:30:00Z",strategy: .iso8601) , analgesiaTaken: false, analgesics: [], note: ""), count: 100)
        
        self.measure {
            let counts = testMaxEventsData.getEventCountsByWeekOfYear_Filter()
        }
    }
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
