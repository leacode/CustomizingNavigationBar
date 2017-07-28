//
//  CustomTitleViewController.swift
//  CustomizingNavigationBar
//
//  Created by leacode on 2017/7/27.
//  Copyright © 2017年 leacode. All rights reserved.
//

import UIKit

class CustomTitleViewController: UITableViewController {

  private struct BarButtonItemType {
    static let normalTitleText = 0
    static let customTitleText = 1
    static let customTitleView = 2
    static let customTitleView2 = 3
    
    
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()


    }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    switch indexPath.row {
    case BarButtonItemType.normalTitleText:
      navigationItem.titleView = nil
      self.navigationController?.navigationBar.titleTextAttributes = nil
    case BarButtonItemType.customTitleText:
      navigationItem.titleView = nil
      self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.strikethroughColor: UIColor.cyan,
                                                                      NSAttributedStringKey.backgroundColor: UIColor.lightGray,
                                                                      NSAttributedStringKey.strokeColor: UIColor.red,
                                                                      NSAttributedStringKey.foregroundColor: UIColor.brown,
                                                                      NSAttributedStringKey.font : UIFont.italicSystemFont(ofSize: 18.0)]
      
    case BarButtonItemType.customTitleView:
      
      let titleLabel = UILabel()
      
      let attrText = NSMutableAttributedString()
      let attrTextPart1 = NSAttributedString(string: "D", attributes: [NSAttributedStringKey.foregroundColor: UIColor.green,
                                                                       NSAttributedStringKey.font : UIFont.italicSystemFont(ofSize: 18.0)])
      let attrTextPart2 = NSAttributedString(string: "E", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red,
                                                                       NSAttributedStringKey.font : UIFont.italicSystemFont(ofSize: 18.0)])
      let attrTextPart3 = NSAttributedString(string: "M", attributes: [NSAttributedStringKey.foregroundColor: UIColor.blue,
                                                                       NSAttributedStringKey.font : UIFont.italicSystemFont(ofSize: 18.0)])
      let attrTextPart4 = NSAttributedString(string: "O", attributes: [NSAttributedStringKey.foregroundColor: UIColor.purple,
                                                                      NSAttributedStringKey.font : UIFont.italicSystemFont(ofSize: 18.0)])
      attrText.append(attrTextPart1)
      attrText.append(attrTextPart2)
      attrText.append(attrTextPart3)
      attrText.append(attrTextPart4)
      
      titleLabel.attributedText = attrText
      navigationItem.titleView = titleLabel
      
    case BarButtonItemType.customTitleView2:
      let segmentTextContent = [
        NSLocalizedString("Image", comment: ""),
        NSLocalizedString("Text", comment: ""),
        NSLocalizedString("Video", comment: "")
      ]
      
      // Segmented control as the custom title view
      let segmentedControl = UISegmentedControl(items: segmentTextContent)
      segmentedControl.selectedSegmentIndex = 0
      segmentedControl.autoresizingMask = .flexibleWidth
      segmentedControl.frame = CGRect(x: 0, y: 0, width: 400, height: 30)
      segmentedControl.addTarget(self, action: #selector(action(_:)), for: .valueChanged)
      
      self.navigationItem.titleView = segmentedControl
      
    default:
      break
    }
    
  }
  
  @IBAction func dismissNavi(_ sender: Any) {
    self.navigationController!.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func action(_ sender: AnyObject) {
    print("CustomTitleViewController IBAction invoked!")
  }

}
