//
//  FriendsTableViewController.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 09.05.2022.
//

import UIKit



class FriendsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let cellTypeNib = UINib(nibName: "PhotoNameCell", bundle: nil)
         tableView.register(cellTypeNib, forCellReuseIdentifier: "PhotoNameType")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.setNeedsDisplay()
    }

    // MARK: - Table view data source

    var users: Array<User> = [User(name: "Mikky"), User(name: "Chapoklyak"), User(name: "Popay"), User(name: "Cheburashka"), User(name: "Maikle")] { didSet {
        users.sort(by: {one, two in one.name < two.name})
        
        }
    }
    
    
    private func getArrForTableView(usersArr: [User]) -> [[User]] {
        users.sort(by: {one, two in one.name < two.name})
        var result:[[User]] = []
        var sectionsOfLetters: [Character] = []
        usersArr.forEach({ user in
            let letter = user.name.first!
            if !sectionsOfLetters.contains(letter) {
                sectionsOfLetters.append(letter)
            }
        })
        sectionsOfLetters.forEach({ letter in
            var tempuraryArr:[User] = []
            for user in users {
                if user.name.first == letter {
                    tempuraryArr.append(user)
                }
            }
            result.append(tempuraryArr)
        })
        return result
    }
    
    var usersPhotoStorage: Dictionary<String,[UIImage]> = ["Popay":[UIImage(imageLiteralResourceName: "Popay1"), UIImage(imageLiteralResourceName: "Popay2"),UIImage(imageLiteralResourceName: "Popay3"),UIImage(imageLiteralResourceName: "Popay4"),UIImage(imageLiteralResourceName: "Popay5"),UIImage(imageLiteralResourceName: "Popay6"),UIImage(imageLiteralResourceName: "Popay7")], "Mikky": [UIImage(imageLiteralResourceName: "Mikky1"),UIImage(imageLiteralResourceName: "Mikky2"),UIImage(imageLiteralResourceName: "Mikky3"),UIImage(imageLiteralResourceName: "Mikky4"),UIImage(imageLiteralResourceName: "Mikky5"),UIImage(imageLiteralResourceName: "Mikky6"),UIImage(imageLiteralResourceName: "Mikky7")], "Maikle": [UIImage(imageLiteralResourceName: "Mike1"),UIImage(imageLiteralResourceName: "Mike2"),UIImage(imageLiteralResourceName: "Mike3"),UIImage(imageLiteralResourceName: "Mike4"),UIImage(imageLiteralResourceName: "Mike5")]]
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return getArrForTableView(usersArr: users).count
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getArrForTableView(usersArr: users)[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoNameType", for: indexPath) as! PhotoNameCell
        cell.avatar.image = UIImage(imageLiteralResourceName: getArrForTableView(usersArr: users)[indexPath.section][indexPath.row].name)
        cell.name.text = getArrForTableView(usersArr: users)[indexPath.section][indexPath.row].name
        cell.selectionStyle = .blue
        cell.accessoryType = .disclosureIndicator
        print("Координаты ячейчи следующие: \(indexPath)")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewDestination = storyboard.instantiateViewController(withIdentifier: "PhotoFriendsScene") as! PhotosViewController
        viewDestination.title = getArrForTableView(usersArr: users)[indexPath.section][indexPath.row].name
        if let userPhotos = usersPhotoStorage[getArrForTableView(usersArr: users)[indexPath.section][indexPath.row].name] {
            viewDestination.photosArray = userPhotos
        }
        navigationController?.pushViewController(viewDestination, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete", handler: {_,_,_ in
            let deleteName = self.getArrForTableView(usersArr: self.users)[indexPath.section][indexPath.row].name
            var index:Int = 0
            self.users.forEach({user in
                if user.name == deleteName {
                    self.users.remove(at: index)
                }
                index += 1
            })
            tableView.reloadData()
        })
        let actionConfiguration = UISwipeActionsConfiguration(actions: [action])
        return actionConfiguration
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        здесь можно сократить код, сли переделать массив в словарь.
        let getArr = getArrForTableView(usersArr: users)[section].first
        let firstName = getArr?.name
        let sectionLetter = firstName?.first
        return sectionLetter?.description
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    
    
}
