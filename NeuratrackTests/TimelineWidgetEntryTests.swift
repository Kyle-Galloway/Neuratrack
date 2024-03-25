//
//  TimelineWidgetEntryTests.swift
//  NeuratrackTests
//
//  Created by Kyle Galloway on 03/02/2024.
//

import XCTest
@testable import Neuratrack

final class TimelineWidgetEntryTests: XCTestCase {

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
    
    let testEventsData2: [HeadacheEvent] = [HeadacheEvent(date: try! Date("2023-01-12T00:00:00Z",strategy: .iso8601) , analgesiaTaken: false, analgesics: [], note: ""),
                                           HeadacheEvent(date: try! Date("2023-03-29T00:00:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: [], note: ""),
                                           HeadacheEvent(date: try! Date("2023-06-29T00:00:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: [], note: ""),
                                           HeadacheEvent(date: try! Date("2023-08-03T00:00:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: [], note: ""),
                                           HeadacheEvent(date: try! Date("2023-09-11T00:00:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: [], note: ""),
                                           HeadacheEvent(date: try! Date("2023-10-17T00:00:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: [], note: ""),
                                           HeadacheEvent(date: try! Date("2023-11-01T00:00:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: [], note: ""),
                                           HeadacheEvent(date: try! Date("2023-11-03T00:00:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: [], note: ""),
                                           HeadacheEvent(date: try! Date("2023-12-13T00:00:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: [], note: ""),
                                           HeadacheEvent(date: try! Date("2023-12-23T00:00:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: [], note: "")]
    
    
    let daysBetweenEventsDataSet2 = [76,92,35,39,36,15,2,40,10]
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testMostConsecutiveEventsCalculation() throws
    {
        // Given (Arrange)
        let timelineEntry: TextWidgetEntry = TextWidgetEntry(date:Date(),year:testYear,events: testEventsData)
        let expectedResult: Int = 4
        
        // When (Act)
        let result = timelineEntry.events.mostConsecutiveEvents()
        // Then (Assert)
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func testMostDaysBetweenEventsCalculation() throws{
        // Given (Arrange)
        let timelineEntry: TextWidgetEntry = TextWidgetEntry(date:Date(),year:testYear,events: testEventsData)
        let expectedResult: Int = 9
        
        // When (Act)
        let result = try timelineEntry.events.mostDaysBetweenEvents(year:testYear)
        // Then (Assert)
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func testDaysBetweenEventsCalculation() throws
    {
        // Given (Arrange)
        //let timelineEntry: TextWidgetEntry = TextWidgetEntry(date:Date(),year:testYear,events: testEventsData)
        
        let timelineEntry: TextWidgetEntry = TextWidgetEntry(date:Date(),year: testYear, events: testEventsData2)
        //let expectedResult: [Int] = [0,0,7,0,9,2,0,0,0]
        let expectedResult: [Int] = daysBetweenEventsDataSet2
        // When (Act)
        let result = try timelineEntry.events.daysBetweenEvents(year:testYear)
        // Then (Assert)
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func testAveragesEventsPerMonthCalculation() throws
    {
        // Given (Arrange)
        let timelineEntry: TextWidgetEntry = TextWidgetEntry(date:Date(),year:testYear,events: testEventsData)
        let expectedResult: Double = 10.0/12.0
        
        // When (Act)
        let result = timelineEntry.events.averageEventsPerMonth()
        // Then (Assert)
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func testAverageEventsPerWeekCalculation() throws
    {
        // Given (Arrange)
        let timelineEntry: TextWidgetEntry = TextWidgetEntry(date:Date(),year:testYear,events: testEventsData)
        let expectedResult: Double = 10.0/52.0
        
        // When (Act)
        let result = timelineEntry.events.averageEventsPerWeek()
        // Then (Assert)
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func testTotalEventsCalculation() throws
    {
        // Given (Arrange)
        let timelineEntry: TextWidgetEntry = TextWidgetEntry(date:Date(),year:testYear,events: testEventsData)
        let expectedResult: Int = 10
        
        // When (Act)
        let result = timelineEntry.events.totalEvents()
        // Then (Assert)
        
        XCTAssertEqual(result, expectedResult)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
