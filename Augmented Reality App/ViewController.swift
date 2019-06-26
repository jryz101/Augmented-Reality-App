//  ViewController.swift
//  Augmented Reality App
//  Created by Jerry Tan on 22/06/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    //Set heartArray equals to [SCNModel]( )
    var heartArray = [SCNNode] ( )
    
    //SceneView outlet
    @IBOutlet var sceneView: ARSCNView!
    
    
    
    
    //MARK: - VIEW DID LOAD SECTION
    override func viewDidLoad() {
        super.viewDidLoad( )
        
        //Display a point cloud showing intermediate results of the scene analysis that ARKit uses to track device position.
        //self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        // Set the view's delegate
        sceneView.delegate = self
        
        //A Boolean value that specifies whether ARKit creates and updates SceneKit lights in the view's scene
        sceneView.automaticallyUpdatesLighting = true
    }
    
    
    
    
    
    
    //MARK: - VIEW WILL APPEAR SECTION
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //A Boolean value indicating whether the current device supports this session configuration class.
        print("World Tracking is supported = \(ARWorldTrackingConfiguration.isSupported)")
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration( )
        
        //A value specifying whether and how the session attempts to automatically detect flat surfaces in the camera-captured image
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    
    
    
    
    
    
    //MARK: - VIEW WILL DISAPPEAR SECTION
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause( )
    }
    
    
    
    
    

    //Tells this object that one or more new touches occurred in a view or window.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Optional binding methods for set location on the scene view
        if let touch = touches.first {
            //Returns the current location of the receiver in the coordinate system of the given view.
            let touchLocation = touch.location(in: sceneView)
            //Searches for real-world objects or AR anchors in the captured camera image corresponding to a point in the SceneKit view.
            let results = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
            
            //Optional binding methods for return touch results.
            if let hitResults = results.first {
                //Declare a heartScene container for the node hierarchy and global properties that together form a displayable 3D scene
                let heartScene = SCNScene(named: "art.scnassets/Heart.scn")
                
                //Returns the first node in the node’s child node subtree with the specified name
                if let heartNode = heartScene?.rootNode.childNode(withName: "Heart", recursively: true) {
                    
                //Set heartNode position
                heartNode.position = SCNVector3 (
                    
                        //The position and orientation of the hit test result relative to the world coordinate system.
                        x: hitResults.worldTransform.columns.3.x,
                        y: hitResults.worldTransform.columns.3.y + heartNode.boundingSphere.radius,
                        z: hitResults.worldTransform.columns.3.z
                    )
                
                heartArray.append(heartNode)
                    
                //Adds a node to the node’s array of children.
                sceneView.scene.rootNode.addChildNode(heartNode)
                    
            }
        }
    }
}
    
    
    
    
    
    
    //MARK: - REMOVE OBJECT BUTTON SECTION
    @IBAction func removeButton(_ sender: UIBarButtonItem) {
        
        //Conditional methods for remove the heartNode
        if !heartArray.isEmpty {
            
            for heart in heartArray {
                //Removes the node from its parent’s array of child nodes.
                heart.removeFromParentNode()
            }
            
        }
    }
    
    
    
    
    
    
    
    
    //Methods and properties common to the SCNView, SCNLayer, and SCNRenderer classes.
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        //If the Information about the position and orientation of a real-world flat surface detected in a world-tracking AR session.
        if anchor is ARPlaneAnchor {
            
            //Set planAnchor object equals to anchor and down cast as ARPlaneAnchor
            let planAnchor = anchor as! ARPlaneAnchor
            //A rectangular, one-sided plane geometry of specified width and height.
            let plane = SCNPlane(width: CGFloat(planAnchor.extent.x), height: CGFloat(planAnchor.extent.z))
            
            //Set planeNode object equals to SCNNode( ).
            let planeNode = SCNNode( )
            planeNode.position = SCNVector3(x: planAnchor.center.x, y: 0, z: planAnchor.center.x)
            
            //The transform applied to the node relative to its parent. Animatable.
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            
            //A set of shading attributes that define the appearance of a geometry's surface when rendered.
            let gridMaterial = SCNMaterial( )
            //An object that manages image data in your app.
            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            
            //An array of SCNMaterial objects that determine the geometry’s appearance when rendered.
            plane.materials = [gridMaterial]
            //The geometry attached to the node.
            planeNode.geometry = plane
            //Adds a node to the node’s array of children.
            node.addChildNode(planeNode)
        } else {
            return
        }
    }
}

