//
//  ViewController.swift
//  ThreadingProject
//
//  Created by Nurşah on 25.12.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dizi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = String(dizi[indexPath.row])
        
        return cell
    }
    
    var dizi = [Int]()
    
    let urlString = ["https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg", "https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&w=1000&q=80"]
    var data = Data()
    var str = Data()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for i in 0 ... 24 {
            let carp = i * i
            dizi.append(carp)
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        DispatchQueue.global().async { //global yerine main yazarsak main içinde devam eder async olmaz
            self.data = try! Data(contentsOf: URL(string: self.urlString[0])!)
        }
        DispatchQueue.main.async {
            self.str = self.data
            self.img.image = UIImage(data: self.data)
        }
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.addBtn))
    }
    
    @objc func addBtn() {
        
        DispatchQueue.global().async { //global yerine main yazarsak main içinde devam eder async olmaz
            if self.data == self.str{
                self.data = try! Data(contentsOf: URL(string: self.urlString[1])!)
            }
            else {
                self.data = try! Data(contentsOf: URL(string: self.urlString[0])!)
            }
        }
        DispatchQueue.main.async {
            self.str = self.data
            self.img.image = UIImage(data: self.data)
        }
       
    }


}

