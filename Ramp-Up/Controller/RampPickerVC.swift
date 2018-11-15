//
//  RampPickerVC.swift
//  Ramp-Up
//
//  Created by Stephen Reyes on 11/8/18.
//  Copyright © 2018 Stephen Reyes. All rights reserved.
//

import UIKit
import SceneKit

class RampPickerVC: UIViewController {
    
    var sceneView: SCNView!
    var size : CGSize!
    weak var rampPlacerVC: RampPlacerVC!
    
    init(size: CGSize) {
        super.init (nibName: nil, bundle: nil)
        self.size = size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame = CGRect(origin: CGPoint.zero, size: size)
        sceneView = SCNView.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        view.insertSubview(sceneView, at: 0)
        
        preferredContentSize = size
        view.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.layer.borderWidth = 3.0
        
        
        let scence = SCNScene(named: "art.scnassets/ramps.scn")!
        sceneView.scene = scence
        
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        scence.rootNode.camera = camera
        
        let tap = UIGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tap)
        
        let pipe = Ramp.getPipe()
        Ramp.startRotation(node: pipe)
        scence.rootNode.addChildNode(pipe)
        
        let pryamid = Ramp.getPyramide()
        Ramp.startRotation(node: pryamid)
        scence.rootNode.addChildNode(pryamid)
        
        let quarter = Ramp.getQuarter()
        Ramp.startRotation(node: quarter)
        scence.rootNode.addChildNode(quarter)
 }
    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer){
        let p = gestureRecognizer.location(in: sceneView)
        let hitResult = sceneView.hitTest(p, options: [:])
        if hitResult.count > 0 {
            let node = hitResult[0].node
            print(node.name!)
            rampPlacerVC.onRampSelected(node.name!)
            dismiss(animated: true, completion: nil)
       
    }
}

}
