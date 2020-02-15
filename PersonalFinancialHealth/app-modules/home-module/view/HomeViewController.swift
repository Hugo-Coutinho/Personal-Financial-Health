
import UIKit

// MARK: - ENUMS -
enum HomeOptionsEnum: Int {
    case availableFunds = 0
    case myExpensesView = 1
    case netSalaryView = 2
    case historicalView = 3
    
    func getIndex() -> Int {
        return self.rawValue
    }
}

class HomeViewController: UIViewController {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var availableFundsView: UIView!
    @IBOutlet weak var myExpensesView: UIView!
    @IBOutlet weak var netSalaryView: UIView!
    @IBOutlet weak var historicalView: UIView!
    
    // MARK: - VARIABLES -
    private lazy var presenter: HomePresenterInput = HomePresenter.make(view: self)
}

// MARK: - LIFE CYCLE -
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewAddingGestureToHomeOptions()    
        Coordinator.navController = self.navigationController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configureNavigationItem(hidesBackButton: true)
//        BaseRouter.goTo(module: BaseRouter.createModule(viewController: ExpenseViewController.self))
    }
}

// MARK: - AUX METHODS -
extension HomeViewController {
    private func setupViewAddingGestureToHomeOptions() {
        self.addGesture(view: self.availableFundsView)
        self.addGesture(view: self.myExpensesView)
        self.addGesture(view: self.netSalaryView)
        self.addGesture(view: self.historicalView)
        self.addTag()
    }
    
    private func addGesture(view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapToNewScreen(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapToNewScreen(_ sender: Any) {
        guard let tapGesture = sender as? UITapGestureRecognizer,
            let attachedView = tapGesture.view else { return }
        self.presenter.redirectToNewScreenBy(index: attachedView.tag)
    }
    
    private func addTag() {
        self.availableFundsView.tag = HomeOptionsEnum.availableFunds.getIndex()
        self.myExpensesView.tag = HomeOptionsEnum.myExpensesView.getIndex()
        self.netSalaryView.tag = HomeOptionsEnum.netSalaryView.getIndex()
        self.historicalView.tag = HomeOptionsEnum.historicalView.getIndex()
    }
}

// MARK: - IMPLEMENTS PRESENTER DELEGATE -
extension HomeViewController: HomePresenterToView {
    
}
