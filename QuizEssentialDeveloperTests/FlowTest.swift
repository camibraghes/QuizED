import Foundation
import XCTest

@testable import QuizEssentialDeveloper

class FlowTest: XCTestCase {
    
    func testStartWithNoQuestionsDoesNotRouteToQuestion() {
        let router = RouterSpy()
        let sut = Flow(router: router, questions: [])
        print(router.routedQuestionCount)
        sut.start()
        print(router.routedQuestionCount)

        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    func testStartWithOneQuestionsRoutesToQuestion() {
        let router = RouterSpy()
        let sut = Flow(router: router, questions: ["Q1"])

        sut.start()
        print(router.routedQuestionCount)

        XCTAssertEqual(router.routedQuestionCount, 1)
    }
    
    func testStartWithTwoQuestionsRoutesToQuestion() {
        let router = RouterSpy()
        let sut = Flow(router: router, questions: ["Q1", "Q2"])

        sut.start()
        print(router.routedQuestionCount)

        XCTAssertEqual(router.routedQuestionCount, 2)
    }

    class RouterSpy: Router {
        var routedQuestionCount = 0
        
        func routeTo(question: String) {
            routedQuestionCount += 1
        }
    }
}
