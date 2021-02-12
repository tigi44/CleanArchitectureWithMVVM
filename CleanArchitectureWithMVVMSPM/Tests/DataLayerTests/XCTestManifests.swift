import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(WeatherDTOTests.allTests),
        testCase(WeatherDataSourceTests.allTests),
        testCast(WeatherRepositoryTests.allTests),
    ]
}
#endif
