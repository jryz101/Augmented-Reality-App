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
        
       // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
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
        sceneView.session.pause()
    }
}
