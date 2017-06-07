//
//  DreamElement.swift
//  Sweet Dreams
//
//  Created by Alberto Garcia Ramos on 07/06/2017.
//  Copyright © 2017 Alberto Garcia Ramos. All rights reserved.
//

import Foundation

open class DreamElement {

    var title:String
    var date:String
    var duration:String
    var dream:String
    
    init(newTitle:String) {
        title = newTitle
        date = "HOY"
        duration = "0:05:21"
        switch arc4random_uniform(3) {
            case 0: dream = "dream0.png"
            case 1: dream = "dream1.png"
            case 2: dream = "dream2.png"
            default: dream = "dream0.png"
        }
    }
}
