//
//  SecureStateTests.swift
//  DailyBeanAppTests
//
//  Created by Lidiane Gomes Barbosa on 25/05/23.
//

import XCTest
@testable import DailyBeanApp

final class SecureStateTests: XCTestCase {

    var secureStoreStatus: SecureStatusStore!
    var calendarHelper = CalendarHelper(calendar: .current)
    
    override func setUp() {
        super.setUp()
        let statusQueryable = SecureStatusQueryable()
        let secureStore = SecureStore(secureStoreQueryable: statusQueryable, attrKey: kSecAttrApplicationTag)
        secureStoreStatus =
        SecureStatusStore(calendar: calendarHelper, secureStore: secureStore)
    }
    
    override func tearDown() {
        secureStoreStatus.removeAllValues()
        
        super.tearDown()
    }
    
    func testSaveAndReadTodayStatus() {
        secureStoreStatus.saveDailyStatus(.overjoyed)
        let value = secureStoreStatus.getStatus(for: calendarHelper.today())
        XCTAssertEqual(.overjoyed, value)
    }
    
    func testSaveAndReadStatus() {
        let today = calendarHelper.today()
        let nextMonth = calendarHelper.plusMonth(today) ?? Date()
        secureStoreStatus.saveStatus(.pained, for: nextMonth)
        let value = secureStoreStatus.getStatus(for: nextMonth)
        XCTAssertEqual(.pained, value)
    }
}
