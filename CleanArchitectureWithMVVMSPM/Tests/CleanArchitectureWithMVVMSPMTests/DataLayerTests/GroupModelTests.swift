import XCTest
import Combine
@testable import DataLayer
@testable import DomainLayer

final class GroupModelTests: XCTestCase {
    
    let group = [
        "image": "group1",
        "name": "group test",
        "date": "2020.01.01 Mon",
    ]
    
    //MARK: - Setup
    
    override func setUpWithError() throws {
    }
    
    //MARK: - Tests
    
    func testGroupModel() {
        
        let _ = Just(group)
            .tryMap { try JSONSerialization.data(withJSONObject: $0, options: []) }
            .decode(type: GroupModel.self, decoder: JSONDecoder())
            .sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            } receiveValue: { groupModel in
                XCTAssertEqual(groupModel.image, self.group["image"])
                XCTAssertEqual(groupModel.name, self.group["name"])
                XCTAssertEqual(groupModel.date, self.group["date"])
                
                let groupEntity = groupModel.dotMyGroupEntity()
                XCTAssertEqual(groupEntity.id, groupModel.name)
                XCTAssertEqual(groupEntity.image, groupModel.image)
                XCTAssertEqual(groupEntity.name, groupModel.name)
                XCTAssertEqual(groupEntity.date, groupModel.date)
            }
    }

    static var allTests = [
        ("testGroupModel", testGroupModel),
    ]
}
