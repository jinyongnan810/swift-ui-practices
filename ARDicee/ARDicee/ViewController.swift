//
//  ViewController.swift
//  ARDicee
//
//  Created by Yuunan kin on 2025/01/05.
//

import ARKit
import SceneKit
import UIKit

class ViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!

    var dices: [SCNNode] = []

    @IBAction func onRollTapped(_ sender: UIBarButtonItem) {
        rollAll()
    }
    @IBAction func onClearTapped(_ sender: UIBarButtonItem) {
        for dice in dices {
            dice.removeFromParentNode()
        }
        dices = []
    }

    override func motionEnded(
        _ motion: UIEvent.EventSubtype,
        with event: UIEvent?
    ) {
        rollAll()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.debugOptions = [.showFeaturePoints]

        // Set the view's delegate
        sceneView.delegate = self

        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true

        let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        cube.materials = [material]
        let node = SCNNode()
        // x = horizontal, y = vertical, z = deepness
        node.position = SCNVector3(0, 0.2, -1)
        node.geometry = cube

        let moon = SCNSphere(radius: 0.2)
        let moonMaterial = SCNMaterial()
        // downloaded from https://www.solarsystemscope.com/textures/
        moonMaterial.diffuse.contents = UIImage(named: "art.scnassets/moon.jpg")
        moon.materials = [moonMaterial]
        let moonNode = SCNNode()
        moonNode.position = SCNVector3(0, 0.4, -0.5)
        moonNode.geometry = moon

        sceneView.autoenablesDefaultLighting = true

//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene

        // Create a new scene
        // downloaded from https://www.turbosquid.com/ja/3d-models/free-plastic-dice-3d-model/979691
        // converted to scene by: Editer->convert
//        let scene = SCNScene(named: "art.scnassets/dice_scene.scn")!
//        let diceNode = scene.rootNode.childNode(withName: "Dice", recursively: true)!
//        diceNode.position = SCNVector3(0, 0, -0.1)

        // Set the scene to the view
//        sceneView.scene.rootNode.addChildNode(diceNode)
        sceneView.scene.rootNode.addChildNode(node)
        sceneView.scene.rootNode.addChildNode(moonNode)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

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

    func session(_: ARSession, didFailWithError _: Error) {
        // Present an error message to the user
    }

    func sessionWasInterrupted(_: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }

    func sessionInterruptionEnded(_: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }

    func renderer(
        _: any SCNSceneRenderer,
        didAdd node: SCNNode,
        for anchor: ARAnchor
    ) {
        guard let anchor = anchor as? ARPlaneAnchor else {
            return
        }

        let plane = SCNPlane(
            width: CGFloat(anchor.planeExtent.width),
            height: CGFloat(anchor.planeExtent.height)
        )

        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3(
            x: anchor.center.x, y: 0, z: anchor.center.z
        )
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)

        let planeMaterial = SCNMaterial()
        planeMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
        planeNode.geometry?.materials = [planeMaterial]

        node.addChildNode(planeNode)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: sceneView)

        let hitTestResults = sceneView.hitTest(
            location,
            types: .existingPlaneUsingExtent
        )
        if let hitTestResult = hitTestResults.first {
            let worldTransform = hitTestResult.worldTransform
            let scene = SCNScene(named: "art.scnassets/dice_scene.scn")!
            let diceNode = scene.rootNode.childNode(withName: "Dice", recursively: true)!
            diceNode.position = SCNVector3(
                x: worldTransform.columns.3.x, y: worldTransform.columns.3.y + diceNode.boundingSphere.radius, z: worldTransform.columns.3.z
            )
            sceneView.scene.rootNode.addChildNode(diceNode)
            dices.append(diceNode)
            roll(diceNode)
        } else {
            print("touched outside of plane")
        }
    }

    private func rollAll() {
        for dice in dices {
            roll(dice)
        }
    }

    private func roll (_ dice: SCNNode) {
        let xRotation = Float(arc4random_uniform(16) + 1) * (Float.pi / 2)
        let zRotation = Float(arc4random_uniform(16) + 1) * (Float.pi / 2)
        dice
            .runAction(
                SCNAction
                    .rotateBy(
                        x: CGFloat(xRotation),
                        y: 0,
                        z: CGFloat(zRotation),
                        duration: 0.5
                    )
            )
    }
}
