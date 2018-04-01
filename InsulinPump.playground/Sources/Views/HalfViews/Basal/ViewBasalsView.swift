import Foundation
import UIKit

public class ViewBasalsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let basalTimes = ["12:00 AM - 5:59 AM",
                      "6:00 AM - 10:59 AM",
                      "11:00 AM - 4:59 PM",
                      "5:00 PM - 8:59 PM",
                      "9:00 PM - 11:59 PM"]
    
    let basalRates = ["0.8 U/h",
                      "0.9 U/h",
                      "1.0 U/h",
                      "0.9 U/h",
                      "1.1 U/h"]
    
    let tableView = UITableView()

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
        cell.textLabel?.text = basalTimes[row]
        cell.detailTextLabel?.text = basalRates[row]
        
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
        
        cell.backgroundColor = .gray
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basalTimes.count
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 39
    }
}
