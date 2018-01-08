//
//  DetailViewController.swift
//  Project
//
//  Created by Thomas BERRANGER on 07/12/2017.
//  Copyright © 2017 Thomas BERRANGER. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var currentMovie: Movie?
    var book = MovieBook()
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var synopsisTextView: UITextView!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteSlider: UISlider!
    @IBOutlet weak var watchedSwitch: UISwitch!
    @IBOutlet weak var watchedLabel: UILabel!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func noteSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        noteLabel.text = "\(currentValue)"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movie = currentMovie else {
            print("Erreur ! pas de film")
            return
        }
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        
        title = movie.title
        
        titleTextField.text = movie.title
        noteSlider.value = Float(movie.note)
        noteLabel.text = String(movie.note)
        
        watchedSwitch.isOn = movie.watched
        switchValue()
        
        let synopsisTest = movie.synopsis
        if (synopsisTest.isEmpty)
        {
            synopsisTextView.text = "Aucune opinion ..."
        }
        else
        {
            synopsisTextView.text = movie.synopsis
        }
    }
    
    
    @IBAction func watchedSwitch(_ sender: Any) {
        switchValue()
    }
    
    
    func switchValue() {
        if watchedSwitch.isOn {
            watchedLabel.text = "Déja vue :)"
        }
        else
        {
            watchedLabel.text = "Pas encore vue :("
            watchedSwitch.tintColor = UIColor.red
        }
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        guard let movie = currentMovie else {
            print("Erreur ! pas de film")
            return
        }
        
        guard let title = titleTextField.text else {return}
        guard let synopsis = synopsisTextView.text else {return}
        
        if watchedSwitch.isOn {
            movie.watched = true
        }
        else
        {
            movie.watched = false
        }
        
        movie.title = title
        movie.synopsis = synopsis
        movie.note = Int(noteSlider.value)
        movie.image = ""
        
        book.notifyChanges()
    }
    
    var imagePicker = UIImagePickerController()
    
    @IBAction func imageButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        print("IMAGE !!!")
        print(image)
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    

    
    
}
