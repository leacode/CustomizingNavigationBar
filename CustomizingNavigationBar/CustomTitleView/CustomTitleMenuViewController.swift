//
//  CustomTitleMenuViewController.swift
//  CustomizingNavigationBar
//
//  Created by leacode on 2017/7/28.
//  Copyright © 2017年 leacode. All rights reserved.
//

import UIKit

class CustomTitleMenuViewController: UITableViewController {

  struct Constants {
    static let presentViewIdentifier = "presentViewIdentifier"
  }
  
  @IBOutlet weak var arrowImageView: UIImageView!
  @IBOutlet weak var titleView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  @IBAction func tapTitle(_ sender: Any) {
    self.performSegue(withIdentifier: Constants.presentViewIdentifier, sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if #available(iOS 8.0, *) {
      let popoverVC = segue.destination
      popoverVC.view.backgroundColor = UIColor.brown
      let popover = popoverVC.popoverPresentationController
      popover?.delegate = self
      
      UIView.animate(withDuration: 0.3, animations: {
        self.arrowImageView.layer.transform = CATransform3DMakeRotation(CGFloat.pi, 0, 0, 1.0)
      })
      
    } else {
      // Fallback on earlier versions
    }
    
  }
  
}

@available(iOS 8.0, *)
extension CustomTitleMenuViewController: UIPopoverPresentationControllerDelegate {
  
  func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {

    popoverPresentationController.sourceRect = CGRect(x: titleView.frame.origin.x, y: 0, width: titleView.frame.size.width, height: 0)
    popoverPresentationController.backgroundColor = UIColor.brown
    
  }
  
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return .none
  }
  
  func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
    
    UIView.animate(withDuration: 0.3, animations: {
      self.arrowImageView.layer.transform = CATransform3DIdentity
    })
    
    return true
  }
  
  
  
}

