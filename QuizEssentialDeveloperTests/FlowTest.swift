import Foundation
import XCTest

@testable import QuizEssentialDeveloper

class FlowTest: XCTestCase {
    var router: RouterSpy!
    
    override func setUp() {
        super.setUp()
        router = RouterSpy()
    }
    
    func testStartWithNoQuestionsDoesNotRouteToQuestion() {
        makeSUT(questions: []).start()
                
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func testStartWithOneQuestionsRoutesToCorrectQuestion() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func testStartWithOneQuestionsRoutesToCorrectQuestion2() {
        makeSUT(questions: ["Q2"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func testStartWithTwoQuestionsRoutesFirstQuestion() {
        makeSUT(questions: ["Q1", "Q2"]).start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func testStartTwiceWithTwoQuestionsRoutesToFirstQuestionTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func testStartAndAnswearFirstQuestionWithTwoQuestionsRoutesToSecondQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        router.answearCallBack("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    func testStartAndAnswearFirstQuestionWithOneQuestionsDoesntRoutesToQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        
        router.answearCallBack("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func testStartAndAnswearFirstAndSecondQuestionWithThreeQuestionsRoutesToSecondAnsThirdQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        
        router.answearCallBack("A1")
        router.answearCallBack("A2")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    // MARK: - Helpers
    
    func makeSUT(questions: [String]) -> Flow {
        return Flow(router: router, questions: questions)
    }
    
    // MARK: - Spies
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var answearCallBack: Router.AnswerCallBack = { _ in}
        
        func routeTo(question: String, answearCallBack: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answearCallBack = answearCallBack
        }
    }
}
