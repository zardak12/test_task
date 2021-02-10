//
//  ViewController.swift
//  Test_Task
//
//  Created by Марк Шнейдерман on 09.02.2021.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        parse_json()
        
    }


    func configure(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    // блок который распарсивает наш JSON
    func parse_json()
    {
        NetworkManager.sharedData.obtainPost{ [weak self]post in
                self?.dataSource = post
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
        }
    }

}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource{
      
    // возращает количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    // обрабатывает ячейку
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        let post = dataSource[indexPath.row]
        let url = URL(string: post.smallPhoto)
        item.configure(with: post.smallPhoto)
        return item
    }
      //MARK: -Переход на DetailViewController
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        performSegue(withIdentifier: "Identifier", sender: model)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Identifier",let postModel = sender as? Post{
            let destController = segue.destination as! DetailViewController
            destController.post = postModel
        }
    }
}

  //MARK: - Настройка размера
extension ViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.bounds.width
        let cellWidth = screenWidth/3

        return CGSize(width: cellWidth-2, height: cellWidth-2)
    }
}

