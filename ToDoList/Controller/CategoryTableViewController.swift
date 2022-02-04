//
//  CategoryTableViewController.swift
//  ToDoList
//
//  Created by MAC on 05/08/2021.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoryTableViewController: SwipeTableViewController {

    let realm = try! Realm()
    var categories: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ToDo List"
        loadCat()
        tableView.rowHeight = 70.0
        // to remove seperator in table view between cells
        tableView.separatorStyle = .none
    }

    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add New Category"
            textField = alertTextField
        }
        alert.addAction(UIAlertAction(title: "Add Category", style: .default, handler: { (action) in
            let newCat = Category()
            newCat.name = textField.text!
            newCat.backColor = UIColor.randomFlat().hexValue()
            //we do not need save any thing because results are auto-updating container
//            self.categories.append(newCat)
            self.save(category: newCat)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
// MARK: - Table view data source & delegate

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  return the number of rows
        return categories?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
            
            guard let categoryColor = UIColor(hexString: category.backColor) else {
                fatalError()
            }
            cell.backgroundColor = categoryColor
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? ItemsTableViewController
        if let indexpath = tableView.indexPathForSelectedRow {
            destinationVC?.selectedCat = categories?[indexpath.row]
        }
    }
    
//MARK: - Data Manipulating Methouds
    
    func save(category : Category) {
        do {
            try realm.write({
                realm.add(category)
            })
            tableView.reloadData()
        } catch {
            print("Error in save context , \(error)")
        }
    }
    
    func loadCat() {
        // it will return all itemsArr inside our realm
        categories = realm.objects(Category.self)
    }

    override func updateModel(at indexPath: IndexPath) {
        if let cat = self.categories?[indexPath.row]{
            do{
                try self.realm.write({
                    self.realm.delete(cat)
                })
            }catch{
                print("Error in deleting cat \(error)")
            }
        }
    }
}
