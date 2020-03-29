import Foundation

protocol HomeViewToPresenter {
    var view: HomePresenterToView {get set}
    var interactor: HomePresenterToInteractor? {get set}
}

protocol HomePresenterToView {
//    func showNotice(noticeArray:Array<NoticeModel>)
//    func showError()
}

protocol HomePresenterToRouter {
//    static func createModule()-> NoticeViewController
//    func pushToMovieScreen(navigationConroller:UINavigationController)
}

protocol HomePresenterToInteractor {
    var presenter:HomeInteractorToPresenter {get set}
    static func make(presenter: HomeInteractorToPresenter) -> HomePresenterToInteractor
    func checkFinancialBudget()
}

protocol HomeInteractorToPresenter {

}
