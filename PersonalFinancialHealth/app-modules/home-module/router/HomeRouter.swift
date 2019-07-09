import Foundation
import UIKit

class HomeRouter {
    static func createModule() -> HomeViewController {
        return  UIStoryboard.getViewController(HomeViewController.self)
    }
}
