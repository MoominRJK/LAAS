//
//  ARVC.swift
//  LAAS
//
//  Created by Sophie Lin on 11/2/22.
//


import UIKit
import ARKit

class ARVC: UIViewController {
    
    private var arView = ARView()
    //for convenience. I change this to public
    private var sceneView: ARSCNView {
        return arView.ARView
    }
    //Serial queue for updating nodes
    private var updateQueue: DispatchQueue {
        return DispatchQueue(label: Bundle.main.bundleIdentifier! + ".serialSceneKitQueue")
    }
    private var currentNode: SCNNode?
    private var lungImage: UIImage!
    private var designID: String?
    
    init(lungImage: UIImage, designID: String?) {
        self.lungImage = lungImage
        self.designID = designID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        view.addSubview(arView)
        arView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAR()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //pause ar
        sceneView.session.pause()
    }
    
    private func startAR() {
        //remove all existing nodes
        sceneView.scene.rootNode.childNodes.forEach { (node) in
            node.removeFromParentNode()
        }
        //start ar
        //this configuration uses the back camera and tracks device's movement
        let configuration = ARWorldTrackingConfiguration()
        //load the set of reference images

                guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
                    print("Missing asset images")
                    return
                }
        //tell the AR configuration to detect these reference images
        configuration.detectionImages = referenceImages
        configuration.planeDetection = [.horizontal, .vertical]
        
        //run the scene
        //if the scene is paused, it will remove all nodes and stop tracking
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    private func setUpViews() {
        sceneView.delegate = self
        sceneView.allowsCameraControl = true
    }
    
    @objc private func dismissView() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension ARVC: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor
            //        let planeAnchor = anchor as? ARPlaneAnchor
            else {
                print("couldn't get image anchor")
                return
        }

        let referenceImage = imageAnchor.referenceImage
        updateQueue.async {
            let image = self.lungImage!
            //points to meters = (x points * 0.000352778
            let imageWidthMeters = image.size.width * 0.000352778
            let imageHeightMeters = image.size.height * 0.000352778
            //find the smallest scale, to scale uiimage down to size of reference
            let scaleWidth = (referenceImage.physicalSize.width < imageWidthMeters) ? referenceImage.physicalSize.width / imageWidthMeters : imageWidthMeters / referenceImage.physicalSize.width
            let scaleHeight = (referenceImage.physicalSize.height < imageHeightMeters) ? referenceImage.physicalSize.height / imageHeightMeters : imageHeightMeters / referenceImage.physicalSize.height
            //use the smaller scale
            var scale = (scaleWidth > scaleHeight) ? scaleHeight : scaleWidth
            scale = 0.5

            //create the plane for the initial position of the detected image
            let plane = SCNPlane(width: imageWidthMeters * scale, height: imageHeightMeters * scale)
            //let plane = SCNPlane(width: imageWidthMeters, height: imageHeightMeters)
            let material = SCNMaterial()
            material.diffuse.contents = image
            plane.materials = [material]
            let planeNode = SCNNode(geometry: plane)
            planeNode.opacity = 0.75

            //SCNPlane is vertically oriented by default, but imageAnchor is horizontally orientated, but ARImageAnchor assumes the image is horizontal, so rotate the plane to match
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)

            node.addChildNode(planeNode)
            //remove previous node in case multiple ones are added
            if let previousNode = self.currentNode, let anchor = self.sceneView.anchor(for: previousNode) {
                self.sceneView.session.remove(anchor: anchor)
                //should get rid of the current node
                previousNode.removeFromParentNode()
            }
            //add current node
            self.currentNode = planeNode
        }
    }
}

