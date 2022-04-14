//
//  UtilsView.swift
//  PuzzleKu
//
//  Created by Rasyid Ridla on 30/03/22.
//

import Lottie
import SwiftUI


//lottie view
struct LootieView: UIViewRepresentable {
    typealias UIViewType = UIView
    var fileName : String
    
    func makeUIView(context: UIViewRepresentableContext<LootieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = AnimationView()
        let animation = Animation.named(fileName)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([animationView.widthAnchor.constraint(equalTo: view.widthAnchor), animationView.heightAnchor.constraint(equalTo: view.heightAnchor)])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LootieView>) {
    }
}

//resignKeyboard
extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

//resignKeyboard extension
extension UIApplication {
    /// Resigns the keyboard.
    ///
    /// Used for resigning the keyboard when pressing the cancel button in a searchbar based on [this](https://stackoverflow.com/a/58473985/3687284) solution.
    /// - Parameter force: set true to resign the keyboard.
    func endEditing(_ force: Bool) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.endEditing(force)
    }
}

//resignKeyboard extension
struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

//screen size
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

//Custom Shape
struct CustomShape : Shape {
    var corner : UIRectCorner
    var radii : CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radii, height: radii))
        
        return Path(path.cgPath)
    }
}


//share view
public func shareSheet(content: [String]){
    let av = UIActivityViewController(activityItems: [NSLocalizedString("\(content.map{$0})", comment: "")], applicationActivities: nil)
   UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
}

//preview
struct UtilsView_Previews: PreviewProvider {
    static var previews: some View {
        LootieView(fileName: "splash")
    }
}
