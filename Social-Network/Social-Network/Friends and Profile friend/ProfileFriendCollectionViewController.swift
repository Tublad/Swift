//
//  ProfileFriendCollectionViewController.swift
//  Social-Network
//
//  Created by Евгений Шварцкопф on 28.11.2019.
//  Copyright © 2019 Евгений Шварцкопф. All rights reserved.
//

import UIKit


class ProfileFriendCollectionViewController: UICollectionViewController {
    
    var user: Friends?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileFriendCell", for: indexPath) as! ProfileFriendCell
        cell.firstNameFriend.text = (user?.firstName)
        cell.lastNameFriend.text = user?.lastName
        cell.ageFriend.text = "Возраст: \(user?.age ?? " ") лет"
        cell.countryFriend.text = "Город: \(user?.country ?? " ")"
        cell.educationFriend.text = "Образование: \(user?.education ?? "")"
        cell.status.text = "Статус: \(user?.status ?? "")"
        return cell
    }
    
    

}
