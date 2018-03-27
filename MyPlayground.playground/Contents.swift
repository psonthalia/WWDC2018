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
camera.position = SCNVector3(x: 10, y: -70, z: 40)
camera.eulerAngles = SCNVector3(x: 0.74533, y: 0, z: 0)
//cameraNode.camera = camera
//let cameraOrbit = SCNNode()
//cameraOrbit.addChildNode(cameraNode)
scene.rootNode.addChildNode(camera)
let moveCameraAc = SCNAction.move(by: SCNVector3Make(-30, 0, 0), duration: 10)
moveCameraAc.timingMode = .easeInEaseOut
//camera.runAction(moveCameraAc)


public class Main {
    @objc func setUpSolarSystem() {
        let images = ["sun.jpg", "mercury.jpg", "venus.jpg", "earth.jpg", "mars.jpg", "jupiter.jpg", "saturn.jpg", "uranus.jpg", "neptune.jpg"]

        for i in 0...8 {
            let geometry = SCNSphere(radius: 2)
            let node = SCNNode(geometry: geometry)
        //    node.position = SCNVector3Make(0, 0, 0)
            if(i != 0) {
                node.position = SCNVector3Make(Float((2)*CGFloat(i)), -3-Float((5)*CGFloat(i)), 0)
                node.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 50)))
            } else {
                node.position = SCNVector3Make(0, 0, 0)
            }

            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named: images[i])
            geometry.materials = [material]
            scene.rootNode.addChildNode(node)
            let circlePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 20, height: 20), cornerRadius: 100)
            circlePath.fill(with: CGBlendMode(rawValue: 1)!, alpha: 0)
            circlePath.lineWidth = 1

            let circle = SCNShape(path: circlePath, extrusionDepth: 0.1)
            let carbonNode = SCNNode(geometry: circle)
            carbonNode.position = SCNVector3Make(0, 0, 0)
            let path1 = UIBezierPath(roundedRect: CGRect(x: 1, y: 1, width: 2, height: 2), cornerRadius: 1)
            
//            Timer.scheduledTimer(timeInterval: 1, target: view, selector: #selector(moveInCircle(node:)), userInfo: node, repeats: true)
            
//            let moveAction = SCNAction.moveBy(x: .pi * 2, y: 1, z: 0, duration: 1)

//            node.runAction(moveAction)
        //    scene.rootNode.addChildNode(carbonNode)
        //    let circularMove = SKAction.follow(circle.CGPath, asOffset: false, orientToPath: true, duration: 5)
        
        //    node.runAction(SCNAction.repeatForever(SCNAction.))
        
        //    let circle = UIBezierPath(roundedRect: CGRectMake((300/2) - 200, 350 - 200,400, 400), cornerRadius: 200)
        //    let circularMove = SKAction.follow(circle.CGPath, asOffset: false, orientToPath: true, duration: 5)
        //
        //    node.runAction(circularMove)
        }
    }
    @objc func moveInCircle(node:SCNNode) {
        while true {
            var action = SCNAction.moveBy(x: 1, y: 1, z: 0, duration: 1)
            node.runAction(action)
        }
    }
}
let main = Main()
main.setUpSolarSystem()

view.addSubview(sceneView)
PlaygroundPage.current.liveView = view
