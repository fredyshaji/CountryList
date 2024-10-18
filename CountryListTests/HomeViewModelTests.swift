import XCTest
import Combine
@testable import CountryList

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        viewModel = HomeViewModel()
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        cancellables = nil
    }

    func testFetchCountries_WithError() {
        let mockLoader = MockCountryLoader()
        mockLoader.shouldReturnError = true // Set to return an error

        viewModel.loader = mockLoader
        
        // Expectation for async testing
        let expectation = self.expectation(description: "Fetch countries should fail")

        // Fetch the countries
        viewModel.fetchCountries()

        // Observe changes in the `errorMessage` and `isLoading`
        viewModel.$errorMessage
            .dropFirst() // Ignore the initial value
            .sink { errorMessage in
                if let errorMessage = errorMessage {
                    XCTAssertEqual(errorMessage, "Network error: The operation couldn’t be completed. ( error -1.)") // Adjust message as needed
                    expectation.fulfill() // Fulfill the expectation after error
                }
            }
            .store(in: &cancellables)

        // Wait for expectations
        waitForExpectations(timeout: 10.0) { error in
            if let error = error {
                XCTFail("Test failed with error: \(error.localizedDescription)")
            }
        }

        // Assert that hasFetchedCountries is false
        XCTAssertFalse(viewModel.hasFetchedCountries, "hasFetchedCountries should be false on error.")
    }
    
    func testFetchCountries_Success() {
        let mockLoader = MockCountryLoader()
        mockLoader.shouldReturnError = false // Return successful mock data

        viewModel.loader = mockLoader

        // Expectation for async testing
        let expectation = self.expectation(description: "Fetch countries should succeed")

        // Fetch the countries
        viewModel.fetchCountries()

        // Observe changes in `countries` and `isLoading`
        viewModel.$countries
            .dropFirst() // Ignore the initial value
            .sink { countries in
                if !countries.isEmpty {
                    XCTAssertEqual(countries.count, 1, "There should be 2 countries fetched.")
                    XCTAssertEqual(countries[0].name.common, "Nigeria", "First country should be Nigeria.")
                    expectation.fulfill() // Fulfill the expectation after successful fetch
                }
            }
            .store(in: &cancellables)

        // Wait for expectations
        waitForExpectations(timeout: 5.0) { error in
            if let error = error {
                XCTFail("Test failed with error: \(error.localizedDescription)")
            }
        }

        // Assert that hasFetchedCountries is true
        XCTAssertTrue(viewModel.hasFetchedCountries, "hasFetchedCountries should be true after success.")
    }
}
