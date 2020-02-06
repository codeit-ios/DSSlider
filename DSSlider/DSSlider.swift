//
//  DSSlider.swift
//  DoubleSidedSlideToUnlock
//
//  Created by Konstantin Stolyarenko on 05.02.2020.
//  Copyright © 2020 SKS. All rights reserved.
//

import UIKit

// MARK: DSSliderPosition

enum DSSliderPosition {
  case left
  case rigth

  func getBoolValue() -> Bool {
    switch self {
    case .left:
      return false
    case .rigth:
      return true
    }
  }
}

// MARK: DSSliderDelegate

protocol DSSliderDelegate: class {
  func sliderDidFinishSliding(_ slider: DSSlider, at position: DSSliderPosition)
}

// MARK: RoundImageView

class RoundImageView: UIImageView {

  override func layoutSubviews() {
    super.layoutSubviews()

    let radius: CGFloat = self.bounds.size.width / 2.0
    self.layer.cornerRadius = radius
    self.isUserInteractionEnabled = true
    self.contentMode = .center
  }
}

// MARK: DSSlider

class DSSlider: UIView {

  // MARK: Public Properties

  public let textLabel = UILabel()
  public let sliderTextLabel = UILabel()
  public let thumnailImageView = RoundImageView()
  public let sliderHolderView = UIView()
  public let draggedView = UIView()
  public let view = UIView()

  public weak var delegate: DSSliderDelegate?

  public var sliderPosition: DSSliderPosition = .left
  public var animationVelocity: Double = 0.2

  public var sliderViewTopDistance: CGFloat = 0.0 {
    didSet {
      topSliderConstraint?.constant = sliderViewTopDistance
      layoutIfNeeded()
    }
  }

  public var thumbnailViewTopDistance: CGFloat = 0.0 {
    didSet {
      topThumbnailViewConstraint?.constant = thumbnailViewTopDistance
      thumbnailViewStartingDistance = thumbnailViewTopDistance
      layoutIfNeeded()
    }
  }

  public var thumbnailViewStartingDistance: CGFloat = 0.0 {
    didSet {
      leadingThumbnailViewConstraint?.constant = thumbnailViewStartingDistance
      trailingDraggedViewConstraint?.constant = thumbnailViewStartingDistance
      setNeedsLayout()
    }
  }

  public var textLabelLeadingDistance: CGFloat = 0 {
    didSet {
      leadingTextLabelConstraint?.constant = textLabelLeadingDistance
      setNeedsLayout()
    }
  }

  public var isEnabled:Bool = true {
    didSet {
      animationChangedEnabledBlock?(isEnabled)
    }
  }

  public var showSliderText:Bool = true {
    didSet {
      sliderTextLabel.isHidden = !showSliderText
    }
  }

  public var animationChangedEnabledBlock:((Bool) -> Void)?

  public var sliderCornerRadius: CGFloat = 30.0 {
    didSet {
      sliderHolderView.layer.cornerRadius = sliderCornerRadius
      draggedView.layer.cornerRadius = sliderCornerRadius
    }
  }

  public var sliderBackgroundColor: UIColor = UIColor.white {
    didSet {
      sliderHolderView.backgroundColor = sliderBackgroundColor
      sliderTextLabel.textColor = sliderBackgroundColor
    }
  }

  public var textColor:UIColor = UIColor.red {
    didSet {
      textLabel.textColor = textColor
    }
  }

  public var sliderTextColor:UIColor = UIColor.red {
    didSet {
      sliderTextLabel.textColor = sliderTextColor
    }
  }

  public var slidingColor: UIColor = UIColor.white {
    didSet {
      draggedView.backgroundColor = slidingColor
    }
  }

  public var thumbnailColor: UIColor = UIColor.red {
    didSet {
      thumnailImageView.backgroundColor = thumbnailColor
    }
  }

  public var textFont: UIFont = UIFont.systemFont(ofSize: 15.0) {
    didSet {
      textLabel.font = textFont
      sliderTextLabel.font = textFont
    }
  }

  // MARK: Private Properties

  private var leadingThumbnailViewConstraint: NSLayoutConstraint?
  private var leadingTextLabelConstraint: NSLayoutConstraint?
  private var topSliderConstraint: NSLayoutConstraint?
  private var topThumbnailViewConstraint: NSLayoutConstraint?
  private var trailingDraggedViewConstraint: NSLayoutConstraint?
  private var panGestureRecognizer: UIPanGestureRecognizer?

