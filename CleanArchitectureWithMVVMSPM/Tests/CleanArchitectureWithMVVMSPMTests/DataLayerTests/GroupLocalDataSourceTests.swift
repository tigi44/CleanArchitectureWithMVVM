import XCTest
@testable import DataLayer

final class GroupLocalDataSourceTests: XCTestCase {
    
    var dataSource: GroupDataSourceInterface?
    
    //MARK: - Setup
    
    override func setUpWithError() throws {
        
        dataSource = GroupLocalDataSource()
        
        guard let _ = dataSource else {
            XCTFail()
            return
        }
    }
    
    //MARK: - Tests
    
    func testFetchMyGroupList() {
        
        let _ = dataSource!.fetchMyGroupList { result in
            switch result {
            case .success(let myGroups):
                XCTAssertGreaterThan(myGroups.count, 0)
                for myGroup in myGroups {
                    XCTAssertNotNil(myGroup.name)
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }

    static var allTests = [
        ("testFetchMyGroupList", testFetchMyGroupList),
    ]
}
