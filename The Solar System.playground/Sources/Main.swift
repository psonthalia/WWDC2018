import UIKit
import SceneKit
import PlaygroundSupport

open class Main: UIView {
    var sunNode = SCNNode()
    var scene = SCNScene()
    let mainLabel = UILabel(frame: CGRect(x: -18, y: 10, width: 800, height: 50))
    var sceneView = SCNView()
    let camera = SCNNode()
    var planetNodes = [SCNNode]()
    var holderNodes = [SCNNode]()
    let backButton = UILabel(frame: CGRect(x: 60, y: 15, width: 300, height: 50))
    
    let planetDescription = UILabel(frame: CGRect(x: 200, y: 500, width: 400, height: 200))

    
    public func setUp() {
        sceneView = SCNView(frame: CGRect(x: 0, y: -50, width: 800, height: 800))
        sceneView.isUserInteractionEnabled = true
        sceneView.scene = scene
        let image: UIImage = UIImage(named: "stars.jpg")!
        let bgImage = UIImageView(image: image)
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
        
        let geometry = SCNSphere(radius: 2)
        sunNode = SCNNode(geometry: geometry)
        sunNode.position = SCNVector3Make(-1.5, -20, 0)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: Constants.images[0])
        geometry.materials = [material]
        scene.rootNode.addChildNode(sunNode)
        
        camera.camera = SCNCamera()
        camera.position = SCNVector3(x: 0, y: -70, z: 50)
        camera.eulerAngles = SCNVector3(x: 0.74533, y: 0, z: 0)
        scene.rootNode.addChildNode(camera)
        
        backButton.text = "< Back"
        backButton.textColor = .white
        backButton.font = backButton.font.withSize(25)
        backButton.alpha = 0
        backButton.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.resumeSolarSystem))
        backButton.addGestureRecognizer(tapGesture)
        self.addSubview(backButton)

        planetDescription.text = ""
        planetDescription.textColor = .white
        planetDescription.font = planetDescription.font.withSize(20)
        planetDescription.alpha = 0
        planetDescription.backgroundColor = UIColor(red: 0, green: 0, blue: 255, alpha: 0.5)
        planetDescription.numberOfLines = 0
        self.addSubview(planetDescription)

    }
    @objc public func setUpSolarSystem() {
        for i in 1...8 {
            let cylinder = SCNCylinder(radius: CGFloat(3+CGFloat(Float(3.7)*Float(i))), height: 0.01)
            if(i < 4) {
                cylinder.firstMaterial?.diffuse.contents = UIImage(named: "circle2.png")!
            } else {
                cylinder.firstMaterial?.diffuse.contents = UIImage(named: "circle.png")!
            }
            let nodeCyl = SCNNode(geometry: cylinder)
            nodeCyl.position = SCNVector3Make(-1.5, -20, 0)
            nodeCyl.rotation = SCNVector4Make(0.1, 0, 0, GLKMathDegreesToRadians(90))
            scene.rootNode.addChildNode(nodeCyl)
            
            let holderNode = SCNNode()
            holderNode.position = SCNVector3(-1.5, -20, 0)
            scene.rootNode.addChildNode(holderNode)
            
            let geometry = SCNSphere(radius: 2)
            let node = SCNNode(geometry: geometry)
            node.position = SCNVector3Make(0, -3-Float((3.65)*CGFloat(i)), 0)
            node.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 2 * .pi, y: 0, z: 0, duration: 1)))
            
            
            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named: Constants.images[i])
            geometry.materials = [material]
            holderNode.addChildNode(node)
            planetNodes.append(node)
            holderNodes.append(holderNode)
            
            if(i == 6) {
                let geometry2 = SCNCylinder(radius: 3, height: 0.01)
                let node2 = SCNNode(geometry: geometry2)
                node2.position = SCNVector3Make(0, 0, 0)
                let material2 = SCNMaterial()
                material2.diffuse.contents = UIImage(named: "saturn_ring.png")
                geometry2.materials = [material2]
                
                node.addChildNode(node2)

            }
            
            holderNode.runAction(SCNAction.repeatForever(SCNAction.rotate(by: .pi, around: SCNVector3(0,0,1), duration: TimeInterval(i*2))))
        }
//        let holderNode = SCNNode()
//        holderNode.position = SCNVector3(0, 0, 0)
//        holderNodes[2].addChildNode(holderNode)
//
//        let geometry = SCNPlane.init(width: 10, height: 10)
//        let teslaNode = SCNNode(geometry: geometry)
//        teslaNode.position = SCNVector3Make(5, -3-Float((3.35)*CGFloat(2)), 0)
//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named: "tesla.png")
//        geometry.materials = [material]
//        holderNode.addChildNode(teslaNode)
//        teslaNode.isPaused = true
    }
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location: CGPoint = touch!.location(in: sceneView)
        let hits = sceneView.hitTest(location, options: nil)
        if let tappednode = hits.first?.node {
            if(tappednode == sunNode) {
                let moveCameraAc = SCNAction.move(to: SCNVector3Make(sunNode.position.x, sunNode.position.y - 5, sunNode.position.z+5), duration: 2)
                moveCameraAc.timingMode = .easeInEaseOut
                mainLabel.text = "Sun"
                camera.runAction(moveCameraAc)
            }
            for i in 0...planetNodes.count-1 {
                if(tappednode == planetNodes[i]) {
                    let x = holderNodes[i].convertPosition(planetNodes[i].position, to: scene.rootNode)
                    for j in 0...holderNodes.count - 1 {
                        holderNodes[j].isPaused = true
                        if(j != i) {
                            planetNodes[j].isHidden = true
                        } else {
                            sunNode.isHidden = true
                        }
                    }
                    backButton.alpha = 1
                    planetDescription.alpha = 1
                    planetDescription.text = Constants.planetDescriptions[i]
                    let moveCameraAc = SCNAction.move(to: SCNVector3Make(x.x, x.y - 5, 7), duration: 2)
                    moveCameraAc.timingMode = .easeInEaseOut
                    camera.runAction(moveCameraAc)
                    mainLabel.text = Constants.planetNames[i]
                }
            }
        }
    }
    @objc public func resumeSolarSystem() {
        let moveCameraAc = SCNAction.move(to: SCNVector3(x: 0, y: -70, z: 50), duration: 2)
        moveCameraAc.timingMode = .easeInEaseOut
        camera.runAction(moveCameraAc)
        backButton.alpha = 0
        for j in 0...holderNodes.count - 1 {
            holderNodes[j].isPaused = false
            planetNodes[j].isHidden = false
            sunNode.isHidden = false
        }
        
    }
}
