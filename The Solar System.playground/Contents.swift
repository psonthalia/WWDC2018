import UIKit
import SceneKit
import PlaygroundSupport

let main = Main()

let mainLabel = main.mainLabel
var sceneView = main.sceneView
let camera = main.camera

main.setUp()
main.setUpSolarSystem()
//sceneView.scene = main

//main.addSubview(sceneView)
//main.addSubview(mainLabel)
PlaygroundPage.current.liveView = main
