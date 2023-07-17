import Foundation
import XCTest

@testable import QuizEssentialDeveloper

class FlowTest: XCTestCase {
    
    func testStartWithNoQuestionsDoesNotRouteToQuestion() {
        let router = RouterSpy()
        let sut = Flow(router: router, questions: [])
        
        sut.start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func testStartWithOneQuestionsRoutesToCorrectQuestion() {
        let router = RouterSpy()
        let sut = Flow(router: router, questions: ["Q1"])
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func testStartWithOneQuestionsRoutesToCorrectQuestion2() {
        let router = RouterSpy()
        let sut = Flow(router: router, questions: ["Q2"])
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func testStartWithTwoQuestionsRoutesFirstQuestion() {
        let router = RouterSpy()
        let sut = Flow(router: router, questions: ["Q1" , "Q2"])
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        
        func routeTo(question: String) {
            routedQuestions.append(question)
        }
    }
}
