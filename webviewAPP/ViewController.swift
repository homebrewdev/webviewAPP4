//
//  ViewController.swift
//  webviewAPP
//
//  Created by Egor Devyatov on 07.08.2019.
//  Copyright © 2019 Egor Devyatov. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var dataSendLabel: UILabel!
    
    let slideView = UIView()
    
    var menuVC: MenuVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    @IBAction func goWebButtonTap(_ sender: UIButton) {
        //let destinationURL = "http://80.211.30.177/login/logint.php"
        //let destinationURL = "http://80.211.30.177/landing/pay-page.html"
        //let destinationURL = "https://yandex.ru"
        makeWebMagic(destinationURL: "http://80.211.30.177/landing/pay-page.html")
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
        UIView.animate(withDuration: 1.0) {
            self.menuVC.view.frame = CGRect(x: 0, y: 44, width: self.view.bounds.width, height: self.view.bounds.height - 44)
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
    
}

