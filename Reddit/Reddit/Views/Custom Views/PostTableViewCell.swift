//
//  PostTableViewCell.swift
//  Reddit
//
//  Created by Kaleb  Carrizoza on 9/23/20.
//

import UIKit
//define protocol
//MARK: -Protocol
protocol PresentErrorToUserDelegate: AnyObject {
    func presentError(error: LocalizedError)
}

class PostTableViewCell: UITableViewCell {

   //MARK: - Outlets
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upvoteLabel: UILabel!
    
    //MARK: - Properties
    var post: Post? {
        // didSet runs when the post gets called
        didSet {
            updateViews()
        }
    }
    //after making protocol need this 
    weak var delegate: PresentErrorToUserDelegate?
    
    //MARK: - Helper functions and methods
    // place in didSet in the properties
    //this updates the outlets from the post model
    func updateViews() {
        guard let post =  post else {return}
        titleLabel.text = post.title
        upvoteLabel.text = "Upvotes⬆️: \(post.ups)"
        //need to get the image from the fetch function
        //call the image and the nil is for a reset when its out of the view
        thumbnailImageView.image = nil
        //need to call the thumbnail function
        PostController.fetchThumbnailFor(post: post) { (result) in
            //need to Dispatch when the switch is done
            DispatchQueue.main.async {
                switch result {
                //shows the image and needs to call its self
                case .success(let image):
                    self.thumbnailImageView.image = image
                    //calls the error
                case .failure(let error):
                    //present error to user... need to make present error in the PostError this before delegate (1)
                    //this assign someone to change the UI  doesnt need to be on the main
                    self.delegate?.presentError(error: error)
                    print(error.errorDescription) //(1)
                }
            }
       
        }
    }//end of update function
    

}//end of class...
