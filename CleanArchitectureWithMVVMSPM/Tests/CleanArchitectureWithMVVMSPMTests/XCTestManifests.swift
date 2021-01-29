import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(GroupModelDTOTests.allTests),
        testCase(GroupLocalDataSourceTests.allTests),
        testCase(GroupRepositoryTests.allTests),
        testCase(FetchGroupListUseCaseTests.allTests),
        testCase(GroupEntityTests.allTests),
        testCase(GroupViewModelTests.allTests),
    ]
}
#endif
