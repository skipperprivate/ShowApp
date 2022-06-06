import UIKit

class ProgressView: UIView {
    
    // MARK: - Public properties
    
    public var isAnimating: Bool = false {
        didSet {
            if isAnimating {
                animateStroke()
                animateRotation()
            } else {
                shapeLayer.removeFromSuperlayer()
                layer.removeAllAnimations()
            }
        }
    }
    
    // MARK: - Private properties
    
    private let colors: [UIColor]
    private let lineWidth: CGFloat
    
    private lazy var shapeLayer: ProgressShapeLayer = {
        return ProgressShapeLayer(strokeColor: colors.first!, lineWidth: lineWidth)
    }()
    
    // MARK: - Init
    
    init(frame: CGRect, colors: [UIColor], lineWidth: CGFloat) {
        self.colors = colors
        self.lineWidth = lineWidth
        
        super.init(frame: frame)
        
        self.backgroundColor = .clear
    }
    
    convenience init(colors: [UIColor], lineWidth: CGFloat) {
        self.init(frame: .zero, colors: colors, lineWidth: lineWidth)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    // MARK: - Override methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
        
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.width))
        shapeLayer.path = path.cgPath
    }
    
    // MARK: - Public methods
    
    public func animateStroke() {
        let startAnimation = StrokeAnimation(type: .start,
                                             beginTime: 0.25,
                                             fromValue: 0.0,
                                             toValue: 1.0,
                                             duration: 0.75)

        let endAnimation = StrokeAnimation(type: .end,
                                           fromValue: 0.0,
                                           toValue: 1.0,
                                           duration: 0.75)

        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1
        strokeAnimationGroup.repeatDuration = .infinity
        strokeAnimationGroup.animations = [startAnimation, endAnimation]
        
        shapeLayer.add(strokeAnimationGroup, forKey: nil)
        layer.addSublayer(shapeLayer)
    }
    
    public func animateRotation() {
        let rotationAnimation = RotationAnimation(direction: .z,
                                                  fromValue: 0,
                                                  toValue: CGFloat.pi * 2,
                                                  duration: 2,
                                                  repeatCount: .greatestFiniteMagnitude)
            
        layer.add(rotationAnimation, forKey: nil)
    }
    
}
