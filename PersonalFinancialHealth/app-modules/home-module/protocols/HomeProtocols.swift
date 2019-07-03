//
//  login-protocols.swift
//  VIPER-demo
//
//  Created by Bipin on 6/29/18.
//  Copyright © 2018 Tootle. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: class{
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingHome()
    func showMovieController(navigationController:UINavigationController)

}

protocol PresenterToViewProtocol: class{
    func showHome(homeArray:Array<HomeModel>)
    func showError()
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> HomeViewController
    func pushToMovieScreen(navigationConroller:UINavigationController)
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchHome()
}

protocol InteractorToPresenterProtocol: class {
    func homeFetchedSuccess(homeModelArray:Array<HomeModel>)
    func homeFetchFailed()
}
