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
        
        let scence = SCNScene(named: "art.scnassets/ramps.scn")!
        sceneView.scene = scence
        
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        scence.rootNode.camera = camera
        
        let tap = UIGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tap)
        
        let rotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.01 * Double.pi), z: 0, duration: 0.1))
        
        
        var obj = SCNScene(named: "art.scnassets/pipe.dae")
        var node = obj?.rootNode.childNode(withName: "pipe", recursively: true)!
        node?.runAction(rotate)
        node?.scale = SCNVector3Make(0.0018, 0.0018,0.0018)
        node?.position = SCNVector3Make(0.010, 0.5, -1)
        scence.rootNode.addChildNode(node!)
        
        obj = SCNScene(named: "art.scnassets/pyramid.dae")
        node = obj?.rootNode.childNode(withName: "pyramid", recursively: true)!
        node?.runAction(rotate)
        node?.scale = SCNVector3Make(0.0018, 0.0018, 0.0018)
        node?.position = SCNVector3Make(0.010, -2, -1)
        scence.rootNode.addChildNode(node!)
        
        obj = SCNScene(named: "art.scnassets/quarter.dae")
        node = obj?.rootNode.childNode(withName: "quarter", recursively: true)!
        node?.runAction(rotate)
        node?.scale = SCNVector3Make(0.0018, 0.0018, 0.0018)
        node?.position = SCNVector3Make(0.010, -2.2, -1)
        scence.rootNode.addChildNode(node!)
 }
    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer){
        let p = gestureRecognizer.location(in: sceneView)
        let hitResult = sceneView.hitTest(p, options: [:])
        if hitResult.count > 0 {
            let node = hitResult[0].node
            print(node.name!)
            rampPlacerVC.onRampSelected(node.name!)
       
    }
}

}
