import SwiftUI

@available(iOS 13, macOS 11, *)
fileprivate struct AnimatedCheckmark: View {
    
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

@available(iOS 13, macOS 11, *)
fileprivate struct AnimatedXmark: View {
    
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

@available(iOS 13, macOS 11, *)
public struct AlertToast: View{
    
    public enum AlertType: Equatable{
        case complete(Color)
        case error(Color)
        case systemImage(String, Color)
        case image(String)
        case loading
        case regular
    }
    
    var type: AlertType
    var title: String?
    var subTitle: String?
    var titleFont: Font?
    var subTitleFont: Font?
    var boldTitle: Bool?
    
    public init(type: AlertType,
                title: String? = nil,
                subTitle: String? = nil,
                titleFont: Font? = .body,
                subTitleFont: Font? = .footnote,
                boldTitle: Bool? = true){
        
        self.type = type
        self.title = title
        self.subTitle = subTitle
        self.titleFont = titleFont
        self.subTitleFont = subTitleFont
        self.boldTitle = boldTitle
    }
    
    public var loadingIndicator: some View{
        #if os(macOS)
        return ProgressIndicator()
        #else
        return ActivityIndicator()
        #endif
    }
    
    public var alert: some View{
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
            case .loading:
                loadingIndicator
            case .regular:
                EmptyView()
            }
            
            VStack(spacing: type == .regular ? 8 : 2){
                if title != nil{
                    if boldTitle ?? true{
                        Text(LocalizedStringKey(title ?? ""))
                            .font(titleFont)
                            .bold()
                            .multilineTextAlignment(.center)
                    }else{
                        Text(LocalizedStringKey(title ?? ""))
                            .font(titleFont)
                            .multilineTextAlignment(.center)
                    }
                }
                if subTitle != nil{
                    Text(LocalizedStringKey(subTitle ?? ""))
                        .font(subTitleFont)
                        .opacity(0.7)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
    
    public var body: some View{
        
        #if os(macOS)
        return alert
            .padding()
            .withFrame(type != .regular)
            .background(BlurView(material: .hudWindow, blendingMode: .withinWindow))
            .cornerRadius(10)
        #else
        return alert
            .padding()
            .withFrame(type != .regular && type != .loading)
            .background(BlurView(style: .systemUltraThinMaterial))
            .cornerRadius(10)
        #endif
        
    }
}

@available(iOS 13, macOS 11, *)
public struct AlertToastModifier: ViewModifier{
    
    @Binding var isPresenting: Bool
    var duration: Double = 2
    var tapToDismiss: Bool = true
    var alert: () -> AlertToast
    var completion: ((Bool) -> ())? = nil
    
    @ViewBuilder
    public func body(content: Content) -> some View {
        content
            .overlay(
                ZStack{
                    if isPresenting{
                        alert()
                            .onAppear {
                                if duration > 0{
                                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                        withAnimation(.spring()){
                                            isPresenting = false
                                        }
                                    }
                                }
                            }
                            .onTapGesture {
                                if tapToDismiss{
                                    withAnimation(.spring()){
                                        isPresenting = false
                                    }
                                }
                            }
                            .onDisappear(perform: {
                                completion?(true)
                            })
                            .transition(AnyTransition.scale(scale: 0.8).combined(with: .opacity))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .edgesIgnoringSafeArea(.all)
                .animation(.spring())
            )
        
    }
}

@available(iOS 13, macOS 11, *)
public struct WithFrameModifier: ViewModifier{
    
    var withFrame: Bool
    
    var maxWidth: CGFloat = 175
    var maxHeight: CGFloat = 175
    
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

@available(iOS 13, macOS 11, *)
public extension View{
    
    /// Return some view w/o frame depends on the condition.
    /// This view modifier function is set by default to:
    /// - `maxWidth`: 175
    /// - `maxHeight`: 175
    func withFrame(_ withFrame: Bool) -> some View{
        modifier(WithFrameModifier(withFrame: withFrame))
    }
    
    /// Present `AlertToast`.
    /// - Parameters:
    ///   - show: Binding<Bool>
    ///   - alert: () -> AlertToast
    /// - Returns: `AlertToast`
    func presentAlert(isPresenting: Binding<Bool>, duration: Double = 2, tapToDismiss: Bool = true, alert: @escaping () -> AlertToast, completion: ((Bool) -> ())? = nil) -> some View{
        modifier(AlertToastModifier(isPresenting: isPresenting, duration: duration, tapToDismiss: tapToDismiss, alert: alert, completion: completion))
    }
}
