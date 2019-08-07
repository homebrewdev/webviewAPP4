//
//  MenuVC.swift
//  webviewAPP
//
//  Created by Egor Devyatov on 07.08.2019.
//  Copyright © 2019 Egor Devyatov. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    @IBOutlet weak var slideView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateMenu()
    }
    
    @IBAction func hideSlideMenuButton(_ sender: UIButton) {
        hideMenu()
    }
    
    // скрыть меню
    func hideMenu() {
        //slideView.removeFromSuperview()
        UIView.animate(withDuration: 1.0, animations: {
            self.view.frame = CGRect(x: -UIScreen.main.bounds.width, y: 44, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-44)
        }) { (finished) in
            //self.slideView.removeFromSuperview()
            self.view.removeFromSuperview()
            AppDelegate.isMenuVC = true
        }
    }

    // наполняем меню кнопками (элементами)
    func populateMenu() {
        let manualConstraint = ((Int(slideView.bounds.width) - 200) / 2)
        let slideMenuBtn1 = UIButton()
        slideMenuBtn1.setTitle("First option", for: .normal)
        slideMenuBtn1.setTitleColor(UIColor.black, for: .normal)
        slideMenuBtn1.backgroundColor = UIColor.orange
        slideMenuBtn1.layer.cornerRadius = 5
        slideMenuBtn1.clipsToBounds = true
        slideMenuBtn1.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        slideMenuBtn1.tag = 1
        slideMenuBtn1.frame = CGRect(x: manualConstraint, y: 64, width: 200, height: 32)
        
        slideView.addSubview(slideMenuBtn1)
        
        let slideMenuBtn2 = UIButton()
        slideMenuBtn2.setTitle("Second option", for: .normal)
        slideMenuBtn2.setTitleColor(UIColor.black, for: .normal)
        slideMenuBtn2.backgroundColor = UIColor.orange
        slideMenuBtn2.layer.cornerRadius = 5
        slideMenuBtn2.clipsToBounds = true
        slideMenuBtn2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        slideMenuBtn2.tag = 2
        slideMenuBtn2.frame = CGRect(x: manualConstraint, y: 112, width: 200, height: 32)
        
        slideView.addSubview(slideMenuBtn2)
    }
    
    // обработка нажатий на кнопки по тэгу tag
    @objc func buttonAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        
        if btnsendtag.tag == 1 {
            print("button 1")
        }
        
        if btnsendtag.tag == 2 {
            print("button 2")
        }
    }
    
    
    // MARK: - Изучение жизненного цикла
    override func viewDidDisappear(_ animated: Bool) {
        print("View did disappear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("View did appear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("Autolayout - viewWillLayoutSubviews")
    }
    
    //  Autolayout происходит тут - между двумя этими методами
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         print("Autolayout - viewDidLayoutSubviews")
    }
}
