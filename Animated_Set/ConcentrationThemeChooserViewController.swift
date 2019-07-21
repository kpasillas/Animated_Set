//
//  ConcentrationThemeChooserViewController.swift
//  Animated_Set
//
//  Created by Work Kris on 7/14/19.
//  Copyright © 2019 Kris P. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

    // TODO: Fix seque looking up by button title string (see lecture #7, 34:40)
    
    let themes = [
        "Halloween":"🦇😱🙀😈🎃👻🍭🍬🍎🧛‍♂️",
        "Cars":"🚗🚕🚌🏎🚓🚑🚒🚚🚙🚎",
        "Animals":"🐶🐱🐭🐰🦊🐻🐼🦁🐮🐷",
        "Faces":"😃🤣😊😇🙃😍😝🤓😎🤩",
        "Sports":"⚽️🏀🏈⚾️🎾🏐🏉🎱🏓🏸",
        "Fruits":"🍎🍊🍌🍉🍇🍓🍒🍍🥝🍐"
    ]
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
            }
        }
    }

}
