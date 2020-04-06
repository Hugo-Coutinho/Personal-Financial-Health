import Foundation

protocol HomeViewToPresenter {
    var view: HomePresenterToView {get set}
    var interactor: HomePresenterToInteractor? {get set}
}

protocol HomePresenterToView {
    func showAlertAppWasReseted()
    func showAlertSubmitSalary()
}

protocol HomePresenterToRouter { }

protocol HomePresenterToInteractor {
    var presenter:HomeInteractorToPresenter {get set}
    static func make(presenter: HomeInteractorToPresenter) -> HomePresenterToInteractor
    func checkFinancialBudget()
    func resetFinancialInformation()
    func isUserSubmitSalary() -> Bool
}

protocol HomeInteractorToPresenter {
    
}
