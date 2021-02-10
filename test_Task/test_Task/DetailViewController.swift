//
//  DetailViewController.swift
//  Test_Task
//
//  Created by Марк Шнейдерман on 10.02.2021.
//

import UIKit
import SDWebImage
class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var dataLabel: UILabel!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    var post : Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let str = post?.bigPhoto  else {return}
        guard let url = URL(string:str) else {return}
        
        myImageView.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions.highPriority) {[weak self](image, error, cache, url) in
            guard let strongSelf = self else {return}
            if error == nil {
                strongSelf.dataLabel.text = strongSelf.give_time()
            }else{
                strongSelf.alert(title: "Ошибка", message: "Отсутвует подключение к интернету", style:.alert)
                print("Error:\(error?.localizedDescription)")
            }
        }
    }
    
    
    func give_time()->String{
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        return formatter.string(from: currentDateTime)
    }
    
    func alert(title:String,message:String,style: UIAlertController.Style){
        let alertContoller = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "Ok", style: .default) { [weak self](action) in
            self?.navigationController?.popViewController(animated: true)
        }
        alertContoller.addAction(action)
        self.present(alertContoller, animated: true, completion: nil)
    }
}

