//  ViewController.swift
//  Augmented Reality App
//  Created by Jerry Tan on 22/06/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    //SceneView outlet
    @IBOutlet var sceneView: ARSCNView!
    
    
    
    
    //MARK: - VIEW DID LOAD SECTION
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        //A Boolean value that specifies whether ARKit creates and updates SceneKit lights in the view's scene
        sceneView.automaticallyUpdatesLighting = true
        
        //Declare a diceScene container for the node hierarchy and global properties that together form a displayable 3D scene
        let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")
        //Returns the first node in the node’s child node subtree with the specified name
        if let diceNode = diceScene?.rootNode.childNode(withName: "Dice", recursively: true) {
        //Set diceNode position
        diceNode.position = SCNVector3(x: 0, y: 0, z: 0)
        //Adds a node to the node’s array of children.
        sceneView.scene.rootNode.addChildNode(diceNode)
            
            
            //Declare a six-sided polyhedron geometry whose faces are all rectangles, optionally with rounded edges and corners
            //let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
            //A sphere (or ball or globe) geometry.
            //let sphere = SCNSphere(radius: 0.2)
            //Declare a set of shading attributes that define the appearance of a geometry's surface when rendered
            //let material = SCNMaterial( )
            //The visual contents of the material property—a color, image, or source of animated content. Animatable
            //material.diffuse.contents = UIImage(named: "art.scnassets/ship.scn")
            //An array of SCNMaterial objects that determine the geometry’s appearance when rendered
            //sphere.materials = [material]
            //A structural element of a scene graph, representing a position and transform in a 3D coordinate space, to which you can attach geometry, lights, cameras, or other displayable content
            //let node = SCNNode( )
            //Declare a representation of a three-component vector
            //node.position = SCNVector3(x: 0, y: 0.1, z: -0.5)
            //Set node.gemetry equals to cube
            //node.geometry = sphere
            //Adds a node to the node’s array of children
            //sceneView.scene.rootNode.addChildNode(node)
    }
}
    
    
    
    
    //MARK: - VIEW WILL APPEAR SECTION
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration( )
        
    
        print("World Tracking is supported = \(ARWorldTrackingConfiguration.isSupported)")
        

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    
    
    
    
    
    
    //MARK: - VIEW WILL DISAPPEAR SECTION
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause( )
    }
}
