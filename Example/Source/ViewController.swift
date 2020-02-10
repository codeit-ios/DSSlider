//
//  ViewController.swift
//
//  Copyright (c) 2020 Konstantin Stolyarenko
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import DSSlider

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
    view.backgroundColor = DSSlider.dsSliderRedColor()
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
    slider.sliderBackgroundViewTextColor = DSSlider.dsSliderRedColor()
    slider.sliderDraggedViewTextColor = DSSlider.dsSliderRedColor()
    slider.sliderDraggedViewBackgroundColor = UIColor.white
    slider.sliderImageViewBackgroundColor = DSSlider.dsSliderRedColor()

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