  private var xEndingPoint: CGFloat {
    get {
      let endPoint = self.view.frame.maxX - thumnailImageView.bounds.width - thumbnailViewStartingDistance
      return endPoint
    }
  }

  private var xStartPoint: CGFloat {
    get {
      return thumbnailViewStartingDistance
    }
  }

  // MARK: - View Lifecycle

  override public init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    setupView()
  }

  convenience public init(frame: CGRect, delegate: DSSliderDelegate? = nil) {
    self.init(frame: frame)
    self.delegate = delegate
  }

  // MARK: - Setup Methods

  private func setupView() {
    self.addSubview(view)

    setupViews()
    setupConstraints()
    addPanGesture()
    setupBaseStyle()
  }

  private func setupViews() {
    view.addSubview(thumnailImageView)
    view.addSubview(sliderHolderView)
    view.addSubview(draggedView)
    draggedView.addSubview(sliderTextLabel)
    sliderHolderView.addSubview(textLabel)
    view.bringSubviewToFront(thumnailImageView)
  }

  private func addPanGesture() {
    panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:)))
    panGestureRecognizer?.minimumNumberOfTouches = 1
    if let panGestureRecognizer = panGestureRecognizer {
      thumnailImageView.addGestureRecognizer(panGestureRecognizer)
    }
  }

  private func setupConstraints() {
    view.translatesAutoresizingMaskIntoConstraints = false
    thumnailImageView.translatesAutoresizingMaskIntoConstraints = false
    sliderHolderView.translatesAutoresizingMaskIntoConstraints = false
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    sliderTextLabel.translatesAutoresizingMaskIntoConstraints = false
    draggedView.translatesAutoresizingMaskIntoConstraints = false

    // Setup for view
    view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    // Setup for circle View
    leadingThumbnailViewConstraint = thumnailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    leadingThumbnailViewConstraint?.isActive = true
    topThumbnailViewConstraint = thumnailImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: thumbnailViewTopDistance)
    topThumbnailViewConstraint?.isActive = true
    thumnailImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    thumnailImageView.heightAnchor.constraint(equalTo: thumnailImageView.widthAnchor).isActive = true

    // Setup for slider holder view
    topSliderConstraint = sliderHolderView.topAnchor.constraint(equalTo: view.topAnchor, constant: sliderViewTopDistance)
    topSliderConstraint?.isActive = true
    sliderHolderView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    sliderHolderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    sliderHolderView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    // Setup for textLabel
    textLabel.topAnchor.constraint(equalTo: sliderHolderView.topAnchor).isActive = true
    textLabel.centerYAnchor.constraint(equalTo: sliderHolderView.centerYAnchor).isActive = true
    leadingTextLabelConstraint = textLabel.leadingAnchor.constraint(equalTo: sliderHolderView.leadingAnchor, constant: textLabelLeadingDistance)
    leadingTextLabelConstraint?.isActive = true
    textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat(-8)).isActive = true

    // Setup for sliderTextLabel
    sliderTextLabel.topAnchor.constraint(equalTo: textLabel.topAnchor).isActive = true
    sliderTextLabel.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor).isActive = true
    sliderTextLabel.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor).isActive = true
    sliderTextLabel.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor).isActive = true

    // Setup for Dragged View
    draggedView.leadingAnchor.constraint(equalTo: sliderHolderView.leadingAnchor).isActive = true
    draggedView.topAnchor.constraint(equalTo: sliderHolderView.topAnchor).isActive = true
    draggedView.centerYAnchor.constraint(equalTo: sliderHolderView.centerYAnchor).isActive = true
    trailingDraggedViewConstraint = draggedView.trailingAnchor.constraint(equalTo: thumnailImageView.trailingAnchor, constant: thumbnailViewStartingDistance)
    trailingDraggedViewConstraint?.isActive = true
  }

  private func setupBaseStyle() {
    thumnailImageView.backgroundColor = thumbnailColor

    textLabel.font = textFont
    textLabel.textColor = textColor
    textLabel.textAlignment = .center

    sliderTextLabel.font = textFont
    sliderTextLabel.textColor = sliderTextColor
    sliderTextLabel.textAlignment = .center
    sliderTextLabel.isHidden = !showSliderText

    sliderHolderView.backgroundColor = sliderBackgroundColor
    sliderHolderView.layer.cornerRadius = sliderCornerRadius
    draggedView.backgroundColor = slidingColor
    draggedView.layer.cornerRadius = sliderCornerRadius
    draggedView.clipsToBounds = true
    draggedView.layer.masksToBounds = true
  }

  // MARK: - Public Methods

  public func resetStateWithAnimation(_ animated: Bool) {
    updateThumbnail(withPosition: xStartPoint, andAnimation: animated)
    updateTextLabels(withPosition: 0)
    sliderPosition = .left
    layoutIfNeeded()
  }

  // MARK: - Private Methods

  private func isTapOnThumbnailViewWithPoint(_ point: CGPoint) -> Bool {
    return thumnailImageView.frame.contains(point)
  }

  private func updateThumbnail(withPosition position: CGFloat, andAnimation animation: Bool = false) {
    leadingThumbnailViewConstraint?.constant = position
    setNeedsLayout()
    if animation {
      UIView.animate(withDuration: animationVelocity) {
        self.view.layoutIfNeeded()
      }
    }
  }

  private func updateTextLabels(withPosition position: CGFloat) {
    let textAlpha = (xEndingPoint - position) / xEndingPoint
    let sliderTextAlpha = 1.0 - (xEndingPoint - position) / xEndingPoint
    textLabel.alpha = textAlpha
    sliderTextLabel.alpha = sliderTextAlpha
  }

  private func updateImageView(withAngle angle: CGFloat) {
    thumnailImageView.transform = CGAffineTransform(rotationAngle: angle)
  }

  @objc private func handlePanGesture(_ sender: UIPanGestureRecognizer) {
    guard isEnabled else { return }
    let translatedPoint = sender.translation(in: view).x
    switch sender.state {
    case .began:
      break
    case .changed:
      if translatedPoint > 0 {
        debugPrint("Changed - Right")
        guard sliderPosition == .left else {
          if translatedPoint >= xEndingPoint {
            updateThumbnail(withPosition: xEndingPoint)
          }
          return
        }
        if translatedPoint >= xEndingPoint {
          updateThumbnail(withPosition: xEndingPoint)
          return
        }
        updateThumbnail(withPosition: translatedPoint)
        updateTextLabels(withPosition: translatedPoint)
        let ratio = xEndingPoint/CGFloat.pi
        let angle = translatedPoint/ratio
        updateImageView(withAngle: angle)
      } else if translatedPoint <= 0 {
        debugPrint("Changed - Left")
        guard sliderPosition == .rigth else {
          if translatedPoint <= xStartPoint {
            updateThumbnail(withPosition: xStartPoint)
          }
          return
        }
        let reverseTranslatedPoint = xEndingPoint+translatedPoint
        if reverseTranslatedPoint <= xStartPoint {
          updateThumbnail(withPosition: xStartPoint)
          return
        }
        updateThumbnail(withPosition: reverseTranslatedPoint)
        updateTextLabels(withPosition: reverseTranslatedPoint)
        let ratio = xEndingPoint/CGFloat.pi
        let angle = reverseTranslatedPoint/ratio
        updateImageView(withAngle: angle)
      }
      break
    case .ended:
      if translatedPoint > 0 {
        debugPrint("Ended - Right")
        guard sliderPosition == .left else {
          return
        }

        if translatedPoint > xStartPoint && translatedPoint < xEndingPoint {
          updateThumbnail(withPosition: xStartPoint, andAnimation: true)
          updateTextLabels(withPosition: xStartPoint)
          updateImageView(withAngle: 0)
          sliderPosition = .left
        } else if translatedPoint >= xEndingPoint {
          updateThumbnail(withPosition: xEndingPoint, andAnimation: true)
          updateTextLabels(withPosition: xEndingPoint)
          updateImageView(withAngle: CGFloat.pi)
          sliderPosition = .rigth
          delegate?.sliderDidFinishSliding(self, at: .rigth)
        }
      } else if translatedPoint <= 0 {
        debugPrint("Ended - Left")
        guard sliderPosition == .rigth else {
          return
        }
        let reverseTranslatedPoint = xEndingPoint+translatedPoint
        if reverseTranslatedPoint > xStartPoint && reverseTranslatedPoint < xEndingPoint {
          updateThumbnail(withPosition: xEndingPoint, andAnimation: true)
          updateTextLabels(withPosition: xEndingPoint)
          updateImageView(withAngle: CGFloat.pi)
          sliderPosition = .rigth
        } else if reverseTranslatedPoint <= xStartPoint {
          updateThumbnail(withPosition: xStartPoint, andAnimation: true)
          updateTextLabels(withPosition: xStartPoint)
          updateImageView(withAngle: 0)
          sliderPosition = .left
          delegate?.sliderDidFinishSliding(self, at: .left)
        }
      }
      break
    default:
      break
    }
  }
}
