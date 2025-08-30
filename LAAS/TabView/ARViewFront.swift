//
//  ARViewFront.swift
//  LAAS
//
//  Created by Sophie Lin on 11/5/22.
//

import SwiftUI


struct ARviewControllerFront: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> ARVC {
        
        //let image = UIImage(named:"anterior-ng-nb")!
        //let image = UIImage(named:"fronta")!
        let image = UIImage(named:"fronta1")!
        let front = ARVC(lungImage: image, designID: "12")
        return front
    }
    
    func updateUIViewController(_ uiViewController: ARVC, context: Context) {
        
    }
   
   //TIPs: use this to generate the wrapper for the view controller that creates the View itself for the UIKit legacy UI
   //typealias UIViewControllerType = ARAC
    //click fix button to add the template
}

struct ARviewControllerBack: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> ARVC {
        
        //let image =  UIImage(named:"posterior-ng-nb")!
        //let image =  UIImage(named:"frontb")!
        let image =  UIImage(named:"frontb2")!
        let front = ARVC(lungImage: image, designID: "13")
        return front
    }
    
    func updateUIViewController(_ uiViewController: ARVC, context: Context) {
        
    }
   
   //TIPs: use this to generate the wrapper for the view controller that creates the View itself for the UIKit legacy UI
   //typealias UIViewControllerType = ARAC
    //click fix button to add the template
}
