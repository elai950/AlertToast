import SwiftUI

@available(iOS 13, *)
struct AnimatedCheckmark: View {
    
    var color: Color = .black
    
    var size: Int
    
    var height: CGFloat {
        return CGFloat(size)
    }
    
    var width: CGFloat {
        return CGFloat(size)
    }
    
    @State private var percentage: CGFloat = .zero
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: height / 2))
            path.addLine(to: CGPoint(x: width / 2.5, y: height))
            path.addLine(to: CGPoint(x: width, y: 0))
        }
        .trim(from: 0, to: percentage)
        .stroke(color, style: StrokeStyle(lineWidth: CGFloat(size / 8), lineCap: .round, lineJoin: .round))
        .animation(Animation.spring().speed(0.75).delay(0.25))
        .onAppear {
            percentage = 1.0
        }
        .frame(width: width, height: height, alignment: .center)
    }
}

@available(iOS 13, *)
struct AnimatedXmark: View {
    
    var color: Color = .black
    
    var size: Int
    
    var height: CGFloat {
        return CGFloat(size)
    }
    
    var width: CGFloat {
        return CGFloat(size)
    }
    
    var rect: CGRect{
        return CGRect(x: 0, y: 0, width: size, height: size)
    }
    
    @State private var percentage: CGFloat = .zero
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxY, y: rect.maxY))
            path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
        .trim(from: 0, to: percentage)
        .stroke(color, style: StrokeStyle(lineWidth: CGFloat(size / 8), lineCap: .round, lineJoin: .round))
        .animation(Animation.spring().speed(0.75).delay(0.25))
        .onAppear {
            percentage = 1.0
        }
        .frame(width: width, height: height, alignment: .center)
    }
}

@available(iOS 13, *)
public struct AlertToast: View{
    
    public enum AlertType: Equatable{
        case complete(Color)
        case error(Color)
        case systemImage(String, Color)
        case image(String)
        case regular
    }
    
    var type: AlertType
    var title: String
    var subTitle: String?
    
    public init(type: AlertType, title: String, subTitle: String? = nil){
        self.type = type
        self.title = title
        self.subTitle = subTitle
    }
    
    public var body: some View{
        VStack{
            
            switch type{
            case .complete(let color):
                Spacer()
                AnimatedCheckmark(color: color, size: 50)
                Spacer()
            case .error(let color):
                Spacer()
                AnimatedXmark(color: color, size: 50)
                Spacer()
            case .systemImage(let name, let color):
                Spacer()
                Image(systemName: name)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .foregroundColor(color)
                    .padding(.bottom)
                Spacer()
            case .image(let name):
                Spacer()
                Image(name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .padding(.bottom)
                Spacer()
            case .regular:
                EmptyView()
            }
            
            VStack(spacing: type == .regular ? 8 : 2){
                Text(LocalizedStringKey(title))
                    .bold()
                    .multilineTextAlignment(.center)
                if subTitle != nil{
                    Text(LocalizedStringKey(subTitle ?? ""))
                        .font(.footnote)
                        .opacity(0.7)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .padding()
        .withFrame(type != .regular)
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(10)
    }
}

@available(iOS 13, *)
public struct AlertToastModifier: ViewModifier{
    
    @Binding var show: Bool
    var duration: Double = 2
    var alert: () -> AlertToast
    
    @ViewBuilder
    public func body(content: Content) -> some View {
        content
            .overlay(
                ZStack{
                    if show{
                        alert()
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                    withAnimation(.spring()){
                                        show = false
                                    }
                                }
                            }
                            .onTapGesture {
                                withAnimation(.spring()){
                                    show = false
                                }
                            }
                            .transition(AnyTransition.scale(scale: 0.8).combined(with: .opacity))
                    }
                }
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .edgesIgnoringSafeArea(.all)
                .animation(.spring())
            )
        
    }
}

@available(iOS 13, *)
public struct WithFrameModifier: ViewModifier{
    
    var withFrame: Bool
    
    var maxWidth: CGFloat = 150
    var maxHeight: CGFloat = 150
    
    @ViewBuilder
    public func body(content: Content) -> some View {
        if withFrame{
            content
                .frame(maxWidth: maxWidth, maxHeight: maxHeight, alignment: .center)
        }else{
            content
        }
    }
}

@available(iOS 13, *)
public extension View{
    
    /// Return some view w/o frame depends on the condition.
    /// This view modifier function is set by default to:
    /// - `maxWidth`: 150
    /// - `maxHeight`: 150
    func withFrame(_ withFrame: Bool) -> some View{
        modifier(WithFrameModifier(withFrame: withFrame))
    }
    
    /// Present `AlertToast`.
    /// - Parameters:
    ///   - show: Binding<Bool>
    ///   - alert: () -> AlertToast
    /// - Returns: `AlertToast`
    func alertDialog(show: Binding<Bool>, duration: Double = 2, alert: @escaping () -> AlertToast) -> some View{
        modifier(AlertToastModifier(show: show, duration: duration, alert: alert))
    }
}

@available(iOS 13, *)
public struct BlurView: UIViewRepresentable {
    public typealias UIViewType = UIVisualEffectView
    
    let style: UIBlurEffect.Style
    
    public init(style: UIBlurEffect.Style = .systemMaterial) {
        self.style = style
    }
    
    public func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: self.style))
    }
    
    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: self.style)
    }
}
