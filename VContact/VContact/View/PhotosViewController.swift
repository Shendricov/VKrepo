//
//  PhotosViewController.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 10.05.2022.
//

import UIKit
import Alamofire
private let reuseIdentifier = "Cell"

class PhotosViewController: UICollectionViewController {
    
    var photosArrayFromAPI: Array<PhotosResponse> = [] {
        didSet {
            for photo in photosArrayFromAPI {
                print("""
\(photo)
""")
            }
        }
    }
    var photosArray: Array<UIImage> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = VKService().getURL(requestMethod: .photo)
        Alamofire.request(url).responseJSON(completionHandler: {data in
            guard let data = data.data else { return }
            let photos = try? JSONDecoder().decode(PhotosResponse.self, from: data)
            guard let result = photos else {
               print("Error: check class PhotosResponse")
                return
            }
            for photo in result.response.items {
                
                print("""
                      Фотографии
                      owner: \(photo.owner_id)
                      id_ photo: \(photo.id)
                      url_photo:\(photo.url)
                      """)
                
            }
//            self.photosArrayFromAPI = photos?.response.items  as! Array<PhotosResponse>
        })

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photosArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendPhotoCell", for: indexPath) as! PhotosViewCell
        cell.photoImage.image = photosArray[indexPath.row]
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    @IBAction func toTheFullScreenPhotos(_ sender: UIBarButtonItem){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewDestination = storyboard.instantiateViewController(withIdentifier: "FullScreenPhotoViewController") as! FullScreenPhotoViewController
        viewDestination.photosArrayFullScreen = photosArray
        self.navigationController?.pushViewController(viewDestination, animated: true)
    }
    
    
}
