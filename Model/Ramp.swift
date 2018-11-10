//
//  Ramp.swift
//  Ramp-Up
//
//  Created by Stephen Reyes on 11/9/18.
//  Copyright © 2018 Stephen Reyes. All rights reserved.
//

import Foundation
import SceneKit

class Ramp {
    
    
    class func getRampForName(rampName: String) -> SCNNode {
        switch rampName {
        case "pipe":
            return Ramp.getPipe()
        case "pyramid":
            return Ramp.getPyramide()
        case "quarter":
            return Ramp.getQuarter()
        default:
            return Ramp.getPipe()
        }
        
    }
    
    class func getPipe() -> SCNNode {
        var obj = SCNScene(named: "art.scnassets/pipe.dae")
        var node = obj?.rootNode.childNode(withName: "pipe", recursively: true)!
        node?.scale = SCNVector3Make(0.0018, 0.0018,0.0018)
        node?.position = SCNVector3Make(0.010, 0.5, -1)
        return node!
    }
    
    class func getPyramide() -> SCNNode {
        let obj = SCNScene(named: "art.scnassets/pyramid.dae")
        let node = obj?.rootNode.childNode(withName: "pyramid", recursively: true)!
        node?.scale = SCNVector3Make(0.0018, 0.0018, 0.0018)
        node?.position = SCNVector3Make(0.010, -2, -1)
        return node!
    }

    class func getQuarter() -> SCNNode {
        let obj = SCNScene(named: "art.scnassets/quarter.dae")
        let node = obj?.rootNode.childNode(withName: "quarter", recursively: true)!
        node?.scale = SCNVector3Make(0.0018, 0.0018, 0.0018)
        node?.position = SCNVector3Make(0.010, -2.2, -1)
        return node!
    }

    class func startRotation(node: SCNNode){
         let rotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.01 * Double.pi), z: 0, duration: 0.1))
        node.runAction(rotate)
    }
}
