//
//  ChatMessagesCell.swift
//  heyApp
//
//  Created by Admin on 30/05/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import AVFoundation

class ChatMessageCell: UICollectionViewCell {
    
    var chatLogController:ChatLogController?
    var message:Message?
    
    let activityIndicatorView:UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        
        return aiv
    }()
    
    lazy var playVideoButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PlayVideo", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "play")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handlePlayVideo), for: .touchUpInside)
        return button
    }()
    var playerLayer:AVPlayerLayer?
    var player:AVPlayer?
    @objc func handlePlayVideo(){
        if let videourl = message?.videoUrl,let url = URL(string:videourl) {
            
            player = AVPlayer(url:url)
            playerLayer = AVPlayerLayer(player: player)
            
            playerLayer?.frame = bubbleView.bounds
            bubbleView.layer.addSublayer(playerLayer!)
            player?.play()
            print("attempt to play video")
        }
        
    }
    override func prepareForReuse() {
        // this method Performs any clean up necessary to prepare the view for use again.
        super.prepareForReuse()
        playerLayer?.removeFromSuperlayer()
        player?.pause()
    }
    
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE TEXT FOR NOW"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.clear
        tv.textColor = .white
        tv.isEditable = false
        
        return tv
    }()
    
    static let blueColor = UIColor(r: 0, g: 137, b: 249)
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = blueColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var  messageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomInImage)))
        return imageView
    }()
    
    @objc func handleZoomInImage(tapGesture:UITapGestureRecognizer){
        if let imageView = tapGesture.view as? UIImageView {
            // don't perform a lot of custom logic inside of a view class => shyaka
            self.chatLogController?.performZoomingForImageView(startingImageView:imageView)
            
        }
        
    }
    var bubbleWidthAnchor: NSLayoutConstraint?
    var bubbleViewRightAnchor: NSLayoutConstraint?
    var bubbleViewLeftAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bubbleView)
        addSubview(textView)
        addSubview(profileImageView)
        
        bubbleView.addSubview(messageImageView)
        messageImageView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor).isActive = true
        messageImageView.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
        messageImageView.widthAnchor.constraint(equalTo: bubbleView.widthAnchor).isActive = true
        messageImageView.heightAnchor.constraint(equalTo: bubbleView.heightAnchor).isActive = true
        
        bubbleView.addSubview(playVideoButton)
        //x,y,w,h
        playVideoButton.centerXAnchor.constraint(equalTo: bubbleView.centerXAnchor).isActive = true
        playVideoButton.centerYAnchor.constraint(equalTo: bubbleView.centerYAnchor).isActive = true
        playVideoButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playVideoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        
        //x,y,w,h
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        //x,y,w,h
        
        bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        
        bubbleViewRightAnchor?.isActive = true
        
        bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8)
        //        bubbleViewLeftAnchor?.active = false
        
        
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        
        //x,y,w,h
        //        textView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
        //        textView.widthAnchor.constraintEqualToConstant(200).active = true
        
        
        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




/*
 class ChatMessagesCell: UICollectionViewCell {
 let textView:UITextView = {
 let tv = UITextView()
 tv.text = "you're not alone"
 tv.translatesAutoresizingMaskIntoConstraints = false
 tv.font = UIFont.systemFont(ofSize: 16)
 tv.backgroundColor = UIColor.clear
 tv.textColor = .white
 return tv
 }()
 static let blueColor = UIColor(r: 0, g: 137, b: 249)
 let bubbleView : UIView = {
 let bbl = UIView()
 
 bbl.backgroundColor = blueColor
 bbl.translatesAutoresizingMaskIntoConstraints = false
 bbl.layer.cornerRadius = 16
 bbl.layer.masksToBounds = true
 return bbl
 }()
 let profileImageView :UIImageView = {
 let imageView = UIImageView()
 
 imageView.translatesAutoresizingMaskIntoConstraints = false
 imageView.layer.cornerRadius = 16
 imageView.layer.masksToBounds = true
 imageView.contentMode = .scaleAspectFill
 
 return imageView
 }()
 let messageImageView:UIImageView = {
 let imageView = UIImageView()
 
 imageView.translatesAutoresizingMaskIntoConstraints = false
 imageView.layer.cornerRadius = 16
 imageView.layer.masksToBounds = true
 imageView.contentMode = .scaleAspectFill
 imageView.backgroundColor = .red
 return imageView
 }()
 
 
 
 
 
 var bubbleWidthAnchor:NSLayoutConstraint?
 var bubbleRightAnchor:NSLayoutConstraint?
 var bubbleLeftAnchor:NSLayoutConstraint?
 
 override init(frame: CGRect) {
 super.init(frame: frame)
 addSubview(bubbleView)
 addSubview(textView)
 addSubview(profileImageView)
 bubbleView.addSubview(messageImageView)
 
 messageImageView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor).isActive = true
 messageImageView.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
 messageImageView.widthAnchor.constraint(equalTo: bubbleView.widthAnchor).isActive = true
 messageImageView.heightAnchor.constraint(equalTo: bubbleView.heightAnchor).isActive = true
 
 // need x,y,w,h
 profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
 profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
 profileImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
 profileImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
 
 bubbleRightAnchor =
 bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
 bubbleRightAnchor?.isActive = true
 bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
 
 bubbleLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8)
 
 bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
 bubbleWidthAnchor?.isActive = true
 
 bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
 
 //ios 9 constraints
 // need x,y,w,h
 //        textView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
 textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
 textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
 
 textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
 //textView.widthAnchor.constraintEqualToConstant(200).active = true
 
 
 textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
 }
 
 required init?(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 
 
 }
 */

