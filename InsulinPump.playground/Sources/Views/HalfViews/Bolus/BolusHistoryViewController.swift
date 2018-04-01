import Foundation
import UIKit

public class BolusHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    
    var bolusHistoryTimes = data.bolusHistoryTimes
    var bolusHistoryAmounts = data.bolusHistoryAmounts
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .gray
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = CGRect(x: 0, y: 35, width: Constants.HalfView.width, height: Constants.HalfView.height - 36)
        tableView.allowsSelection = false
        self.view.addSubview(tableView)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        bolusHistoryTimes = data.bolusHistoryTimes
        bolusHistoryAmounts = data.bolusHistoryAmounts
        bolusHistoryTimes.reverse()
        bolusHistoryAmounts.reverse()
        
        tableView.reloadData()
    }
    
    public override func didReceiveMemoryWarning() {
        super.viewDidLoad()
    }
    
    func setupView() {
        view.backgroundColor = .gray
        view.layer.cornerRadius = Constants.HalfView.cornerRadius
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        cell.textLabel?.text = bolusHistoryTimes[row]
        cell.detailTextLabel?.text = bolusHistoryAmounts[row]
        
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
        
        cell.backgroundColor = .gray
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bolusHistoryTimes.count
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 39
    }
}
