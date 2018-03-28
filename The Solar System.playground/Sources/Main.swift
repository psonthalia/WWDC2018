import UIKit
import SceneKit
import PlaygroundSupport

open class Main: UIView {
    public var sunNode = SCNNode()
    public var scene = SCNScene()
    public let mainLabel = UILabel(frame: CGRect(x: -18, y: 10, width: 800, height: 50))
    public var sceneView = SCNView()
    public let camera = SCNNode()
    
    public func setUp() {
        sceneView = SCNView(frame: CGRect(x: 0, y: -50, width: 800, height: 800))
        sceneView.isUserInteractionEnabled = true
        sceneView.scene = scene
        var image: UIImage = UIImage(named: "stars.jpg")!
        var bgImage = UIImageView(image: image)
        bgImage.frame = CGRect(x:0,y:0,width:100,height:200)
        scene.background.contents = UIImage(named: "stars.jpg")
        self.frame = CGRect(x: 0, y: 0, width: 800, height: 800)
        
        mainLabel.textAlignment = .center
        mainLabel.font = mainLabel.font.withSize(40)
        mainLabel.text = "The Solar System"
        mainLabel.textColor = UIColor.white
        self.addSubview(bgImage)
        self.addSubview(sceneView)
        self.addSubview(mainLabel)
        self.isUserInteractionEnabled = true
        
        camera.camera = SCNCamera()
        camera.position = SCNVector3(x: 0, y: -70, z: 50)
        camera.eulerAngles = SCNVector3(x: 0.74533, y: 0, z: 0)
        scene.rootNode.addChildNode(camera)
        
    }
    @objc public func setUpSolarSystem() {
        let images = ["sun.jpg", "mercury.jpg", "venus.jpg", "earth.jpg", "mars.jpg", "jupiter.jpg", "saturn.jpg", "uranus.jpg", "neptune.jpg"]
        
        let geometry = SCNSphere(radius: 2)
        sunNode = SCNNode(geometry: geometry)
        sunNode.position = SCNVector3Make(-1.5, -20, 0)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: images[0])
        geometry.materials = [material]
        scene.rootNode.addChildNode(sunNode)
        
        for i in 1...8 {
            let cylinder = SCNCylinder(radius: CGFloat(3+CGFloat(Float(3.8)*Float(i))), height: 0.01)
            if(i < 4) {
                cylinder.firstMaterial?.diffuse.contents = UIImage(named: "circle2.png")!
            } else {
                cylinder.firstMaterial?.diffuse.contents = UIImage(named: "circle.png")!
            }
            let nodeCyl = SCNNode(geometry: cylinder)
            nodeCyl.position = SCNVector3Make(0, 0, 0)
            nodeCyl.rotation = SCNVector4Make(0.1, 0, 0, GLKMathDegreesToRadians(90))
            sunNode.addChildNode(nodeCyl)
            
            let holderNode = SCNNode()
            holderNode.position = SCNVector3(0,0,0)
            sunNode.addChildNode(holderNode)
            
            let geometry = SCNSphere(radius: 2)
            let node = SCNNode(geometry: geometry)
            node.position = SCNVector3Make(Float((2)*CGFloat(i)), -3-Float((3.35)*CGFloat(i)), 0)
            node.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 2 * .pi, y: 0, z: 0, duration: 1)))
            
            
            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named: images[i])
            geometry.materials = [material]
            holderNode.addChildNode(node)
            
            holderNode.runAction(SCNAction.repeatForever(SCNAction.rotate(by: .pi, around: SCNVector3(0,0,1), duration: TimeInterval(i))))
        }
    }
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location: CGPoint = touch!.location(in: sceneView)
        let hits = sceneView.hitTest(location, options: nil)
        if let tappednode = hits.first?.node {
            if(tappednode == sunNode) {
                let moveCameraAc = SCNAction.move(to: SCNVector3Make(sunNode.position.x, sunNode.position.y - 5, sunNode.position.z+5), duration: 2)
                moveCameraAc.timingMode = .easeInEaseOut
                camera.runAction(moveCameraAc)
            }
        }
    }
}
