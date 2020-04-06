import Foundation

class HomeInteractor: HomePresenterToInteractor {
    
    // MARK: - PROPERTIES -
    var presenter: HomeInteractorToPresenter
    var worker: CoreDataWorkerInput
    private lazy var blFinancial: BLFinancial = BLFinancial(worker: self.worker)
    
    // MARK: - INITIALIZER -
    init(presenter: HomeInteractorToPresenter) {
        self.presenter = presenter
        self.worker = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
    }
    
    // MARK: - DI -
    static func make(presenter: HomeInteractorToPresenter) -> HomePresenterToInteractor {
        return HomeInteractor.init(presenter: presenter)
    }
    
    func checkFinancialBudget() {
        self.blFinancial.checkFinancialBudget(viewController: HomeViewController.self)
    }
    
    func resetFinancialInformation() {
        let salaryFinancial = BLFinancial(worker: CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorSalary))
        
        salaryFinancial.resetAppSalaryStorage()
        self.blFinancial.resetAppExpenseStorage()
    }
    
    func isUserSubmitSalary() -> Bool {
        return self.blFinancial.getUsefullyFunds() > 0.0
    }
}
