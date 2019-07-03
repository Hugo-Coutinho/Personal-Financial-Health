import Foundation
import UIKit

class HomePresenter:ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func startFetchingHome() {
        interactor?.fetchHome()
    }
    
    func showMovieController(navigationController: UINavigationController) {
        router?.pushToMovieScreen(navigationConroller:navigationController)
    }

}

extension HomePresenter: InteractorToPresenterProtocol{
    
    func homeFetchedSuccess(homeModelArray: Array<HomeModel>) {
        view?.showHome(homeArray: homeModelArray)
    }
    
    func homeFetchFailed() {
        view?.showError()
    }
    
    
}
