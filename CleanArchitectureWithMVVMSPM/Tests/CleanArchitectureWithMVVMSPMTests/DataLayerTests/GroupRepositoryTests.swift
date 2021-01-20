import XCTest
@testable import DataLayer

final class GroupRepositoryTests: XCTestCase {
    
    var reposotory: GroupRepository?
    
    //MARK: - Setup
    
    override func setUpWithError() throws {
        
        reposotory = GroupRepository(groupDataSource: GroupLocalDataSource())
        
        guard let _ = reposotory else {
            XCTFail()
            return
        }
    }
    
    //MARK: - Tests
    
    func testFetchMyGroupList() {
        
        let _ = reposotory!.fetchMyGroupList { result in
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
