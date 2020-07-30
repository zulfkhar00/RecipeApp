//
//  MoreViewController.swift
//  Recipe
//
//  Created by Zulfkhar Maukey on 30/7/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI

class MoreViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet var buttons: [UIButton]!
    
    // MARK: Set email to send feedback
    let affairsDevEmail = "support@affairs.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for button in buttons {
            button.layer.cornerRadius = button.frame.size.height/4
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 0.0
            button.layer.masksToBounds = false
        }
    }

    @IBAction func feedbackButtonPressed(_ sender: UIButton) {
        let subject = "Feedback to Affairs app developers"
        alert(title: "Feedback form", subject: subject)
    }
    
    @IBAction func reportbugButtonPressed(_ sender: UIButton) {
        let subject = "Report a problem in Affairs app"
        alert(title: "Report form", subject: subject)
    }
    
    @IBAction func rateButtonPressed(_ sender: UIButton) {
        rateApp()
    }
    
    func rateApp() {
        SKStoreReviewController.requestReview()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func sendEmail(subject: String, message: String) {
           if MFMailComposeViewController.canSendMail() {
               let mail = MFMailComposeViewController()
               mail.mailComposeDelegate = self
               mail.setToRecipients([affairsDevEmail])
               mail.setMessageBody("<p>\(message)</p>", isHTML: true)
               mail.setSubject(subject)
    
               present(mail, animated: true)
           } else {
               print("error")
           }
    }
    
    func alert(title: String, subject: String) {
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        ac.addTextField { (descriptionTextField) in
            descriptionTextField.placeholder = "Leave a comment"
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (action) in
            guard let description = ac.textFields?[0].text else {return}
            self.sendEmail(subject: subject, message: description)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(submitAction)
        ac.addAction(cancelAction)
        
        present(ac, animated: true)
    }
}
