//
//  ViewController.swift
//  KekaHR
//
//  Created by Naga on 29/04/24.
//

import UIKit

// MARK: NewsViewController
class NewsViewController: UIViewController {
    
    let viewModel: NewsViewModel = NewsViewModel()
    
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

// MARK: UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.docs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as? NewsTableViewCell {
            cell.displayData(doc: viewModel.docs[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}


extension NewsViewController {
    func initialSetup() {
        fetchNews()
        observeEvent()
    }
    
    func fetchNews() {
        viewModel.fetchNews()
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else {
                return
            }
            switch event {
            case .loading:
                break
            case .stopLoading:
                break
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            case .error(let error):
                print("Error Loading News - ", error?.localizedDescription ?? "Unknown Error")
            }
        }
    }
}

