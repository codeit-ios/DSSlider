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
    slider.thumbnailViewStartingDistance = 5
    slider.thumbnailViewTopDistance = 5
    slider.sliderCornerRadius = sliderContainer.frame.height / 2
    slider.thumnailImageView.image = UIImage(named: "arrow-icon")
    slider.textLabel.text = "SLIDE TO TURN ON!"
    slider.sliderTextLabel.text = "SLIDE TO TURN OFF!"
    slider.isDebugPrintEnabled = true
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
