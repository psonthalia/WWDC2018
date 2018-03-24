import UIKit
import SceneKit
import PlaygroundSupport // for the live preview

// create a scene view with an empty scene
var sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: 700, height: 700))
var scene = SCNScene()
sceneView.scene = scene

var image: UIImage = UIImage(named: "stars.jpg")!
var bgImage = UIImageView(image: image)
bgImage.frame = CGRect(x:0,y:0,width:100,height:200)
scene.background.contents = UIImage(named: "stars.jpg")
let view = UIView(frame: CGRect(x: 0, y: 0, width: 700, height: 700))
view.addSubview(bgImage)

let camera = SCNNode()
camera.camera = SCNCamera()
//camera.zNear = 0
//camera.zFar = 100
//let cameraNode = SCNNode()
camera.position = SCNVector3(x: 0, y: 0, z: 90)
//cameraNode.camera = camera
//let cameraOrbit = SCNNode()
//cameraOrbit.addChildNode(cameraNode)
scene.rootNode.addChildNode(camera)
let moveCameraAc = SCNAction.move(by: SCNVector3Make(-30, 0, 0), duration: 10)
moveCameraAc.timingMode = .easeInEaseOut
//camera.runAction(moveCameraAc)

let images = ["sun.jpg", "mercury.jpg", "venus.jpg", "earth.jpg", "mars.jpg", "jupiter.jpg", "saturn.jpg", "uranus.jpg", "neptune.jpg"]

for i in 0...8 {
    let geometry = SCNSphere(radius: 2)
    let node = SCNNode(geometry: geometry)
//    node.position = SCNVector3Make(0, 0, 0)
    if(i != 0) {
        node.position = SCNVector3Make(0, -3-Float((5)*CGFloat(i)), 0)
    } else {
        node.position = SCNVector3Make(0, 0, 0)
    }
    let material = SCNMaterial()
    material.diffuse.contents = UIImage(named: images[i])
    geometry.materials = [material]
    scene.rootNode.addChildNode(node)
    node.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 50)))
    let circlePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 20, height: 20), cornerRadius: 100)
    circlePath.fill(with: CGBlendMode(rawValue: 1)!, alpha: 0)
    circlePath.lineWidth = 1

    let circle = SCNShape(path: circlePath, extrusionDepth: 0.1)
    let carbonNode = SCNNode(geometry: circle)
    carbonNode.position = SCNVector3Make(0, 0, 0)
    scene.rootNode.addChildNode(carbonNode)
//    let circularMove = SKAction.follow(circle.CGPath, asOffset: false, orientToPath: true, duration: 5)
    
//    node.runAction(SCNAction.repeatForever(SCNAction.))
    
//    let circle = UIBezierPath(roundedRect: CGRectMake((300/2) - 200, 350 - 200,400, 400), cornerRadius: 200)
//    let circularMove = SKAction.follow(circle.CGPath, asOffset: false, orientToPath: true, duration: 5)
//
//    node.runAction(circularMove)
}

view.addSubview(sceneView)
PlaygroundPage.current.liveView = view
