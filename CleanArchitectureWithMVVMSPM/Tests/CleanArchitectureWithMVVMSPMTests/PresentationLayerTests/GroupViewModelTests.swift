import XCTest
@testable import PresentationLayer
@testable import DomainLayer
@testable import DataLayer

final class GroupViewModelTests: XCTestCase {
    
    var viewModel: MyGroupListViewModel?
    
    //MARK: - Setup
    
    override func setUpWithError() throws {
        
        viewModel = MyGroupListViewModel(fetchMyGroupListUseCase: FetchMyGroupListUseCase(groupRepository: GroupRepository(groupDataSource: GroupLocalDataSource())))
        
        guard let _ = viewModel else {
            XCTFail()
            return
        }
    }
    
    //MARK: - Tests
    
    func testExecuteFetch() {
        
        let expectation = XCTestExpectation(description: self.description)
        
        let _ = viewModel!.$myGroups.sink { _ in
            
            expectation.fulfill()
        }
        
        viewModel!.executeFetch()
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertGreaterThan(viewModel!.myGroups.count, 0)
    }

    static var allTests = [
        ("testExecuteFetch", testExecuteFetch),
    ]
}
