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

    func testStartTwiceWithTwoQuestionsRoutesToFirstQuestionTwice() {
        let router = RouterSpy()
        let sut = Flow(router: router, questions: ["Q1", "Q2"])
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func testStartAndAnswearFirstQuestionWithTwoQuestionsRoutesToSecondQuestion() {
        let router = RouterSpy()
        let sut = Flow(router: router, questions: ["Q1", "Q2"])
        
        sut.start()
        
        router.answearCallBack("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var answearCallBack: ((String) -> Void) = { _ in}
        
        func routeTo(question: String, answearCallBack: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answearCallBack = answearCallBack
        }
    }
}
