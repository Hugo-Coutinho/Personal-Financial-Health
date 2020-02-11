import Foundation

protocol HomeViewToPresenter {
    var view: HomePresenterToView {get set}
    var interactor: HomePresenterToInteractor {get set}
    var router: HomePresenterToRouter {get set}
    func startFetchingNotice()
//    func showMovieController(navigationController:UINavigationController)
}

protocol HomePresenterToView {
//    func showNotice(noticeArray:Array<NoticeModel>)
    func showError()
}

protocol HomePresenterToRouter {
//    static func createModule()-> NoticeViewController
//    func pushToMovieScreen(navigationConroller:UINavigationController)
}

protocol HomePresenterToInteractor {
    var presenter:HomePresenterToView {get set}
    func fetchNotice()
}

protocol HomeInteractorToPresenter {
//    func noticeFetchedSuccess(noticeModelArray:Array<NoticeModel>)
    func noticeFetchFailed()
}
