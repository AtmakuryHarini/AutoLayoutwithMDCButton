//
//  ViewController.swift
//  AutoLayoutTblviewEx
//
//  Created by Atmakury Harish on 5/7/18.
//  Copyright © 2018 Atmakury Harini. All rights reserved.
//

import UIKit
import Alamofire
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_ButtonThemer

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MDCInkTouchControllerDelegate{
    private var customTblView :UITableView!
    let saveButton = MDCButton()
    private var titlelbl = UILabel()
    let fontName  = "AvenirNext-DemiBold"
    private var dictTblData =  [[String :[String]]]()
    private var delegate = MDCInkTouchControllerDelegate.self
   
    //-----------------------------------------------------------
    struct courses:Decodable {
    let name: String
    let number_of_lessons:Int
    let id :Int
    }
    private var dictTblData2 =  [courses]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        SetupView()     //view setup
        LayoutSubView() //auto layout

         //tableview data
        dictTblData = [["title":["Vegetarian"],"rows":["Butter","yogurt","milk"],"type":["Plant and Dairy"],"price":["$7","$9","$3"]],
            ["title":["Vegan"],"rows":["orange","Apple","Vegeatables"],"type":["Plant Based"],"price":["$20","$25","$34"]],
            ["title":["Non-Vegetarian"],"rows":["Chicken","Lamb","Pork"],"type":["Animal Based"],"price":["$500","$340","$303"]]]
        customTblView.reloadData()
    }
    //------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    //------------------------------------------------------------
    //MARK: CUSTOM FUNCTIONS
    //------------------------------------------------------------
    
    func SetupView()
    {
    //tableView
    customTblView = UITableView(frame: CGRect(x:0,y:150,width:100,height:100))
    customTblView.register(UINib(nibName: "viewControllerCell", bundle: nil), forCellReuseIdentifier: "customCell")
    customTblView.dataSource = self
    customTblView.delegate = self
    self.view.addSubview(customTblView)
    customTblView.separatorStyle = UITableViewCellSeparatorStyle.none //remove lines
    
    //Title Label
    titlelbl.text = "TYPES OF FOOD"
    titlelbl.font = UIFont(name: fontName, size: 20.0)
    titlelbl.textAlignment = NSTextAlignment.center
    titlelbl.textColor =  UIColor.black
    self.view.addSubview(titlelbl)
        
     // MDC ink save button
    let buttonScheme = MDCButtonScheme()
    MDCTextButtonThemer.applyScheme(buttonScheme, to: saveButton)
    saveButton.setTitleColor(UIColor.green, for: .normal)
    saveButton.translatesAutoresizingMaskIntoConstraints = false
    saveButton.setTitle("Button Clicked", for: .normal)
    self.view.addSubview(saveButton)
    let inkTouchController = MDCInkTouchController(view: saveButton)
    inkTouchController.delegate = ViewController()
    inkTouchController.addInkView()
    saveButton.inkColor = UIColor.white
    saveButton.setBackgroundColor(UIColor.blue)
    saveButton.titleLabel?.textColor = UIColor.white
    }
    
    func LayoutSubView()
    {
    //tableview
    customTblView.translatesAutoresizingMaskIntoConstraints = false
        customTblView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true //top
    customTblView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true //bottom
        
    customTblView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true//width
        
   customTblView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true //leading
  customTblView.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant: 0).isActive = true //trailing
        
    //Title Lable
    titlelbl.translatesAutoresizingMaskIntoConstraints = false
    titlelbl.topAnchor.constraint(equalTo: self.view.topAnchor, constant:80).isActive = true //top
    titlelbl.bottomAnchor.constraint(equalTo:customTblView.topAnchor, constant:0).isActive = true //bottom
        
    titlelbl.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true //width
    titlelbl.heightAnchor.constraint(equalToConstant:20).isActive = true //bottom
    
    titlelbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true //trailing
    titlelbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true //leading
        
    //save button
    saveButton.translatesAutoresizingMaskIntoConstraints = false
    saveButton.topAnchor.constraint(equalTo: customTblView.bottomAnchor, constant:0).isActive = true //top
        
    saveButton.widthAnchor.constraint(equalToConstant: 200).isActive = true //width
    saveButton.heightAnchor.constraint(equalToConstant:40).isActive = true //bottom
    saveButton.centerXAnchor.constraint(equalTo: customTblView.centerXAnchor).isActive = true //centerAxis
    
    }
    func BNdecodedData(from urlstring: String)
    {
        var  responseData = [courses]()
        // Alamofire request
        Alamofire.request(urlstring)
            .responseJSON { response in
                guard response.result.error == nil else {
                    print("error in dowloading")
                    print(response.result.error!)
                    return
                }
                
                // Decoding
                do {
                    let decoder = JSONDecoder()
                    responseData = try decoder.decode([courses].self, from: response.data!)
                    print("response is\(responseData[0].id)")
                } catch {
                    print(error)
                }
        }
        
        
    }

    //------------------------------------------------------------
    //MARK: TABLEVIEW DATA SOURCE AND DELEGATE
    //------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard dictTblData[section]["rows"]?.count != nil else {
        return 0
        }
        return (dictTblData[section]["rows"]?.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? viewControllerCell
    guard (dictTblData[indexPath.section]["rows"]?[indexPath.row]) != nil || (dictTblData[indexPath.section]["price"]?[indexPath.row]) != nil || (dictTblData[indexPath.section]["type"]?[0]) != nil else {
    cell?.cellLabel1.text = "Label1"
    cell?.cellLabel2.text = "Label2"
    cell?.cellLabel3.text = "Label3"
    return cell!
     }
        
   cell?.cellLabel1.text = (dictTblData[indexPath.section]["rows"]?[indexPath.row])!;
   cell?.cellLabel2.text = (dictTblData[indexPath.section]["type"]![0])
   cell?.cellLabel3.text = (dictTblData[indexPath.section]["price"]?[indexPath.row])!;
   return cell!
   }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
    }
    
    //-----------------------------------------------------------
    //MARK: MDC DELEGATES
    //------------------------------------------------------------
    
    func inkTouchController(_ inkTouchController: MDCInkTouchController, shouldProcessInkTouchesAtTouchLocation location: CGPoint) -> Bool {
        return true
    }
    //-----------------------------------------------------------
    //MARK: TABLEVIEW SECTION
    //------------------------------------------------------------
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
    return dictTblData.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
    return dictTblData.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55;
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        //headerview
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor.blue
        
        //header label
        let headerlbl = UILabel()
        headerlbl.textColor = UIColor.white
        headerlbl.font = UIFont(name: fontName, size: 20.0)
        headerlbl.frame = CGRect(x: 0, y: 10, width: customTblView.bounds.size.width, height: 30)
        headerlbl.textAlignment = NSTextAlignment.center
        headerlbl.text = dictTblData[section]["title"]?[0]
        headerView.addSubview(headerlbl)
        
        //layout
        headerlbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerlbl.topAnchor.constraint(equalTo:headerView.topAnchor),
            headerlbl.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            headerlbl.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerlbl.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            ])
        return headerView
    }
    //-----------------------------------------------------------

 


}
