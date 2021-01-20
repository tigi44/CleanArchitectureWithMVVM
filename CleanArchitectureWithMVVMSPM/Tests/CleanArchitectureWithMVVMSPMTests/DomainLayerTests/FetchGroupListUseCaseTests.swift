import XCTest
@testable import DomainLayer
@testable import DataLayer

final class FetchGroupListUseCaseTests: XCTestCase {
    
    var useCase: FetchMyGroupListUseCaseInterface?
    
    //MARK: - Setup
    
    override func setUpWithError() throws {
        
        useCase = FetchMyGroupListUseCase(groupRepository: GroupRepository(groupDataSource: GroupLocalDataSource()))
        
        guard let _ = useCase else {
            XCTFail()
            return
        }
    }
    
    //MARK: - Tests
    
    func testExecute() {
        
        let _ = useCase!.execute { result in
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
        ("testExecute", testExecute),
    ]
}
