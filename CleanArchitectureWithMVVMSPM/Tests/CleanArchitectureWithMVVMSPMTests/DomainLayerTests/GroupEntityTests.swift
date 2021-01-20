import XCTest
@testable import DomainLayer

final class GroupEntityTests: XCTestCase {
    
    let group = [
        "image": "group1",
        "name": "group test",
        "date": "2020.01.01 Mon",
    ]
    
    //MARK: - Setup
    
    override func setUpWithError() throws {
    }
    
    //MARK: - Tests
    
    func testGroupEntity() {
        
        let groupEntity = MyGroupEntity(id: "0", image: group["image"]!, name: group["name"]!, date: group["date"]!)
        XCTAssertEqual(groupEntity.id, "0")
        XCTAssertEqual(groupEntity.image, group["image"]!)
        XCTAssertEqual(groupEntity.name, group["name"]!)
        XCTAssertEqual(groupEntity.date, group["date"]!)
    }

    static var allTests = [
        ("testGroupEntity", testGroupEntity),
    ]
}
