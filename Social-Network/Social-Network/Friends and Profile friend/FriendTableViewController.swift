//
//  FriendTableViewController.swift
//  Social-Network
//
//  Created by Евгений Шварцкопф on 27.11.2019.
//  Copyright © 2019 Евгений Шварцкопф. All rights reserved.
//

import UIKit

class FriendTableViewController: UITableViewController {
    
    
    var friendList = [Friends(firstName: "Макс", lastName: "Максимов", age: "25", country: "Омск", education: "Среднее", status: "Готов поболтать"), Friends(firstName: "Егор", lastName: "Иванов", age: "30", country: "Москва", education: "Высшее", status: "Пока жизнь легка и хороша..."), Friends(firstName: "Олег", lastName: "Миронов", age: "21", country: "Омск", education: "Среднее \n специальное", status: "Хочу начать учиться программированию,\n подскажите хорошие курсы...?!"), Friends(firstName: "Марина", lastName: "Овина", age: "23", country: "Санкт-Петербург", education: " ", status: "Уехала в другой город, буду только 25.12.2019"), Friends(firstName: "Дима", lastName: "Устинов", age: "24", country: "Москва", education: "Высшее", status: "Отошел"),Friends(firstName: "Людмила", lastName: "Петрова", age: "25", country: "Томск", education: "Среднее", status: "Жду того самого момента...!"), Friends(firstName: "Иван", lastName: "Иванов", age: "30", country: "Москва", education: "Высшее", status: "Номер сменил, не теряйте, если что звонить на \n 8 908 143 2241!"), Friends(firstName: "Олеся", lastName: "Миронова", age: "21", country: "Омск", education: "Среднее \n специальное", status: "Сейчас в городе Москва,\n подскажите куда лучше всего сходить?"), Friends(firstName: "Юра", lastName: "Ливанов", age: "23", country: "Санкт-Петербург", education: " ", status: ""), Friends(firstName: "Мила", lastName: "Антилопина", age: "24", country: "Москва", education: "Высшее", status: "Ушла в себя, не беспокойте!"),Friends(firstName: "Артур", lastName: "Максимов", age: "25", country: "Омск", education: "Среднее", status: "Хмммммм....."), Friends(firstName: "Ирина", lastName: "Иванова", age: "30", country: "Москва", education: "Высшее", status: "Только не давно переехала в новый город, \n кто нибудь может мне провести Экскурсию?))"), Friends(firstName: "Мира", lastName: "Морозова", age: "21", country: "Омск", education: "Среднее \n специальное", status: "Все хорошо, кому интересно это вообще =)"), Friends(firstName: "Мария", lastName: "Овинова", age: "23", country: "Санкт-Петербург", education: " ", status: "Блогер"), Friends(firstName: "Анна", lastName: "Антис", age: "24", country: "Москва", education: "Высшее", status: "Готова знакомится")]

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
