//
//  UserCell.swift
//  heyApp
//
//  Created by Admin on 26/05/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Firebase


class UserCell: UITableViewCell {
    
    var message: Message? {
        didSet {
            setupNameAndProfileImage()
            
            detailTextLabel?.text = message?.text
            
            if let seconds = message?.timestamp?.doubleValue {
                let timestampDate = Date(timeIntervalSince1970: seconds)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm:ss a"
                timeLabel.text = dateFormatter.string(from: timestampDate)
            }
            
            
        }
    }
    
    private func setupNameAndProfileImage() {
        
        if let id = message?.chatPartnerId() {
            let ref = Database.database().reference().child("users").child(id)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.textLabel?.text = dictionary["name"] as? String
                    
                    if let profileImageUrl = dictionary["profileImageUrl"] as? String {
                        self.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
                    }
                }
                
            }, withCancel: nil)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        //        label.text = "HH:MM:SS"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        addSubview(timeLabel)
        
        
        //need x,y,width,height anchors
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        //need x,y,width,height anchors
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



/*
 class UserCell:UITableViewCell {
 var message : Message? {
 // that's performed everytime we send messags
 didSet{
 if let toId = message?.toId{
 let ref = Database.database().reference().child("users").child(toId)
 ref.observeSingleEvent(of: .value, with: { (snapShot) in
 if let dictionary = snapShot.value as? [String:AnyObject] {
 self.textLabel?.text = dictionary["name"]as? String
 if let profileImage = dictionary["profileImage"] as?String {
 self.profileImageView.loadImageWithUrlStringUsingCache(urlString: profileImage)
 }
 }
 
 
 
 
 })
 }
 //        cell.textLabel?.text = message.toId
 detailTextLabel?.text = message?.text
 if let seconds = message?.timeStamp?.doubleValue {
 let timeStampDate = NSDate(timeIntervalSince1970: seconds)
 let dateFortmatter = DateFormatter()
 dateFortmatter.dateFormat = "hh:mm:ss a"
 
 
 timeLabel.text = dateFortmatter.string(from: timeStampDate as Date)
 }
 
 }
 }
 
 
 override func layoutSubviews() {
 super.layoutSubviews()
 textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y, width: textLabel!.frame.width, height: textLabel!.frame.height)
 detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
 }
 
 
 let profileImageView :UIImageView = {
 let imageView = UIImageView()
 
 imageView.translatesAutoresizingMaskIntoConstraints = false
 imageView.layer.cornerRadius = 24
 imageView.layer.masksToBounds = true
 return imageView
 }()
 
 let timeLabel :UILabel = {
 let label = UILabel()
 label.translatesAutoresizingMaskIntoConstraints = false
 label.font = UIFont.boldSystemFont(ofSize: 12)
 label.textColor = .lightGray
 label.text = "HH:MM:SS"
 return label
 }()
 
 
 
 override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
 super.init(style:.subtitle , reuseIdentifier: reuseIdentifier)
 
 addSubview(profileImageView)
 addSubview(timeLabel)
 // need x,y,width,height constraints
 profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor,constant:8).isActive = true
 profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
 profileImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 48).isActive = true
 profileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
 
 // need x,y,width,height constraints
 timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
 timeLabel.topAnchor.constraint(equalTo:self.topAnchor,constant:18).isActive = true
 timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
 timeLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
 
 }
 
 required init?(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 }
 
 
 */

