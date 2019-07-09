
import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var availableFundsView: UIView!
    @IBOutlet weak var myExpensesView: UIView!
    @IBOutlet weak var netSalaryView: UIView!
    @IBOutlet weak var historicalView: UIView!
}

// MARK: - LIFE CYCLE -
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
}

// MARK: - AUX METHODS -
extension HomeViewController {
    private func setupView() {
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
    redirectToNewScreenBy(index: attachedView.tag)
    }
    
    private func redirectToNewScreenBy(index: Int) {
        switch index {
        case 0:
            print("availableFunds")
        case 1:
            print("expenses")
        case 2:
            print("net salary")
        case 3:
            print("historical")
        default:
            break
        }
    }
    
    private func addTag() {
        self.availableFundsView.tag = 0
        self.myExpensesView.tag = 1
        self.netSalaryView.tag = 2
        self.historicalView.tag = 3
    }
}
