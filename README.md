# MVVMDemo

这是MVVM基础用法, 
相比MVP, 最大的不同点在于, MVVM要负责对V的更新


#### Model
```swift
// Person.swift
struct Person {
    let firstName: String
    let lastName: String
}
```

#### ViewModel
```swift
// GreetinViewModel.swift

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
```

#### View
```swift
// ViewController.swift


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
```

