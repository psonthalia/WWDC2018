import UIKit
import SceneKit
import PlaygroundSupport

let main = Main()

let mainLabel = main.mainLabel
var sceneView = main.sceneView
let camera = main.camera

main.setUp()
main.setUpSolarSystem()

PlaygroundPage.current.liveView = main
