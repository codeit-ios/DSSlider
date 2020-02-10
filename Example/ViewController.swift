//
//  ViewController.swift
//  DoubleSidedSlideToUnlock
//
//  Created by Konstantin Stolyarenko on 05.02.2020.
//  Copyright © 2020 SKS. All rights reserved.
//

import UIKit

// MARK: ViewController

class ViewController: UIViewController {

  // MARK: IBOutlets

  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var descriptionLabel: UILabel!
  @IBOutlet private weak var sliderContainer: UIView!

  // MARK: - Private Properties

  private var isEmergencySOSActive = false

  // MARK: - ViewController Lifecycle Methods

  override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupSettings()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    setupSlider()
    updateLabel()
  }

  // MARK: - Setup Methods

  private func setupUI() {
    titleLabel.text = "Emergency SOS"
    view.backgroundColor = UIColor.dsSliderRedColor
  }

  private func setupSettings() {}

  private func setupSlider() {
    let slider = DSSlider(frame: sliderContainer.frame, delegate: self)

    slider.isDoubleSideEnabled = true
    slider.isImageViewRotating = true
    slider.isTextChangeAnimating = true
    slider.isDebugPrintEnabled = false
    slider.isShowSliderText = true
    slider.isEnabled = true

    slider.sliderAnimationVelocity = 0.2
    slider.sliderViewTopDistance = 0.0
    slider.sliderImageViewTopDistance = 5
    slider.sliderImageViewStartingDistance = 5
    slider.sliderTextLabelLeadingDistance = 0
    slider.sliderCornerRadius = sliderContainer.frame.height / 2

    slider.sliderBackgroundColor = UIColor.white
    slider.sliderBackgroundViewTextColor = UIColor.dsSliderRedColor
    slider.sliderDraggedViewTextColor = UIColor.dsSliderRedColor
    slider.sliderDraggedViewBackgroundColor = UIColor.white
    slider.sliderImageViewBackgroundColor = UIColor.dsSliderRedColor

    slider.sliderTextFont = UIFont.systemFont(ofSize: 15.0)

    slider.sliderImageView.image = UIImage(named: "arrow-icon")
    slider.sliderBackgroundViewTextLabel.text = "SLIDE TO TURN ON!"
    slider.sliderDraggedViewTextLabel.text = "SLIDE TO TURN OFF!"

    view.addSubview(slider)
  }

  private func updateLabel() {
    descriptionLabel.text = isEmergencySOSActive ? "Emergency SOS in Progress!" : "Are you certain you want to activate an Emergency SOS?"
  }
}

// MARK: DSSliderDelegate

extension ViewController: DSSliderDelegate {

  func sliderDidFinishSliding(_ slider: DSSlider, at position: DSSliderPosition) {
    isEmergencySOSActive = position.getBoolValue()
    updateLabel()
  }
}
