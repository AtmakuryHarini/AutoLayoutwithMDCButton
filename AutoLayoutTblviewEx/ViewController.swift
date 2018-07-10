//
//  ViewController.swift
//  AutoLayoutTblviewEx
//
//  Created by Atmakury Harish on 5/7/18.
//  Copyright © 2018 Atmakury Harini. All rights reserved.
//
import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_ButtonThemer
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MDCInkViewDelegate {
    private lazy var customTblView :UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.register(tableCell.self, forCellReuseIdentifier: "customCell")
        tableView.dataSource = self
        tableView.delegate = self
        //u need to include these 2 to make the file dynamic
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none //putting UITableViewCellSeparatorStyle infront is uncessary
        return tableView
    }()
    
    private lazy var titlelbl:UILabel = {
        let label = UILabel()
        label.text = "TYPES OF FOOD"
        label.font = UIFont(name: fontName, size: 20.0)
        label.textAlignment = NSTextAlignment.center
        label.textColor =  UIColor.black
        
        return label
    }()
    private lazy var saveButton:MDCButton =
    {
    let button = MDCButton()
    let buttonScheme = MDCButtonScheme()
    MDCTextButtonThemer.applyScheme(buttonScheme, to: button)
    button.setTitleColor(UIColor.green, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Button Clicked", for: .normal)
    button.inkColor = UIColor.white
    button.setBackgroundColor(UIColor.blue)
    button.titleLabel?.textColor = UIColor.white

    return button
    }()

    let fontName  = "AvenirNext-DemiBold"
    private var dictTblData:[[String :[String]]] = [["title":["Vegetarian"],"rows":["Butter","yogurt","milk"],"type":["Plant and Dairy"],"price":["$7","$9","$3"]],
                                                    ["title":["Vegan"],"rows":["orange","Apple","Vegeatables"],"type":["Plant Based"],"price":["$20","$25","$34"]],
                                                    ["title":["Non-Vegetarian"],"rows":["Chicken","Lamb","Pork"],"type":["Animal Based"],"price":["$500","$340","$303"]]]
    //-----------------------------------------------------------
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()     //view setup
        layoutConstraints() //auto layout
       
    }
    
    //------------------------------------------------------------
    //MARK: CUSTOM FUNCTIONS
    //------------------------------------------------------------
    
    lazy var stackView:UIStackView = {
        let stackView:UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titlelbl)
        stackView.addArrangedSubview(customTblView)
        stackView.addArrangedSubview(saveButton)
        return stackView
    }()
    
    func setupView()
    {
        view.addSubview(stackView)
    }
    
    func layoutConstraints()
    {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true //top
        stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true //bottom
        stackView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true//width
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant:0).isActive = true
         stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant:0).isActive = true
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? tableCell
        
        
        //this is good that you are guarding against nil here to stop potential bad text
        //but what happens if only 1 of the dataSource rows are empty? e.g. just rows
        //would you need to see the rest?
        guard (dictTblData[indexPath.section]["rows"]?[indexPath.row]) != nil || (dictTblData[indexPath.section]["price"]?[indexPath.row]) != nil || (dictTblData[indexPath.section]["type"]?[0]) != nil else {
            
            cell?.cellLabel1.text = "Label1"
            cell?.cellLabel2.text = "Label2"
            cell?.cellLabel3.text = "Label3"
            return cell!
        }
        
        cell?.cellLabel1.text = (dictTblData[indexPath.section]["rows"]?[indexPath.row])!
        cell?.cellLabel2.text = (dictTblData[indexPath.section]["type"]![0])
        cell?.cellLabel3.text = (dictTblData[indexPath.section]["price"]?[indexPath.row])!
        return cell!
    }
    
    //no need just use autolayout
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //    return 40
    //    }
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
        
        //unecessary framing
        let headerView = UIView()
        headerView.backgroundColor =  UIColor(red: 0/255, green: 159/255, blue: 184/255, alpha: 1.0)
        
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
