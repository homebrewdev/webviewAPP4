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
    // Gesture Recognizers
    @IBOutlet var swipeLeftGS: UISwipeGestureRecognizer!
    @IBOutlet var swipeRightGS: UISwipeGestureRecognizer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateMenu()
        //enableSlideMenuSwipe()
    }
    
    // скрыть меню
    func hideMenu() {
        
        UIView.animate(withDuration: 0.75, animations: {
            self.view.frame = CGRect(x: -UIScreen.main.bounds.width, y: 44,
                                     width: UIScreen.main.bounds.width,
                                     height: UIScreen.main.bounds.height-44)
        }) { (finished) in
            //self.slideView.removeFromSuperview()
            self.view.removeFromSuperview()
            AppDelegate.isMenuVC = true
        }
    }
    
    // показать меню
    func showMenu() {
        // анимашка всплывания вправо с 1 секундой
        UIView.animate(withDuration: 0.75) {
            self.slideView.frame = CGRect(x: 0, y: 44,
                                            width: self.view.bounds.width,
                                            height: self.view.bounds.height - 44)
            self.view.addSubview(self.slideView)
            //self.addChild(self.menuVC)
            //self.view.addSubview(self.menuVC.view)
            // заполняем кнопками менюшку
            self.populateMenu()
            AppDelegate.isMenuVC = false // слайд меню активно выкатилось
        }
    }

    // наполняем меню кнопками (элементами)
    func populateMenu() {
        let manualConstraintLeftRight = ((Int(slideView.bounds.width) - 200) / 2)
        let manualWidthCustomButton = ((Int(slideView.bounds.width) - 64))
        let slideMenuBtn1 = UIButton()
        slideMenuBtn1.setTitle("First option", for: .normal)
        slideMenuBtn1.setTitleColor(UIColor.black, for: .normal)
        slideMenuBtn1.backgroundColor = UIColor.orange
        slideMenuBtn1.layer.cornerRadius = 5
        slideMenuBtn1.clipsToBounds = true
        slideMenuBtn1.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        slideMenuBtn1.tag = 1
        slideMenuBtn1.frame = CGRect(x: manualConstraintLeftRight,
                                     y: 64,
                                     width: manualWidthCustomButton,
                                     height: 32)
        
        slideView.addSubview(slideMenuBtn1)
        
        let slideMenuBtn2 = UIButton()
        slideMenuBtn2.setTitle("Second option", for: .normal)
        slideMenuBtn2.setTitleColor(UIColor.black, for: .normal)
        slideMenuBtn2.backgroundColor = UIColor.orange
        slideMenuBtn2.layer.cornerRadius = 5
        slideMenuBtn2.clipsToBounds = true
        slideMenuBtn2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        slideMenuBtn2.tag = 2
        slideMenuBtn2.frame = CGRect(x: manualConstraintLeftRight,
                                     y: 112,
                                     width: manualWidthCustomButton,
                                     height: 32)
        
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
    
//    func enableSlideMenuSwipe() {
//
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: Selector(("respondToSwipeGesture:")))
//        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
//        self.slideView.addGestureRecognizer(swipeRight)
//
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector(("respondToSwipeGesture:")))
//        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
//        self.slideView.addGestureRecognizer(swipeLeft)
//
//    }
//
//
//    func respondToSwipeGesture(gesture: UIGestureRecognizer)
//    {
//        if let swipeGesture = gesture as? UISwipeGestureRecognizer
//        {
//            switch swipeGesture.direction
//            {
//            case UISwipeGestureRecognizer.Direction.right:
//                //write your logic for right swipe
//                print("Swiped right")
//
//            case UISwipeGestureRecognizer.Direction.left:
//                //write your logic for left swipe
//                print("Swiped left")
//
//            default:
//                break
//            }
//        }
//    }
    // реализация по свайпам влево и вправо
    @IBAction func swipeLeftSlideMenu(_ sender: UISwipeGestureRecognizer) {
//        if AppDelegate.isMenuVC {
//            hideMenu()
//        }
        hideMenu()
        print("Swiped left")
    }
    
    @IBAction func swipeRightSlideMenu(_ sender: UISwipeGestureRecognizer) {
        print("Swiped right")
    }
    
}
