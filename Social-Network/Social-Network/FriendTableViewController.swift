//
//  FriendTableViewController.swift
//  Social-Network
//
//  Created by Евгений Шварцкопф on 27.11.2019.
//  Copyright © 2019 Евгений Шварцкопф. All rights reserved.
//

import UIKit

class FriendTableViewController: UITableViewController {
    
    
    var friendList = [Friends(firstName: "Max", lastName: "Maximov", age: "25", country: "Omsk", education: "Middle education", status: "Готов поболтать"), Friends(firstName: "Egor", lastName: "Ivanov", age: "30", country: "Moscow", education: "Higher edication", status: "Пока жизнь легка и хороша..."), Friends(firstName: "Oleg", lastName: "Mironov", age: "21", country: "Omsk", education: "Middle special education", status: "Хочу начать учиться программированию,\n подскажите хорошие курсы...?!"), Friends(firstName: "Marina", lastName: "Ovina", age: "23", country: "Saint Petersburg", education: " - ", status: "Уехала в другой город, буду только 25.12.2019"), Friends(firstName: "Dima", lastName: "Ystinov", age: "24", country: "Moscow", education: "Higher edication", status: "Отошел"),Friends(firstName: "Ludmila", lastName: "Petrova", age: "25", country: "Tomsk", education: "Middle education", status: "Жду того самого момента...!"), Friends(firstName: "Ivan", lastName: "Ivanov", age: "30", country: "Moscow", education: "Higher edication", status: "Номер сменил, не теряйте, если что звонить на \n 8 908 143 2241!"), Friends(firstName: "Olesi", lastName: "Mironova", age: "21", country: "Omsk", education: "Middle special education", status: "Сейчас в городе Москва, подскажите куда лучше всего сходить?"), Friends(firstName: "Ura", lastName: "Lovinov", age: "23", country: "Saint Petersburg", education: " - ", status: ""), Friends(firstName: "Mila", lastName: "Antilopina", age: "24", country: "Moscow", education: "Higher edication", status: "Ушла в себя, не беспокойте!"),Friends(firstName: "Artyr", lastName: "Maximovin", age: "25", country: "Omsk", education: "Middle education", status: "Хмммммм....."), Friends(firstName: "Irina", lastName: "Ivanova", age: "30", country: "Moscow", education: "Higher edication", status: "Только не давно переехала в новый город, \n кто нибудь может мне провести Экскурсию?))"), Friends(firstName: "Mira", lastName: "Moronova", age: "21", country: "Omsk", education: "Middle special education", status: "Все хорошо, кому интересно это вообще =)"), Friends(firstName: "Maria", lastName: "Ovinava", age: "23", country: "Saint Petersburg", education: " - ", status: "Блогер"), Friends(firstName: "Annet", lastName: "Antis", age: "24", country: "Moscow", education: "Higher edication", status: "Готова знакомится")]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        cell.firstName.text = friendList[indexPath.row].firstName
        cell.lastName.text = friendList[indexPath.row].lastName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userName = friendList[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ProfileFriendCollectionViewController") as! ProfileFriendCollectionViewController
        vc.user = userName
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
