import Foundation
import UIKit

protocol HomePresenterInput {
    static func make(view: HomePresenterToView) -> HomePresenterInput
    func redirectToNewScreenBy(index: Int)
}

class HomePresenter: HomeViewToPresenter, HomePresenterInput {
    
    // MARK: - PROPERTIES -
    var view: HomePresenterToView
    var interactor: HomePresenterToInteractor?
    
    // MARK: - INITIALIZER -
    init(view: HomePresenterToView) {
        self.view = view
        self.interactor = HomeInteractor.make(presenter: self)
    }
    
    // MARK: - DI -
    static func make(view: HomePresenterToView) -> HomePresenterInput {
        return HomePresenter.init(view: view)
    }
    
    // MARK: - METHODS -
    func redirectToNewScreenBy(index: Int) {
        switch index {
        case HomeOptionsEnum.availableFunds.getIndex():
            print("availableFunds")
        case HomeOptionsEnum.myExpensesView.getIndex():
            BaseRouter.goTo(module: BaseRouter.createModule(viewController: ExpenseViewController.self))
        case HomeOptionsEnum.netSalaryView.getIndex():
            print("net salary")
        case HomeOptionsEnum.historicalView.getIndex():
            print("historical")
        default:
            break
        }
    }
}

// MARK: - IMPLEMENTS INTERACTOR -
extension HomePresenter: HomeInteractorToPresenter {
    
}
