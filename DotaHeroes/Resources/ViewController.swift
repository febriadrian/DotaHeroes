//
//  ViewController.swift
//  DotaHeroes
//
//  Created by Febri Adrian on 01/04/21.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

public func TRACE(_ any: Any?) {
    #if DEBUG
    let trace = """
    ---------------------  Tracing Begin  ---------------------
    \(any != nil ? any! : "nil")
    ---------------------   Tracing End   ---------------------
    """
    print(trace)
    #endif
}
