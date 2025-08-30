//
//  ARView.swift
//  LAAS
//
//  Created by Sophie Lin on 8/29/22.
//


import SwiftUI
import RealityKit
import ARKit


var bodySkeleton: BodySkeleton?
var bodySkeletonAnchor = AnchorEntity()
//var recordingController = RecordingController()

struct ARGuidedView : View {
    @EnvironmentObject var adasQuestionItems: AdasQuestionItems
    @Binding var tabSelection: Int
    let persistenceController = PersistenceController.shared
    @State private var showingFront = false
    @State private var showingBack = false
    @State private var showingHome = true
    @State private var showingLateral = false
    var body: some View {
       
        VStack{
            if showingFront {
                ARviewControllerFront()
            } else if showingBack {
                ARviewControllerBack()
            } else {
                Image("intro1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            HStack{
                Button(action: {
                    showingFront = false
                    showingBack = false
                    showingHome = true
                    showingLateral = false
                        }) {
                            HStack {
                                Text("Intro")
                            }
                        }.buttonStyle(GradientButtonStyle())
                 Button(action: {
                     showingFront = true
                     showingBack = false
                     showingHome = false
                     showingLateral = false
                         }) {
                             HStack {
                                 Text("Anterior")
                             }
                         }.buttonStyle(GradientButtonStyle())
                Button(action: {
                    showingFront = false
                    showingBack = true
                    showingHome = false
                    showingLateral = false
                       
                        }) {
                            HStack {
                                Text("Posterior")

                            }
                        }.buttonStyle(GradientButtonStyle())
//                 Button(action: {
//                     showingFront = false
//                     showingBack = false
//                     showingHome = false
//                     showingLateral = true
//                        
//                         }) {
//                             HStack {
//                                 Text("Lateral")
//
//                             }
//                         }.buttonStyle(GradientButtonStyle())
             }
           AudioContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(adasQuestionItems)
                
        }
    }
}


//func showFrontView() -> <#Return Type#>{
//
//    return UIViewWrapperView1()
//}

//struct UIViewWrapperView1: UIViewRepresentable {
//
//    func makeUIView(context: Context) -> ARView {
//        //UploadVC()
//
//       // let arVC = ARVC(tattooImage: "addphoto", designID: self.designID)
//        return ARVC(tattooImage: UIImage(contentsOfFile: "addphoto")!, designID: "12").arView
//
//    func updateUIView(_ uiView: ARView, context: Context) {
//
//    }
//}
    
//struct ARViewController: UIViewRepresentable {
//    typealias UIViewType = <#type#>
//
//    typealias UIViewControllerType = ARVC
//
//}





















//
//struct ARViewContainer: UIViewRepresentable {
//
//    func makeUIView(context: Context) -> ARView {
//
//        let arView = ARView(frame: .zero)
//
//        arView.setupARConfiguration()
//        arView.scene.addAnchor(bodySkeletonAnchor)
//
//        return arView
//
//    }
//
//    func updateUIView(_ uiView: ARView, context: Context) {}
//
//}
//
//extension ARView: ARSessionDelegate {
//
//    func setupARConfiguration() {
//        let configuration = ARBodyTrackingConfiguration()
//        self.session.run(configuration)
//
//        self.session.delegate = self
//    }
//
//    public func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
//        for anchor in anchors {
//            if let bodyAnchor = anchor as? ARBodyAnchor {
//
//                if let skeleton = bodySkeleton {
//                    // BodySkeleton already excists, update pose of all joints.
//                    skeleton.updatePositionJoint(with: bodyAnchor)
//                } else {
//                    // Seeing body at first time, make the BodySkeleton.
//                    let skeleton = BodySkeleton(for: bodyAnchor)
//                    bodySkeleton = skeleton
//                    bodySkeletonAnchor.addChild(skeleton)
//                }
//            }
//        }
//    }
//}


