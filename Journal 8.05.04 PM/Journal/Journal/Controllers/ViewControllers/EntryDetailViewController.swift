//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Jaymond Richardson on 5/10/21.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        titleTextField.delegate = self
        updateViews()
        
    }
    //MARK: - Properties
    var entry: Entry? {
        
        didSet {
            updateViews()
            loadViewIfNeeded()
        }
    }
    
    //MARK: - Actions
    
    @IBAction func mainViewTapped(_ sender: UITapGestureRecognizer) {
        bodyTextView.resignFirstResponder()
        titleTextField.resignFirstResponder()
    }
    @IBAction func clearTextButtonTapped(_ sender: Any) {
        bodyTextView.text = ""
        titleTextField.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty else {return}
        EntryController.shared.createEntryWith(title: title, body: body) { (result) in
            self.navigationController?.popViewController(animated: true)
            
        }
        
    }
    
    //MARK: - Functions
    func updateViews() {
        guard let entry = entry else {return}
        titleTextField?.text = entry.title
        bodyTextView?.text = entry.body
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}
extension EntryDetailViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        bodyTextView.resignFirstResponder()
        return true
        
    }
    
}
