import UIKit
import SceneKit
import SpriteKit
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
        
        let geometry = SCNSphere(radius: 2)
        let sunNode = SCNNode(geometry: geometry)
        sunNode.position = SCNVector3Make(0, 0, 0)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: images[0])
        geometry.materials = [material]
        scene.rootNode.addChildNode(sunNode)

        for i in 1...8 {
            let cylinder = SCNCylinder(radius: CGFloat(3+CGFloat(Float(5.45)*Float(i))), height: 0.01)

            cylinder.firstMaterial?.diffuse.contents = UIImage(named: "circle.png")!
            let nodeCyl = SCNNode(geometry: cylinder)
            nodeCyl.position = SCNVector3Make(0, 0, 0)
            nodeCyl.rotation = SCNVector4Make(0.1, 0, 0, GLKMathDegreesToRadians(90))
            sunNode.addChildNode(nodeCyl)
            
            let holderNode = SCNNode()
            holderNode.position = SCNVector3(0,0,0)
            sunNode.addChildNode(holderNode)
            
            let geometry = SCNSphere(radius: 2)
            let node = SCNNode(geometry: geometry)
            node.position = SCNVector3Make(Float((2)*CGFloat(i)), -3-Float((5)*CGFloat(i)), 0)
            node.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 50)))
            

            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named: images[i])
            geometry.materials = [material]
            holderNode.addChildNode(node)
            
            holderNode.runAction(SCNAction.repeatForever(SCNAction.rotate(by: .pi, around: SCNVector3(0,0,1), duration: TimeInterval(i))))

        }
    }
}
let main = Main()
main.setUpSolarSystem()

view.addSubview(sceneView)
PlaygroundPage.current.liveView = view
