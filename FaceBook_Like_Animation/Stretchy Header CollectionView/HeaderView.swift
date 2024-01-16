//
//  HeaderView.swift
//  FaceBook_Like_Animation
//
//  Created by Nimol on 15/1/24.
//

import UIKit

class HeaderView: UICollectionReusableView {

    static let identifier: String = "HeaderView"
    static let nib: UINib = UINib(nibName: "HeaderView", bundle: nil)
    @IBOutlet weak var image: UIImageView!
    
    var animator: UIViewPropertyAnimator?
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpVisualBlueEffect()
        gradientColor()
    }
    
    private func setUpVisualBlueEffect() {
        let blueEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView()
        self.addSubview(visualEffectView)
        visualEffectView.frame = self.frame
        animator = UIViewPropertyAnimator(duration: 3, curve: .linear, animations: {
            visualEffectView.effect = blueEffect
        })
    }
    private func gradientColor() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0,1]
        layer.addSublayer(gradient)
        gradient.frame = self.frame
    }
    
}
