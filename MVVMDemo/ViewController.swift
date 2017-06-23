//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Gorey on 2017/6/23.
//  Copyright © 2017年 GG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbTitle: UILabel!
    
    var person:Person? = nil
    
    var viewModel:GreetingViewModelProtocol! {
        didSet {
            // 负责VM更新V
            self.viewModel.greetingDidChange = { vm in
                self.lbTitle.text = vm.greeting
            }
        }
    }
    
    @IBAction func onClick(_ sender: Any) {
        // V更新VM
        self.viewModel.showGreeting()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        person = Person(firstName: "Gao", lastName: "L")
        self.viewModel = GreetingViewModel(person: person!)
    }

}

