//
//  ViewController.swift
//  webviewAPP
//
//  Created by Egor Devyatov on 07.08.2019.
//  Copyright © 2019 Egor Devyatov. All rights reserved.
//

import UIKit
import WebKit
import os

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var dataSendLabel: UILabel!
    
    let slideView = UIView()
    
    var menuVC: MenuVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        os_log("View did Load.", log: OSLog.default, type: .info)
        menuVC = self.storyboard?.instantiateViewController(withIdentifier: "SlideMenuVC") as? MenuVC
    }

    private func makeWebMagic(destinationURL: String) {
        
        let url = URL(string: destinationURL)
       
        let request = URLRequest(url: url!)
       
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    // Correct
                    // выводим кол-во загруженных байт
                    self.dataSendLabel.text = "\(data.count) bytes"
                    // выводим загруженную страничку на вебвью
                    self.webView.load(request)
                }
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP statusCode: \(httpResponse.statusCode)")
                print("code kCFStreamErrorDomainHTTP = \(kCFStreamErrorDomainHTTP)")
            }
            
            // пока оставим но обработка ошибок должна быть - а пока вот такая хрень
            if let HTTPerror = error {
                print("Error: \(HTTPerror)")
            }
        
        }
        
        // запуск таска
        task.resume()
        os_log("Web task is initiated.", log: OSLog.default, type: .info)
    }
    
    @IBAction func goWebButtonTap(_ sender: UIButton) {
        //let destinationURL = "http://80.211.30.177/login/logint.php"
        //let destinationURL = "http://80.211.30.177/landing/pay-page.html"
        //let destinationURL = "https://yandex.ru"
        makeWebMagic(destinationURL: "https://yandex.ru")
    }
    
    @IBAction func slideMenuTap(_ sender: UIBarButtonItem) {
        // isMenuVC - переменная определяющая в каком соcтоянии наше слайд меню
        if AppDelegate.isMenuVC {
            showMenu()
        } else {
            hideMenu()
        }
    }
    
    // показать меню
    func showMenu() {
        // анимашка всплывания вправо с 1 секундой
        UIView.animate(withDuration: 0.75) {
            self.menuVC.view.frame = CGRect(x: 0, y: 44,
                                            width: self.view.bounds.width,
                                            height: self.view.bounds.height - 44)
            self.addChild(self.menuVC)
            self.view.addSubview(self.menuVC.view)
            // заполняем кнопками менюшку
            //self.menuVC.populateMenu()
            AppDelegate.isMenuVC = false
        }
    }
    
    // спрятать меню
    func hideMenu() {
        self.menuVC.removeFromParent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("View controller will appear!")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("View controller did appear!")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("View controller will disappear!")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("View controller did disapear")
    }
    
    // микро браузер - реализация нажатий на кнопки
    // back - назад
    @IBAction func backBarButtonTap(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    // микро браузер - реализация нажатий на кнопки
    // forward - вперед
    @IBAction func forwardBarButtonTap(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
}

