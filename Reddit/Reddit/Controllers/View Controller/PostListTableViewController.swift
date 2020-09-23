//
//  PostListTableViewController.swift
//  Reddit
//
//  Created by Kaleb  Carrizoza on 9/23/20.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    //MARK: - Properties
    //need to put for a holder for posts
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
       
    }
//MARK: - Helpers
    //dont put this in a viewDidLoad
    func fetchPosts() {
        //this returns the fetch post
        PostController.fetchPost { (result) in
            DispatchQueue.main.async {
                //switch for cases
                switch result {
                //if it was successful it should give us everything that is in the array of [Post]
                case .success(let posts):
                    self.posts = posts
                    //need to reloadData
                    // needs to put reload data in a dispathQueue all the UI Changes need to me in the dispatchQueue.main.async() cause its the fastest thread
                        self.tableView.reloadData()
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                    
                    print(error.localizedDescription)
                }
            }
          
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return posts.count
    }

    //MARK: - Cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //for custom cells need to add guard and as?
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }

        let post = posts[indexPath.row]
        cell.post = post
        //after this build alert controller called ErrorActionSheetExtenstion in helper \
        cell.delegate = self

        return cell
    }
}//end of class

//MARK: - Extensions
extension PostListTableViewController: PresentErrorToUserDelegate {
    func presentError(error: LocalizedError) {
        self.presentErrorToUser(localizedError: error)
    }
    
}
