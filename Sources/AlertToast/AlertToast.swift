import SwiftUI

@available(iOS 13, macOS 11, *)
fileprivate struct AnimatedCheckmark: View {
    
    var color: Color = .black
    
    var size: Int = 50
    
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
    
    var size: Int = 50
    
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
    
    public enum DisplayMode: Equatable{
        case alert, hud
    }
    
    public enum AlertType: Equatable{
        case complete(Color)
        case error(Color)
        case systemImage(String, Color)
        case image(String)
        case loading
        case regular
    }
    
    var displayMode: DisplayMode
    var type: AlertType
    var title: String?
    var subTitle: String?
    var titleFont: Font?
    var subTitleFont: Font?
    var boldTitle: Bool?
    
    public init(displayMode: DisplayMode = .alert,
                type: AlertType,
                title: String? = nil,
                subTitle: String? = nil,
                titleFont: Font? = .body,
                subTitleFont: Font? = .footnote,
                boldTitle: Bool? = true){
        
        self.displayMode = displayMode
        self.type = type
        self.title = title
        self.subTitle = subTitle
        self.titleFont = titleFont
        self.subTitleFont = subTitleFont
        self.boldTitle = boldTitle
    }
    
    //HUD Toast
    public var hud: some View{
        VStack{
            HStack(spacing: 16){
                switch type{
                case .complete(let color):
                    Image(systemName: "checkmark")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 20, maxHeight: 20, alignment: .center)
                        .foregroundColor(color)
                case .error(let color):
                    Image(systemName: "xmark")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 20, maxHeight: 20, alignment: .center)
                        .foregroundColor(color)
                case .systemImage(let name, let color):
                    Image(systemName: name)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 20, maxHeight: 20, alignment: .center)
                        .foregroundColor(color)
                case .image(let name):
                    Image(name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 20, maxHeight: 20, alignment: .center)
                case .loading:
                    ActivityIndicator()
                case .regular:
                    EmptyView()
                }
                
                if title != nil || subTitle != nil{
                    VStack(alignment: type == .regular ? .center : .leading, spacing: 2){
                        if title != nil{
                            Text(LocalizedStringKey(title ?? ""))
                                .font(titleFont)
                                .isBold(boldTitle)
                                .multilineTextAlignment(.center)
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
            .padding(.horizontal, 24)
            .padding(.vertical, 8)
            .alertBackground()
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.gray.opacity(0.2), lineWidth: 1))
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 6)
            .compositingGroup()
            
            Spacer()
        }
        .padding(.top)
    }
    
    //Alert Toast
    public var alert: some View{
        VStack{
            switch type{
            case .complete(let color):
                Spacer()
                AnimatedCheckmark(color: color)
                Spacer()
            case .error(let color):
                Spacer()
                AnimatedXmark(color: color)
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
                ActivityIndicator()
            case .regular:
                EmptyView()
            }
            
            VStack(spacing: type == .regular ? 8 : 2){
                if title != nil{
                    Text(LocalizedStringKey(title ?? ""))
                        .font(titleFont)
                        .isBold(boldTitle)
                        .multilineTextAlignment(.center)
                }
                if subTitle != nil{
                    Text(LocalizedStringKey(subTitle ?? ""))
                        .font(subTitleFont)
                        .opacity(0.7)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .padding()
        .withFrame(type != .regular && type != .loading)
        .alertBackground()
        .cornerRadius(10)
    }
    
    //Main presentation
    public var body: some View{
        switch displayMode{
        case .alert:
            alert
        case .hud:
            hud
        }
    }
}

@available(iOS 13, macOS 11, *)
public struct AlertToastModifier: ViewModifier{
    
    @Binding var isPresenting: Bool
    @State var duration: Double = 2
    @State var tapToDismiss: Bool = true
    var alert: () -> AlertToast
    var completion: ((Bool) -> ())? = nil
    
    @State private var hostRect: CGRect = .zero
    @State private var alertRect: CGRect = .zero
    
    private var screen: CGRect {
        #if os(iOS)
        return UIScreen.main.bounds
        #else
        return NSScreen.main?.frame ?? .zero
        #endif
    }
    
    private var offset: CGFloat{
        #if os(iOS)
        return -hostRect.midY + alertRect.height - (screen.height * 0.01)
        #else
        return (-hostRect.midY + screen.midY) + alertRect.height
        #endif
    }
    
    @ViewBuilder
    public func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader{ geo -> AnyView in
                    let rect = geo.frame(in: .global)
                    
                    if rect.integral != hostRect.integral{
                        DispatchQueue.main.async {
                            self.hostRect = rect
                        }
                    }
                    
                    return AnyView(EmptyView())
                }
                .overlay(ZStack{
                    if isPresenting{
                        
                        switch alert().displayMode{
                        case .alert:
                            alert()
                                .onAppear {
                                    
                                    if alert().type == .loading{
                                        duration = 0
                                        tapToDismiss = false
                                    }
                                    
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
                        case .hud:
                            alert()
                                .overlay(
                                    GeometryReader{ geo -> AnyView in
                                        let rect = geo.frame(in: .global)
                                        
                                        if rect.integral != alertRect.integral{
                                            
                                            DispatchQueue.main.async {
                                            
                                            self.alertRect = rect
                                            }
                                        }
                                        return AnyView(EmptyView())
                                    }
                                )
                                .onAppear {
                                    
                                    if alert().type == .loading{
                                        duration = 0
                                        tapToDismiss = false
                                    }
                                    
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
                                .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: alert().displayMode == .alert ? .infinity : -hostRect.midY / 2, alignment: .center)
                .offset(x: 0, y: alert().displayMode == .alert ? 0 : offset)
                .edgesIgnoringSafeArea(alert().displayMode == .alert ? .all : .bottom)
                .animation(.spring()))
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
    fileprivate func withFrame(_ withFrame: Bool) -> some View{
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
    
    #if os(macOS)
    fileprivate func alertBackground() -> some View{
        background(BlurView(material: .hudWindow, blendingMode: .withinWindow))
    }
    #else
    fileprivate func alertBackground() -> some View{
        background(BlurView(style: .systemUltraThinMaterial))
    }
    #endif
}

@available(iOS 13, macOS 11, *)
fileprivate extension Text{
    func isBold(_ isBold: Bool? = true) -> Text{
        if isBold ?? true{
            return self.bold()
        }else{
            return self
        }
    }
}
