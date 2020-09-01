//
//  ViewController.swift
//  PARSE_JSON_TABLE
//
//  Created by Hoang Tung Lam on 9/1/20.
//  Copyright © 2020 Hoang Tung Lam. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource{
    
    @IBOutlet weak var lblNodata: UILabel!
    @IBOutlet weak var tblData: UITableView!
    
    var number = 0
    var post = [Post]()
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("aaaa")
        fetchPostData { (posts) in
            if (posts.count != 0) {
                self.number = posts.count
                self.post = posts
                
            }
            else{
                self.tblData.isHidden = true
                self.lblNodata.isHidden = false
            }
            // cap nhat lai tren table (1 luong chay song song voi lay du lieu)
            DispatchQueue.main.async{
                self.tblData.reloadData()
                self.refreshControl.attributedTitle = NSAttributedString(string: "loading...")
                self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
                self.tblData.addSubview(self.refreshControl)
            }
            
        }
        lblNodata.isHidden = true
        tblData.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        tblData.dataSource = self
    }
    
    // so dong table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return number
    }
    
    // set cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.setupUI(data: post[indexPath.row])
        return cell
    }
    
    // ham lay du lieu json
    func fetchPostData(completionHandler: @escaping ([Post]) -> Void) {
        let url = URL(string: "https://demo0737597.mockable.io/master_data")!
        
        _ = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            
            do{
                let postData = try JSONDecoder().decode(Root.self, from: data)
                
                completionHandler(postData.data)
            }
            catch{
                let error = error
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    @objc func refresh(_ sender: UIRefreshControl){
        sender.endRefreshing()
        self.tblData.reloadData()
    }
    
}

