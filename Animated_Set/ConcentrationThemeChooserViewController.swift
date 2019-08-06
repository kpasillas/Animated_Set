//
//  ConcentrationThemeChooserViewController.swift
//  Animated_Set
//
//  Created by Work Kris on 7/14/19.
//  Copyright © 2019 Kris P. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    let themes = [
        0:"🐶🐱🐭🐰🦊🐻🐼🦁🐮🐷",
        1:"🚗🚕🚌🏎🚓🚑🚒🚚🚙🚎",
        2:"😃🤣😊😇🙃😍😝🤓😎🤩",
        3:"🍎🍊🍌🍉🍇🍓🍒🍍🥝🍐",
        4:"🦇😱🙀😈🎃👻🍭🍬🍎🧛‍♂️",
        5:"⚽️🏀🏈⚾️🎾🏐🏉🎱🏓🏸"
    ]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
//            print("splitViewDetailConcentrationViewController")
            if let themeTag = (sender as? UIButton)?.tag, let theme = themes[themeTag] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrationViewController {
//            print("lastSeguedToConcentrationViewController")
            if let themeTag = (sender as? UIButton)?.tag, let theme = themes[themeTag] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
//            print("performSegue")
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    // MARK: - Navigation
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeTag = (sender as? UIButton)?.tag, let theme = themes[themeTag] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
    }

}
