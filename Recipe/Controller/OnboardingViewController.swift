//
//  OnboardingViewController.swift
//  Recipe
//
//  Created by Zulfkhar Maukey on 30/7/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import UIKit
import paper_onboarding

class OnboardingViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {

    @IBOutlet weak var onboardingView: OnboardingView!
    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        onboardingView.dataSource = self
        onboardingView.delegate = self
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let backgroundColorOne = UIColor(red: 217/255, green: 72/255, blue: 89/255, alpha: 1)
        let backgroundColorTwo = UIColor(red: 106/255, green: 166/255, blue: 211/255, alpha: 1)
        let backgroundColorThree = UIColor(red: 168/255, green: 200/255, blue: 78/255, alpha: 1)
        
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let descriptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        
        return [OnboardingItemInfo(informationImage: UIImage(named: "onboarding1")!,
                                              title: "Search among 500.000+ recipes",
                                        description: "Our database is so huge that you can find any recipes.",
                                           pageIcon: UIImage(named: "mushroom")!,
                                              color: backgroundColorOne,
                                         titleColor: .white,
                                   descriptionColor: .white,
                                          titleFont: titleFont,
                                    descriptionFont: descriptionFont),
                
                OnboardingItemInfo(informationImage: UIImage(named: "onboarding2")!,
                                              title: "Find a recipe that fits your needs",
                                        description: "Every search result returns 10 different recipes, so you can find a wide range of methods.",
                                           pageIcon: UIImage(named: "mushroom")!,
                                              color: backgroundColorTwo,
                                         titleColor: .white,
                                   descriptionColor: .white,
                                          titleFont: titleFont,
                                    descriptionFont: descriptionFont),
                OnboardingItemInfo(informationImage: UIImage(named: "onboarding3")!,
                                              title: "Add ingredients to your shopping cart",
                                        description: "Once you find a recipe, you can add ingredients to your notes to be aware of the recipe.",
                                           pageIcon: UIImage(named: "mushroom")!,
                                              color: backgroundColorThree,
                                         titleColor: .white,
                                   descriptionColor: .white,
                                          titleFont: titleFont,
                                    descriptionFont: descriptionFont)
            ][index]
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index _: Int) {
        
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 1 {
            if getStartedButton.alpha == 1 {
                UIView.animate(withDuration: 0.2) {
                    self.getStartedButton.alpha = 0
                }
            }
        }
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2 {
            UIView.animate(withDuration: 0.4) {
                self.getStartedButton.alpha = 1
            }
        }
    }

    @IBAction func gotStarted(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "onboardingComplete")
        userDefaults.synchronize()
    }
    
}
