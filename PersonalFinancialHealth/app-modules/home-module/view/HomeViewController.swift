
import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var availableFundsView: UIView!
    @IBOutlet weak var myExpensesView: UIView!
    @IBOutlet weak var netSalaryView: UIView!
    @IBOutlet weak var historicalView: UIView!
    
    // MARK: - ENUMS -
    enum homeOptionsEnum: Int {
        case availableFunds = 0
        case myExpensesView = 1
        case netSalaryView = 2
        case historicalView = 3
        
        func getIndex() -> Int {
            return self.rawValue
        }
    }
    
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
        self.redirectToNewScreenBy(index: attachedView.tag)
    }
    
    private func redirectToNewScreenBy(index: Int) {
        switch index {
        case homeOptionsEnum.availableFunds.getIndex():
            print("availableFunds")
        case homeOptionsEnum.myExpensesView.getIndex():
            HomeRouter.navigateTo(module: ExpenseRouter.createModule())
        case homeOptionsEnum.netSalaryView.getIndex():
            print("net salary")
        case homeOptionsEnum.historicalView.getIndex():
            print("historical")
        default:
            break
        }
    }
    
    private func addTag() {
        self.availableFundsView.tag = homeOptionsEnum.availableFunds.getIndex()
        self.myExpensesView.tag = homeOptionsEnum.myExpensesView.getIndex()
        self.netSalaryView.tag = homeOptionsEnum.netSalaryView.getIndex()
        self.historicalView.tag = homeOptionsEnum.historicalView.getIndex()
    }
}
