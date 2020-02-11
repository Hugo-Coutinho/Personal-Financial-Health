import Foundation
import UIKit

class HomeRouter: BaseRouter {
    // MARK: - OVERRIDE -
    override class func createModule() -> HomeViewController {
        return  UIStoryboard.getViewController(HomeViewController.self)
    }
    
    // MARK: - PUSH VIEW CONTROLLER -
    class func navigateTo<T>(module: T) where T: UIViewController {
        self.goTo(module: module)
    }
}
