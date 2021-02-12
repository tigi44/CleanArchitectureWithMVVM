import XCTest

import DomainLayerTests
import DataLayerTests
import PresentationLayerTests

var tests = [XCTestCaseEntry]()
tests += DomainLayerTests.allTests()
tests += DataLayerTests.allTests()
tests += PresentationLayerTests.allTests()
XCTMain(tests)
