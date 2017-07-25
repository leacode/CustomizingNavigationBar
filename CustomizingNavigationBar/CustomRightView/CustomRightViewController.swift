//
//  CustomRightViewController.swift
//  CustomizingNavigationBar
//
//  Created by leacode on 2017/7/24.
//  Copyright © 2017年 leacode. All rights reserved.
//

import UIKit

class CustomRightViewController: UITableViewController {
  
  struct BarButtonItemType {
    static let textButton = 0
    static let imageButton = 1
    static let controlButton = 2
    static let originalImageButton = 3
    static let customBarButtonWithBadge = 4
    
  }

  override func viewDidLoad() {
    super.viewDidLoad()

      
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    switch indexPath.row {
    case BarButtonItemType.textButton:
      let addButton = UIBarButtonItem(title: NSLocalizedString("AddTitle", comment: ""), style: .bordered, target: self, action: #selector(action(_:)))
      navigationItem.rightBarButtonItem = addButton
    case BarButtonItemType.imageButton:
      // add our custom image button as the nav bar's custom right view
      let starButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_star"), style: .bordered, target: self, action: #selector(action(_:)))
      navigationItem.rightBarButtonItem = starButton
      
    case BarButtonItemType.controlButton:
      // "Segmented" control to the right
      let segmentedControl = UISegmentedControl(items: [
        "▲",
        "▼"
        ])
      
      segmentedControl.addTarget(self, action: #selector(action), for: .valueChanged)
      segmentedControl.frame = CGRect(x: 0, y: 0, width: 90, height: 30)
      segmentedControl.isMomentary = true
      
      let segmentBarItem = UIBarButtonItem(customView: segmentedControl)
      navigationItem.rightBarButtonItem = segmentBarItem
      
    case BarButtonItemType.originalImageButton:
      
      let listButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_list").withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: .bordered, target: self, action: #selector(action(_:)))
      navigationItem.rightBarButtonItem = listButton
      
    case BarButtonItemType.customBarButtonWithBadge:
      
      let listButton  = UIButton(type: UIButtonType.custom)
      listButton.setImage(#imageLiteral(resourceName: "icon_list").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: UIControlState.normal)
      listButton.addTarget(self, action: #selector(action(_:)), for: UIControlEvents.touchUpInside)
      
      let rightButton = UIBarButtonItem.init(customView: listButton)
      
//      let listButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_list").withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: .bordered, target: self, action: #selector(action(_:)))
      navigationItem.rightBarButtonItem = rightButton
      rightButton.badgeValue = 100
      rightButton.badgeColor = .blue
      rightButton.badgeBorderColor = .red
      rightButton.badgeBorderWidth = 2.0
      rightButton.badgeFont = .systemFont(ofSize: 11.0)
      
    default:
      break
    }
    
  }

  // MARK: - Actions
  
  /**
   *  IBAction for the various bar button items shown in this example.
   */
  @IBAction func action(_ sender: AnyObject) {
    print("CustomRightViewController IBAction invoked!")
  }
  

}
