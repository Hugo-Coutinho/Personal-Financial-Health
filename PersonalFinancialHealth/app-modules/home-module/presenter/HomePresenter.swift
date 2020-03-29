import Foundation
import UIKit

protocol HomePresenterInput {
    static func make(view: HomePresenterToView) -> HomePresenterInput
    func redirectToNewScreenBy(index: Int)
    func checkFinancialBudget()
    func checkCalendarToResetInformation()
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
            BaseRouter.goTo(module: BaseRouter.createModule(viewController: FundsViewController.self))
        case HomeOptionsEnum.myExpensesView.getIndex():
            BaseRouter.goTo(module: BaseRouter.createModule(viewController: ExpenseViewController.self))
        case HomeOptionsEnum.netSalaryView.getIndex():
            BaseRouter.goTo(module: BaseRouter.createModule(viewController: SalaryViewController.self))
        case HomeOptionsEnum.historicalView.getIndex():
            BaseRouter.goTo(module: BaseRouter.createModule(viewController: HistoricalViewController.self))
        default:
            break
        }
    }
    
    func checkFinancialBudget() {
        self.interactor?.checkFinancialBudget()
    }
    
    func checkCalendarToResetInformation() {
        guard Date.IsTodayANewMonth() else { return }
        self.interactor?.resetFinancialInformation()
        self.view.showAlertAppWasReseted()
    }
}

// MARK: - IMPLEMENTS INTERACTOR -
extension HomePresenter: HomeInteractorToPresenter {
    
}
