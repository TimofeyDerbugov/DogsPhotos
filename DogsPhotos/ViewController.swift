//
//  ViewController.swift
//  DogsPhotos
//
//  Created by Apple on 31.05.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let updateButton = UIButton()
    let photoView = UIImageView()
    
    var myLink: String = "https://images.dog.ceo/breeds/poodle-medium/PXL_20210220_100624962.jpg"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        
        updateButton.frame = CGRect(x: (view.frame.size.width / 10 * 2), y: (view.frame.size.height / 20 * 17), width: (view.frame.size.width / 10 * 6), height: (view.frame.size.height / 10))
        updateButton.backgroundColor = .blue
        updateButton.setTitle("Update photo", for: .normal)
        updateButton.layer.cornerRadius = 20
        updateButton.addTarget(self, action: #selector(updatePhoto), for: .touchUpInside)
        
        photoView.frame = CGRect(x: (view.frame.size.width / 10), y: (view.frame.size.height / 10), width: (view.frame.size.width / 10 * 8), height: (view.frame.size.height / 10 * 6))
        
        
        view.addSubview(updateButton)
        view.addSubview(photoView)
    }
    
    @objc func updatePhoto() {
        let urlString = "https://dog.ceo/api/breeds/image/random"//URL с интернета
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in //urlsession
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            do { //проверка на наличие ошибки
                let photo = try JSONDecoder().decode(Photo.self, from: data)
                print(photo.message)// проверка
                self.myLink = photo.message
            } catch {
                print(error)
            }
            
        }.resume()
        updtPhoto()//вывод фото
        
    }
    func updtPhoto() { //функция обновления фото
        let myUrl = URL(string: myLink)
        let myData = try? Data(contentsOf: myUrl!)
        photoView.image = UIImage(data: myData!)
        
    }
}

