//
//  FullScreenCollectionViewController.swift
//  infGalleryIOS
//
//  Created by Kamil Buczel on 29.03.2017.
//  Copyright © 2017 Kamajabu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CollectionViewCell"

extension PlayerViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CollectionViewCellDelegate {


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let inputFile = Bundle.main.path(forResource: "items", ofType: "plist")
        let inputDataArray = NSArray(contentsOfFile: inputFile!)
        return (inputDataArray?.count)!

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FullScreenCollectionViewCell

        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: cell.frame.width, height: cell.frame.height)))

        let item = galleryItems[indexPath.row]
        let image = UIImage(named: item.itemImage)

        imageView.image = image
        imageView.addBlurEffect()
        cell.backgroundView = UIView()
        cell.backgroundView!.addSubview(imageView)

        cell.setGalleryItem(galleryItems[indexPath.row])
        cell.closeDelegate = self

        return cell
    }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height )
    }

    func cellDelegateCloseController(sender: AnyObject){
        dismiss(animated: true, completion: nil)
    }

    @IBAction func finishButtonDidTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }

}