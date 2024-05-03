//
//  UIimage+Utils.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 8/03/24.
//

import Foundation
import UIKit
extension UIImageView {
    func setUIImageFromData(data : Data){
        self.image = UIImage(data: data)
    }
    
    func addImageDefault(){
        self.image = UIImage(named: "default")
    }
}
