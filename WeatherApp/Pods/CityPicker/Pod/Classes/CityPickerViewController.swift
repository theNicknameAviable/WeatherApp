//
//  CityPickerViewController.swift
//  Noemi Official
//
//  Created by LIVECT LAB on 13/03/2016.
//  Copyright © 2016 LIVECT LAB. All rights reserved.
//

import UIKit

public protocol CityPickerViewControllerDelegate: class {
    func CityPickerDidSelectRow(nation: String, city: String)
    func CityPickerDidPressedCancelButton()
    func CityPickerDidPressedSelectButton(CityPicker: CityPickerViewController ,nation: String, city: String)
}




public class CityPickerViewResponder {
    let CityPicker: CityPickerViewController
    
    // Initialisation
    public init(CityPicker: CityPickerViewController) {
        self.CityPicker = CityPicker
    }

    public func close() {
        self.CityPicker.hideView()
    }
    
    public func setDismissBlock(dismissBlock: DismissBlock) {
        self.CityPicker.dismissBlock = dismissBlock
    }
}


public typealias DismissBlock = () -> Void


//MARK: The Main Class
public class CityPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // Members declaration
    var baseView = UIView()
    var blurView = UIVisualEffectView()
    var cityPicker = UIPickerView()
    var closeBtn = UIButton()
    var selectBtn = UIButton()
    var cityLabel =  UILabel()
    var nationLabel =  UILabel()
    var dismissBlock : DismissBlock?
    private var selfReference: CityPickerViewController?
    
    
    // DELEGATE
    public weak var delegate: CityPickerViewControllerDelegate! = nil
    
    // ARRAYS
    var nations = cityPickerClass.getNations().nations
    var currentCities = [String]()
    
    // Options
    var startingNation = "Italy"
    var startingCity = "Rome"
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    
    required public init() {
        super.init(nibName:nil, bundle:nil)
        // Set up main view
        
        view.frame = UIScreen.mainScreen().bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        view.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0.0)
        view.addSubview(baseView)
        // Base View
        baseView.frame = view.frame
        
        //visual effect view
        blurView.frame = view.frame
        blurView.effect = UIBlurEffect(style: .Dark)
        baseView.addSubview(blurView)
        
        // close button
        closeBtn.frame = CGRectMake(10, 0, 50, 30)
        closeBtn.layer.masksToBounds = true
        closeBtn.setTitle("Cancel", forState: .Normal)
        closeBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        closeBtn.contentHorizontalAlignment = .Left
        closeBtn.addTarget(self, action: "closeCityPickerView:", forControlEvents: .TouchUpInside)
        baseView.addSubview(closeBtn)
        
        // select button
        selectBtn.frame = CGRectMake(baseView.frame.width - 60, 0, 50, 30)
        selectBtn.layer.masksToBounds = true
        selectBtn.setTitle("Select", forState: .Normal)
        selectBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        selectBtn.contentHorizontalAlignment = .Right
        selectBtn.addTarget(self, action: "selectCityPickerView:", forControlEvents: .TouchUpInside)
        baseView.addSubview(selectBtn)
        
        //title label
        cityLabel.frame = CGRectMake(0, 0, baseView.frame.width - 120, 30)
        cityLabel.center.x = baseView.center.x
        cityLabel.text = startingCity
        cityLabel.textAlignment = .Center
        cityLabel.textColor = UIColor.lightGrayColor()
        cityLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        cityLabel.adjustsFontSizeToFitWidth = true
        cityLabel.minimumScaleFactor = 0.5
        baseView.addSubview(cityLabel)
        
        //nation label
        nationLabel.frame = CGRectMake(0, 0, baseView.frame.width - 120, 30)
        nationLabel.center.x = baseView.center.x
        nationLabel.text = startingNation
        baseView.addSubview(nationLabel)
        nationLabel.hidden = true
        
        //picker view
        cityPicker.frame = CGRectMake(0, 40, baseView.frame.width, baseView.frame.height - 40)
        baseView.addSubview(cityPicker)
        
        
        
        cityPicker.delegate = self
        cityPicker.dataSource = self
        
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
    }
    
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let rv = UIApplication.sharedApplication().keyWindow! as UIWindow
        let sz = rv.frame.size
        
        // Set background frame
        view.frame.size = sz
        
    }
    
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        //cityPicker.delegate = self
        //cityPicker.dataSource = self
    }
    
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        callCities("Italy")
        cityPicker.selectRow(108, inComponent: 0, animated: false)
        cityPicker.selectRow(3398, inComponent: 1, animated: false)
        
        cityPicker.reloadAllComponents()
        cityLabel.text = startingCity
        nationLabel.text = startingNation
        
    }
    
    public override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        cityLabel.text?.removeAll()
        nationLabel.text?.removeAll()
    }
    
    // show view
    public func showCityPicker(ViewController:UIViewController,backgroundColor:UIColor, blurView_hidden: Bool) -> CityPickerViewResponder{
        
        return showCityPickerView(ViewController,backgroundColor: backgroundColor,blurView_hidden: blurView_hidden)
        
    }
    
    public func showCityPickerView(viewController:UIViewController, backgroundColor:UIColor, blurView_hidden: Bool) -> CityPickerViewResponder {
        selfReference = self
        let rv = UIApplication.sharedApplication().keyWindow! as UIWindow
        //rv.addSubview(view)
        view.frame = rv.bounds
        baseView.frame = rv.bounds
        blurView.frame = rv.bounds
        
        
        baseView.backgroundColor = backgroundColor
        blurView.hidden = blurView_hidden
        
        self.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        viewController.presentViewController(selfReference!, animated: true, completion: nil)
        
        
        
        return CityPickerViewResponder(CityPicker: self)
    }
    
    //MARK: Select Button
    
    func selectCityPickerView(sender: UIButton!) {
        
        delegate?.CityPickerDidPressedSelectButton(self, nation: nationLabel.text!, city: cityLabel.text!)
        hideView()
    }
    
    //MARK: Close CityPicker
    
    func closeCityPickerView(sender: UIButton!) {
        
        hideView()
        delegate?.CityPickerDidPressedCancelButton()
    }
    
    public func hideView() {
        UIView.animateWithDuration(0.2, animations: {
            self.view.alpha = 1
            }, completion: { finished in
                
                if(self.dismissBlock != nil) {
                    // Call completion handler when the alert is dismissed
                    self.dismissBlock!()
                }
                
                
                self.dismissViewControllerAnimated(true, completion: nil)
                self.selfReference = nil
        })
    }
    
    
    
    //MARK: Main Functions
    func callCities(_nation: String) {
        
        let citiesArray = cityPickerClass.getNations().allValues[_nation] as! [String]
        let sortedcities = citiesArray.sort {  $0 < $1 }
        
        currentCities = sortedcities
        
    }




//MARK: Extension Picker Delegate

    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            
            return nations.count
            
        }else {
            
            return currentCities.count
        }
        
        
    
    }
    
    
    public func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        
        
        if component == 0 {
            let titleData = nations[row]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Bold", size: 15.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
            return myTitle
        } else {
            
            let titleData = currentCities[row]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Bold", size: 15.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
            return myTitle
        }
        
    }
    
    
    
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            
            callCities(nations[row])
            cityPicker.reloadComponent(1)
        
        }
        
        nationLabel.text = nations[pickerView.selectedRowInComponent(0)]
        cityLabel.text = currentCities[pickerView.selectedRowInComponent(1)]
        
        delegate?.CityPickerDidSelectRow(nationLabel.text!,city: cityLabel.text!)
    }
    
    
    
    override public func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
}
