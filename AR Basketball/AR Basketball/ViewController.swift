//
//  ViewController.swift
//  AR Basketball
//
//  Created by Sal B Amer on 8/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import UIKit
import SceneKit
import SceneKit.ModelIO
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        
        // Set the scene to the view
        sceneView.scene = scene
        addBackboard()
        
        registerGestureRecognizer()
    }
    
    func registerGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        sceneView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
//        print("Is this working?")
        // sceneview to be accessed
        // access the point of view for scene View - the center point
        guard let sceneView = gestureRecognizer.view as? ARSCNView else {
            return
        }
        
        guard let centerPoint = sceneView.pointOfView else {
            return
        }
        
        // transfor matrix
        // the orientation
        // the location of camera
        // need the orientation and location to determine position of cmera
        
        let cameraTransform = centerPoint.transform
        let cameraLocation = SCNVector3(x: cameraTransform.m41, y: cameraTransform.m42, z: cameraTransform.m43)
        let cameraOrientation = SCNVector3(x: cameraTransform.m31, y: cameraTransform.m32, z: cameraTransform.m33)
        
        // x1 + x2, y1 + y2, z1 + z2
        let cameraPosition = SCNVector3Make(cameraLocation.x + cameraLocation.x, cameraLocation.y + cameraLocation.y, cameraLocation.z + cameraLocation.z)
    }
    
//            let url = URL(fileURLWithPath: "art.scnassets/hoop.usdz")
//              let scene = try! SCNScene(url: url, options: [.checkConsistency: true])
//
    func addBackboard() {
        guard let backboardScene = SCNScene(named: "art.scnassets/hoop.scn") else {
            return
        }
        
        guard let backboardNode = backboardScene.rootNode.childNode(withName: "backboard", recursively: false) else {
            return
        }
        backboardNode.position = SCNVector3(x: 0, y: 0.5, z: -3)
        sceneView.scene.rootNode.addChildNode(backboardNode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
