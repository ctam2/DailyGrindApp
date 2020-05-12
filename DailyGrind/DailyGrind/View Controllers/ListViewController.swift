//
//  ListViewController.swift
//  DailyGrind
//
//  Created by Christy Tam on 5/8/20.
//  Copyright © 2020 Christy Tam. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!

    var todos: [String] = ["Get Groceries", "Buy Food", "Sleep"]
    var currentTodoArray = [String]()
    var searching = false
    
    //var ref:DatabaseReference?
    //var databaseHandle:DatabaseHandle?
    //var todos = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 80
        searchBar.delegate = self

        
        /*ref = Database.database().reference()
        
        databaseHandle = ref?.child("Tasks").observe(.childAdded, with: { (snapshot) in
            let todos = snapshot.value as? String
            
           if let actualPost = todos {
                    self.todos.append(actualPost)
                }
            })*/
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }*/
    
    // Search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentTodoArray = todos.filter({$0.prefix(searchText.count) == searchText})
        searching = true
        table.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return currentTodoArray.count
        }
        else {
        return todos.count
        }
   
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoCell
        if searching {
            cell.todoLabel?.text = currentTodoArray[indexPath.row]
        } else {
            cell.todoLabel?.text = todos[indexPath.row]
        }
        cell.todoLabel.text = todos[indexPath.row]
        return cell
        //let cell =  tableView.dequeueReusableCell(withIdentifier: "cell")
        
        //cell?.textLabel?.text = todos[indexPath.row]
        //return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TodoCell
        
        if cell.isChecked == false {
            cell.checkmarkImage.image = UIImage(named: "checkmark.png")
            cell.isChecked = true
        }
        else {
            cell.checkmarkImage.image = nil
            cell.isChecked = false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            table.reloadData()
        }
    }
    
    
    @IBAction func didTapAddButton(_ sender: Any) {
        
        let todoAlert = UIAlertController(title: "New Task", message: "What do you need to do today?", preferredStyle: .alert)
        todoAlert.addTextField()
        
        let didTapAddButtonAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let newTodo = todoAlert.textFields![0]
            self.todos.append(newTodo.text!)
            self.table.reloadData()
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        todoAlert.addAction(didTapAddButtonAction)
        todoAlert.addAction(cancelAction)
        
        present(todoAlert, animated: true, completion: nil)
        
        /*let enter = storyboard?.instantiateViewController(withIdentifier: "enter") as! EntryViewController
        
        view.window?.rootViewController = enter
        view.window?.makeKeyAndVisible()*/
    }
    
}
