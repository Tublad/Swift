//
//  GlobalGroupTableViewController.swift
//  Social-Network
//
//  Created by Евгений Шварцкопф on 27.11.2019.
//  Copyright © 2019 Евгений Шварцкопф. All rights reserved.
//

import UIKit

class GlobalGroupTableViewController: UITableViewController {
    
    
    var globalGroupList: [Group] = [Group(name: "M.Game", content: "Открытая группа", participant: "65 865 участников"),
                        Group(name: "myPlayStation", content: "Видеоигры", participant: "87 782 подписчика"),
                        Group(name: "ADCI Solutions", content: "Веб-студия", participant: "1 388 подписчиков"),
                        Group(name: "ЧерньИла | Тату-Мастерская", content: "Открытая группа", participant: "3 486 участников"),
                        Group(name: "Заброшенное", content: "Туризм, путешествия", participant: "3 070 914 подписчиков")]

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalGroupList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalGroupCell", for: indexPath) as! GlobalGroupCell
        cell.globalGroupName.text = globalGroupList[indexPath.row].name
        cell.globalContent.text = globalGroupList[indexPath.row].content
        cell.participantGlobal.text = globalGroupList[indexPath.row].participant
        
        return cell
    }
    
}
