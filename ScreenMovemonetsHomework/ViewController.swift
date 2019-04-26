//
//  ViewController.swift
//  ScreenMovemonetsHomework
//
//  Created by MCS on 4/25/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit
//UIPanGestureRecognizer
//UIPinchGestureRecognizer
//UILongPressGestureRecognizer
//UIScreenEdgePanGestureRecognizer
class ViewController: UIViewController, UIGestureRecognizerDelegate {

  //MARK: Touch Labels
  @IBOutlet weak var changingText: UILabel!
  @IBOutlet weak var pinchTouchLabel: UILabel!
  @IBOutlet weak var screenPanTouchLabel: UILabel!
  @IBOutlet weak var longTouchLabel: UILabel!
  @IBOutlet weak var panTouchLabel: UILabel!
  
  
  //MARK: Instances of Gestures
  var longGesture = UILongPressGestureRecognizer()
  var pinchGesture = UIPinchGestureRecognizer()
  var screenPanGesture = UIScreenEdgePanGestureRecognizer()
  var panGesture = UIPanGestureRecognizer()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //MARK: Long Gesture
    longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
    longGesture.minimumPressDuration = 2
    longTouchLabel.addGestureRecognizer(longGesture)
  
    //MARK: Pinch Gesture
    pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchTouch(_:)))
    pinchTouchLabel.addGestureRecognizer(pinchGesture)
    
    //MARK: Pan Gesture
    panGesture = UIPanGestureRecognizer(target: self, action: #selector(panTouch(_:)))
    panTouchLabel.addGestureRecognizer(panGesture)
    
    //MARK: Screen Edge Pan Gesture
    screenPanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenTouch(_:)))
    screenPanGesture.edges = .left
    panTouchLabel.addGestureRecognizer(screenPanGesture)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  @objc func longPress(_ sender: UILongPressGestureRecognizer) {
    changingText.text = "Long Pressed"
  }
  
  @objc func pinchTouch(_ sender: UIPinchGestureRecognizer) {
    self.view.bringSubviewToFront(pinchTouchLabel)
    sender.view?.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
    sender.scale = 1.0
    changingText.text = "Pinched"
  }
  
  @objc func panTouch(_ sender: UIPanGestureRecognizer) {
    self.view.bringSubviewToFront(panTouchLabel)
    let translation = sender.translation(in: self.view)
    panGesture = CGPoint(x: panTouchLabel.center.x + translation.x, y: panTouchLabel.center.y + translation.y)
    sender.setTranslation(CGPoint.zero, in: panTouchLabel)
    changingText.text = "Pan Touched"
  }
  
  @objc func screenTouch(_ sender: UIScreenEdgePanGestureRecognizer) {
    if sender.state == .ended {
      changingText.text = "Screen Panned"
    }
    UIView.animate(withDuration: 1.0, animations: {
      self.screenPanTouchLabel.transform = CGAffineTransform(rotationAngle: self / 2)
      })
  }

  
}

