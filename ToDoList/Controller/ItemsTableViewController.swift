//
//  ItemsTableViewController.swift
//  ToDoList
//
//  Created by MAC on 05/08/2021.
//

import UIKit
//import RealmSwift
//import ChameleonFramework

class ItemsTableViewController: SwipeTableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    /*
    var itemsArr : Results<Item>?
    let realm = try! Realm()
    var selectedCat : Category? {
        didSet{
            self.loadItems()
        }
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedCat?.name
        tableView.rowHeight = 70.0
        tableView.separatorStyle = .none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let color = selectedCat?.backColor {
            guard let navCon = navigationController?.navigationBar else { fatalError("navigation controller is nil") }
            
            if let navBarColor = UIColor(hexString: color){
                navCon.backgroundColor = navBarColor
                searchBar.barTintColor = navBarColor
                navCon.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
                
                navCon.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarColor, returnFlat: true)]
            }
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {

            guard let navCon = navigationController?.navigationBar else { fatalError("navigation controller is nil") }
            navCon.backgroundColor = UIColor(hexString: "5AC8FA")

    }
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTF) in
            alertTF.placeholder = "Add New Item"
            textField = alertTF
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            
            if let currentCat = self.selectedCat {
                do{
                    try self.realm.write({
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
//                        newItem.backColor = UIColor.randomFlat().hexValue()
                        currentCat.items.append(newItem)    
                    })
                }catch{
                    print("Error in saving items \(error)")
                }
                self.tableView.reloadData()
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemsArr?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell", for: indexPath)
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = itemsArr?[indexPath.row]{
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
           
            if let color = UIColor(hexString: selectedCat!.backColor)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(itemsArr!.count)){
                
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
                
            }
        }else{
            cell.textLabel?.text = "No items added yet!"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let item = itemsArr?[indexPath.row]{
            do {
                try realm.write({
//                    realm.delete(item)
                   item.done = !item.done
                })
            } catch {
                print("Error saving done status , \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: - Data Manipulating Methouds
    
    func loadItems() {
        
        itemsArr = selectedCat?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let item = itemsArr?[indexPath.row]{
            do {
                try realm.write({
                    realm.delete(item)
                })
            } catch  {
                print("Error deleting item \(error)")
            }
        }
    }

}

//MARK: - search Bar Delegate


extension ItemsTableViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        itemsArr = itemsArr?.filter("title CONTAINS[cd] %@", searchBar.text).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
     */
}
