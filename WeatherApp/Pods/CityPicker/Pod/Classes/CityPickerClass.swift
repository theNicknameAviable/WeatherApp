//
//  CityPickerClass.swift
//  Noemi Official
//
//  Created by LIVECT LAB on 13/03/2016.
//  Copyright © 2016 LIVECT LAB. All rights reserved.
//

import UIKit


class cityPickerClass {
    
    
    
    class func getNations() -> (nations:[String], allValues:NSDictionary){
        
        
        var nations = [String]()
        var allValues = NSDictionary()
        let podBundle = NSBundle(forClass: self)
        
        if let path = podBundle.pathForResource("countriesToCities", ofType: "json") {
            
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                do {
                    let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    
                    let nationsArray = jsonResult.allKeys as! [String]
                    let sortedNations = nationsArray.sort {  $0 < $1 }
                    
                    nations = sortedNations
                    
                    allValues = jsonResult
                    
                } catch {}
            } catch {}
        }
        
        
        return (nations, allValues)
    }
    
    
    
    
    
}
