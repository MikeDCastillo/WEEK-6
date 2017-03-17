//
//  NameTableViewController.swift
//  SixWeekTest
//
//  Created by Michael Castillo on 3/17/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import UIKit
import GameKit

    //  MARK: - Properties / Life-cycle Func

class NameTableViewController: UITableViewController, UIRefreshControl {

    override func viewDidLoad() {
        super.viewDidLoad()
        PersonController.getNamesFromFirebaseDatabase { (names) in
            self.names = names
        }
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(getter: refreshControl), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)

    }
    
    func textFieldShouldReturn(nameTextField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
    
        return true
    }
    
    var names: [Person] = [] {
            didSet{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    
    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var nameTextField: UITextField!
// MARK: - FIXME
    @IBAction func shuffleButtonTapped(_ sender: Any) {
      //  let randomizer = Int(arc4random_uniform(UInt32(names.count)))
        let randomName = GKLinearCongruentialRandomSource(seed: 1)
        let shuffledNameArray = randomName.arrayByShufflingObjects(in: names)
        print(shuffledNameArray)
    }
    
    func refresh(sender:AnyObject) {
        PersonController.getNamesFromFirebaseDatabase { (names) in
            self.names = names
        }
    }

    
}


    // MARK: - Table view data source

    extension NameTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
    
        //for loop 2 names create sections
        
        return names.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        let name = names[indexPath.row]
        
        cell.textLabel?.text = name.name
        
        return cell
    }

    
}
