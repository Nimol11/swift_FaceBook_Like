//
//  ViewController.swift
//  FaceBook_Like_Animation
//
//  Created by Nimol on 21/12/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    let iconContentView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        let iconHeight = 40
        let padding: CGFloat = 6
        let image = ["like", "love","wow", "haha", "angry", "sad"]
        let arrangedSubViews = image.map({ (image) -> UIImageView in
            let imageView = UIImageView()
            imageView.image = UIImage(named: image )
            imageView.layer.cornerRadius = CGFloat(iconHeight / 2)
            imageView.contentMode = .scaleToFill
            imageView.backgroundColor = .cyan
            imageView.isUserInteractionEnabled = true
            return imageView
        })
        let stack = UIStackView(arrangedSubviews: arrangedSubViews)
        stack.distribution = .fillEqually
        stack.spacing = padding
        stack.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stack.isLayoutMarginsRelativeArrangement = true
        view.addSubview(stack)
        let numIcon = CGFloat(arrangedSubViews.count)
        let width = numIcon * CGFloat(iconHeight) + (numIcon + 1) * padding
        view.frame = CGRect(x: 0, y: 0, width: Int(width), height: iconHeight + 2 * Int(padding))
        stack.frame = view.frame
        view.layer.cornerRadius = view.frame.height / 2
        view.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLongPressGesture()
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(removeImage))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    @objc func removeImage() {
        imageView.image = UIImage()
    }
    func setUpLongPressGesture() {
        button.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture: ))))
    }
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
             gestureStateBegan(gesture: gesture)
        } else if gesture.state == .ended {
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1) {
                let stackViw = self.iconContentView.subviews.first
                stackViw?.subviews.forEach({ imageview in
                    imageview.transform = .identity
                })
                self.iconContentView.transform = self.iconContentView.transform.translatedBy(x: 0, y: 50)
                self.iconContentView.alpha = 0
            } completion: { _  in
                self.iconContentView.removeFromSuperview()
                (0...5).forEach { _ in
                    self.generateAnimation(images: self.imageView.image)
                }
            }
        } else if gesture.state == .changed {
            gestureStateChange(gesture: gesture)
        }
    }
    private func gestureStateBegan(gesture: UILongPressGestureRecognizer) {
        let pressedLocation = gesture.location(in: self.view)
        view.addSubview(iconContentView)
        let centerX = (view.frame.width - iconContentView.frame.width ) / 2
        iconContentView.alpha = 0
        iconContentView.transform = CGAffineTransform(translationX: centerX, y: pressedLocation.y - (iconContentView.frame.height + 20 ))
        UIView.animate(withDuration: 0.3) { [self] in
            iconContentView.alpha = 1
        }
    }
    private func gestureStateChange(gesture: UILongPressGestureRecognizer) {
        let pressedLocation = gesture.location(in: self.iconContentView)
        let fixYLocation = CGPoint(x: pressedLocation.x, y: iconContentView.frame.height / 2)
        let imagehitTest =  iconContentView.hitTest(fixYLocation, with: nil)
        let x = pressedLocation.x
        let minX = iconContentView.bounds.minX
        let maxX = iconContentView.bounds.maxX
        if  x <= minX - 10 || x >= maxX + 10  {
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5) { [self] in
                let stackView = self.iconContentView.subviews.first
                stackView?.subviews.forEach({ imageView in
                    imageView.transform = .identity
                })
                imageView.image = UIImage()
            }
        } else {
            if imagehitTest is UIImageView {
                let emoji = imagehitTest as? UIImageView
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5) { [self] in
                    let stackView = self.iconContentView.subviews.first
                    stackView?.subviews.forEach({ imageView in
                        imageView.transform = .identity
                    })
                    imagehitTest?.transform = CGAffineTransform(translationX: 0, y: -50)
                    imageView.image = emoji?.image
//                    button.setImage(emoji?.image, for: .normal)
                    
                }
            }
        }
    }
    
//    @objc func createAnimation() {
//        (0...50).forEach { _ in
//            generateAnimation(images: <#UIImage?#>)
//        }
//    }
    func generateAnimation(images: UIImage?) {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        image.image = images
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customePath().cgPath
        animation.duration = 1.5 + drand48() * 3
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.isRemovedOnCompletion = false
        image.layer.add(animation, forKey: nil )
        view.addSubview(image)
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
}

