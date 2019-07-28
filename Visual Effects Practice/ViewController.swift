//
//  ViewController.swift
//  Visual Effects Practice
//
//  Created by Terry Bu on 7/27/19.
//  Copyright © 2019 Terry Bu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ring1 = Ring(frame: CGRect(x: view.center.x, y: view.center.y, width: 100, height: 100))
        let square1 = UIView(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
        square1.backgroundColor =  .red
        
        let triangle1 = Triangle(frame: CGRect(x: 65, y: 25, width: 70, height: 120))
        triangle1.backgroundColor = .clear
        
        addSubviews(subviews: [ring1, square1, triangle1])


        // Generate UIDynamiAnimator and save instance.
        animator = UIDynamicAnimator(referenceView: self.view)
        
        // Create gravity and apply it to View.
        gravity = UIGravityBehavior(items: [ring1, square1, triangle1])
        gravity.magnitude = 0.3
        
        animator.addBehavior(gravity)

        collision = UICollisionBehavior(items: [ring1, square1, triangle1])
        collision.translatesReferenceBoundsIntoBoundary = true
        
        animator.addBehavior(collision)
    }
    
    private func addSubviews(subviews: [UIView]) {
        for subview in subviews {
            self.view.addSubview(subview)
        }
    }
    
    
}


class Ring:UIView {
    override func draw(_ rect: CGRect)
    {
        let halfSize:CGFloat = min( bounds.size.width/2, bounds.size.height/2)
        let desiredLineWidth:CGFloat = 1    // your desired value
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x:halfSize,y:halfSize),
            radius: CGFloat( halfSize - (desiredLineWidth/2) ),
            startAngle: CGFloat(0),
            endAngle:CGFloat(Double.pi * 2),
            clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = desiredLineWidth
        
        layer.addSublayer(shapeLayer)
    }
    
}
    

class Triangle: UIView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.frame.width/2, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.close()
        // Specify the fill color and apply it to the path.
        UIColor.orange.setFill()
        path.fill()
        
        // Specify a border (stroke) color.
        UIColor.purple.setStroke()
        path.stroke()
    }
    
}

