//: [Previous](@previous)

import Foundation
import PlaygroundSupport
import THESimulatorFramework
import Charts

let chartView = ScatterChartView.makeDefault(frame: CGRect(origin: .zero, size: CGSize(width: 400, height: 400)))

class ChartViewController: UIViewController {
    
    let cellIdentifier = "dataCell"
    var infos: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let chartView = ScatterChartView.makeDefault(frame: .zero)
        let random = LinearCongruentialGenerator()
        chartView.setRandomStrategy(random, iterations: 1_000)
        
        infos = [
            "Formalae: ((previous * a) + c ) % m",
            "Seed: \(random.previous)",
            "a: \(random.a)",
            "c: \(random.c)",
            "m: \(random.m)"
        ]
        
        view.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            chartView.heightAnchor.constraint(equalToConstant: 300)
            ])
        
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: chartView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
}

extension ChartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = infos[indexPath.row]
        
        return cell
    }
}

let viewController = ChartViewController()
PlaygroundPage.current.liveView = viewController

//: [Next](@next)
