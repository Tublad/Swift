//
//  GroupTableViewController.swift
//  Social-Network
//
//  Created by Евгений Шварцкопф on 27.11.2019.
//  Copyright © 2019 Евгений Шварцкопф. All rights reserved.
//

import UIKit

class GroupTableViewController: UITableViewController {
  
    
    var groupList: [Group] = [Group(name: "Сообщества Developed iOS", content: "Образовательный", participant: "2 312 105 участников"),
                     Group(name: "PlayStation Store Official Group", content: "ВидеоИгры", participant: "201 123 участиков"),
                     Group(name: "Паблик +100500", content: "Развлекательный", participant: "1 000 123 участников"),
                     Group(name: "Одежда из Европы", content: "Одежда", participant: "54 123 участников"),
                     Group(name: "SwiftBook iOS", content: "Образовательный", participant: "14 120 участников"),
                     Group(name: "Лайфхакер", content: "Познавательный", participant: "5 103 участника"),
                     Group(name: "Vine Video", content: "Юмор", participant: "5 231 214 участников"),
                     Group(name: "Grisha", content: "Кафе, Ресторан", participant: "6 012 участников"),
                     Group(name: "Английский каждый день", content: "Языки", participant: "99 124 участников"),
                     Group(name: "Rosberry - Mobile Apps", content: "Программное обеспечение", participant: "501 участников"),
                     Group(name: "Game park | Гейм парк", content: "Открытая группа", participant: "142 612 участников"),
                     Group(name: "Dota 2 HS", content: "Видеоигры", participant: "3 123 412 участников")]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        cell.groupName.text = groupList[indexPath.row].name
        cell.content.text = groupList[indexPath.row].content
        cell.participant.text = groupList[indexPath.row].participant
        
        return cell
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            guard let globalGroupController = segue.source as? GlobalGroupTableViewController else {
                return
            }
            if let indexPath = globalGroupController.tableView.indexPathForSelectedRow {
                let group: Group = globalGroupController.globalGroupList[indexPath.row]
                if !groupList.contains(where: { (element) -> Bool in
                    if group.name == element.name {
                        return true
                    } else {
                        return false
                    }}){
                    groupList.append(group)
                    tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
