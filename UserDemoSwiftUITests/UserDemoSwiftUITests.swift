//
//  UserDemoSwiftUITests.swift
//  UserDemoSwiftUITests
//
//  Created by Rudra on 26/02/21.
//

import XCTest
@testable import UserDemoSwiftUI

class MockDataService: DataService {
    func getUsers(completion: @escaping ([User]) -> Void) {
        completion([User(id: 1, name: "John", location: "Sri Lanka")])
    }
}

class UserDemoSwiftUITests: XCTestCase {

    var sut: ViewModel!
        
        override func setUpWithError() throws {
            sut = ViewModel(dataService: MockDataService())
        }

        override func tearDownWithError() throws {
            sut = nil
        }
        
        func test_getUsers() throws {
            XCTAssertTrue(sut.users.isEmpty)
            
            sut.getUsers()
            
            XCTAssertEqual(sut.users.count, 1)
        }
    
    func test_getUserName() throws {
        XCTAssertTrue(sut.users.isEmpty)
        
        sut.getUsers()
        
        XCTAssertEqual(sut.users.first?.name, "John")
    }

}
