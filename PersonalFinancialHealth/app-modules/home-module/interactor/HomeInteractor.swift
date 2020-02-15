import Foundation

class HomeInteractor: HomePresenterToInteractor {
    
    // MARK: - PROPERTIES -
    var presenter: HomeInteractorToPresenter
    
    // MARK: - INITIALIZER -
    init(presenter: HomeInteractorToPresenter) {
        self.presenter = presenter
    }
    
    // MARK: - DI -
    static func make(presenter: HomeInteractorToPresenter) -> HomePresenterToInteractor {
        return HomeInteractor.init(presenter: presenter)
    }
}
