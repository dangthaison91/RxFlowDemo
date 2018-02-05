//
//  LargeTabbarItem.swift
//  RxFlowDemo
//
//  Created by dangthaison on 1/2/18.
//

import Foundation
import ESTabBarController_swift

class TabbarIrregularityContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView.backgroundColor = UIColor.lightGray
        self.imageView.layer.borderWidth = 3.0
        self.imageView.layer.borderColor = UIColor.init(white: 235 / 255.0, alpha: 1.0).cgColor
        self.insets = UIEdgeInsets(top: -32, left: 0, bottom: 0, right: 0)
        let transform = CGAffineTransform.identity
        self.imageView.transform = transform
        self.superview?.bringSubview(toFront: self)
        
        textColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        iconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        backdropColor = .clear
        highlightBackdropColor = .clear
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let p = CGPoint.init(x: point.x - imageView.frame.origin.x, y: point.y - imageView.frame.origin.y)
        return sqrt(pow(imageView.bounds.size.width / 2.0 - p.x, 2) + pow(imageView.bounds.size.height / 2.0 - p.y, 2)) < imageView.bounds.size.width / 2.0
    }
    
    override func updateLayout() {
        super.updateLayout()
        self.imageView.sizeToFit()
        self.imageView.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
        self.imageView.layer.cornerRadius = imageView.bounds.size.width / 2
    }
    
    public override func selectAnimation(animated: Bool, completion: (() -> Void)?) {
        let view = UIView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize(width: 2.0, height: 2.0)))
        view.layer.cornerRadius = 1.0
        view.layer.opacity = 0.5
        view.backgroundColor = UIColor.init(red: 10/255.0, green: 66/255.0, blue: 91/255.0, alpha: 1.0)
        self.imageView.backgroundColor = UIColor.blue
        
        self.addSubview(view)
        playMaskAnimation(animateView: view, target: self.imageView, completion: {
            [weak view] in
            view?.removeFromSuperview()
            completion?()
        })
    }
    
    public override func reselectAnimation(animated: Bool, completion: (() -> Void)?) {
        completion?()
    }
    
    public override func deselectAnimation(animated: Bool, completion: (() -> Void)?) {
        completion?()
    }
    
    public override func highlightAnimation(animated: Bool, completion: (() -> Void)?) {
        UIView.beginAnimations("small", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = self.imageView.transform.scaledBy(x: 0.8, y: 0.8)
        self.imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }
    
    public override func dehighlightAnimation(animated: Bool, completion: (() -> Void)?) {
        UIView.beginAnimations("big", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = CGAffineTransform.identity
        self.imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }
    
    private func playMaskAnimation(animateView view: UIView, target: UIView, completion: (() -> Void)?) {
        view.center = CGPoint.init(x: target.frame.origin.x + target.frame.size.width / 2.0, y: target.frame.origin.y + target.frame.size.height / 2.0)
        
        //        let scale = POPBasicAnimation.init(propertyNamed: kPOPLayerScaleXY)
        //        scale?.fromValue = NSValue.init(cgSize: CGSize.init(width: 1.0, height: 1.0))
        //        scale?.toValue = NSValue.init(cgSize: CGSize.init(width: 36.0, height: 36.0))
        //        scale?.beginTime = CACurrentMediaTime()
        //        scale?.duration = 0.3
        //        scale?.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        //        scale?.removedOnCompletion = true
        //
        //        let alpha = POPBasicAnimation.init(propertyNamed: kPOPLayerOpacity)
        //        alpha?.fromValue = 0.6
        //        alpha?.toValue = 0.6
        //        alpha?.beginTime = CACurrentMediaTime()
        //        alpha?.duration = 0.25
        //        alpha?.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        //        alpha?.removedOnCompletion = true
        //
        //        view.layer.pop_add(scale, forKey: "scale")
        //        view.layer.pop_add(alpha, forKey: "alpha")
        //
        //        scale?.completionBlock = ({ animation, finished in
        //            completion?()
        //        })
    }
    
}
