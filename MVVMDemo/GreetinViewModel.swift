//
//  GreetinViewModel.swift
//  MVVMDemo
//
//  Created by Gorey on 2017/6/23.
//  Copyright © 2017年 GG. All rights reserved.
//

import Foundation

protocol GreetingViewModelProtocol {
    var greeting: String? {get}
    var greetingDidChange:((GreetingViewModelProtocol)->())? { get set }
    init(person: Person)
    func showGreeting()
}

class GreetingViewModel : GreetingViewModelProtocol {


    let person: Person
    
    required init(person: Person) {
        self.person = person
    }

    var greeting: String? {
        didSet {
            // VM的值被更新后, 再去更新V
            self.greetingDidChange!(self)
        }
    }

    var greetingDidChange: ((GreetingViewModelProtocol) -> ())?
    
    func showGreeting() {
        self.greeting = "Hello  \(person.firstName) \(person.lastName)"
    }

}
