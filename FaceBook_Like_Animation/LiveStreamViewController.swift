//
//  LiveStreamViewController.swift
//  FaceBook_Like_Animation
//
//  Created by Nimol on 15/1/24.
//

import UIKit

class LiveStreamViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(createAnimation))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func createAnimation() {
        (0...50).forEach { _ in
           generateAnimation()
        }
    }
    func generateAnimation() {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        image.image = UIImage(named: "love")
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customePath().cgPath
        animation.duration = 1.5 + drand48() * 3
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.isRemovedOnCompletion = false
        image.layer.add(animation, forKey: nil )
        view.addSubview(image)
    }
}

class CurvedView: UIView {
    override func draw(_ rect: CGRect) {
        let path = customePath()
       
        path.stroke()
    }
    
}
func customePath() -> UIBezierPath{
    let path = UIBezierPath()
   
    let randomYShift = 200 + drand48() * 300
    let midY = UIScreen.main.bounds.midY - 100
    path.move(to: CGPoint(x: 0, y: midY))
    let endPoint = CGPoint(x: UIScreen.main.bounds.maxX + 50 , y: midY)
    let controlPoint1 = CGPoint(x: 150, y: midY  - randomYShift )
    let controlPoint2 = CGPoint(x: 250, y: (midY - 20) + randomYShift )
    path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
    return path
}
