//
//  InternetPasswordTests.swift
//  DailyBeanAppTests
//
//  Created by Lidiane Gomes Barbosa on 25/05/23.
//

import XCTest
@testable import DailyBeanApp

final class InternetPasswordTests: XCTestCase {
    
    var secureStoreWithInternetPwd: SecureStore!
    
    override func setUp() {
        super.setUp()
        let internetPwdQueryable =
        InternetPasswordQueryable(server: "someServer",
                                  port: 8080,
                                  path: "somePath",
                                  securityDomain: "someDomain",
                                  internetProtocol: .https,
                                  internetAuthenticationType: .httpBasic)
        secureStoreWithInternetPwd =
        SecureStore(secureStoreQueryable: internetPwdQueryable, attrKey: kSecAttrAccount)
    }
    
    override func tearDown() {
        try? secureStoreWithInternetPwd.removeAllValues()
        
        super.tearDown()
    }
    
    func testSaveInternetPassword() {
      do {
        try secureStoreWithInternetPwd.setValue("pwd_1234", for: "internetPassword")
      } catch (let e) {
        XCTFail("Saving Internet password failed with \(e.localizedDescription).")
      }
    }

    func testReadInternetPassword() {
      do {
        try secureStoreWithInternetPwd.setValue("pwd_1234", for: "internetPassword")
        let password = try secureStoreWithInternetPwd.getValue(for: "internetPassword")
        XCTAssertEqual("pwd_1234", password)
      } catch (let e) {
        XCTFail("Reading internet password failed with \(e.localizedDescription).")
      }
    }

    func testUpdateInternetPassword() {
      do {
        try secureStoreWithInternetPwd.setValue("pwd_1234", for: "internetPassword")
        try secureStoreWithInternetPwd.setValue("pwd_1235", for: "internetPassword")
        let password = try secureStoreWithInternetPwd.getValue(for: "internetPassword")
        XCTAssertEqual("pwd_1235", password)
      } catch (let e) {
        XCTFail("Updating internet password failed with \(e.localizedDescription).")
      }
    }

    func testRemoveInternetPassword() {
      do {
        try secureStoreWithInternetPwd.setValue("pwd_1234", for: "internetPassword")
        try secureStoreWithInternetPwd.removeValue(for: "internetPassword")
        XCTAssertNil(try secureStoreWithInternetPwd.getValue(for: "internetPassword"))
      } catch (let e) {
        XCTFail("Removing internet password failed with \(e.localizedDescription).")
      }
    }

    func testRemoveAllInternetPasswords() {
      do {
        try secureStoreWithInternetPwd.setValue("pwd_1234", for: "internetPassword")
        try secureStoreWithInternetPwd.setValue("pwd_1235", for: "internetPassword2")
        try secureStoreWithInternetPwd.removeAllValues()
        XCTAssertNil(try secureStoreWithInternetPwd.getValue(for: "internetPassword"))
        XCTAssertNil(try secureStoreWithInternetPwd.getValue(for: "internetPassword2"))
      } catch (let e) {
        XCTFail("Removing internet passwords failed with \(e.localizedDescription).")
      }
    }

}
