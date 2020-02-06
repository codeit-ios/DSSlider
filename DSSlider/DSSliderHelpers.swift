//
//  DSSliderHelpers.swift
//  DoubleSidedSlideToUnlock
//
//  Created by Konstantin Stolyarenko on 06.02.2020.
//  Copyright © 2020 SKS. All rights reserved.
//

import UIKit

// MARK: RoundImageView

class DSRoundImageView: UIImageView {

  override func layoutSubviews() {
    super.layoutSubviews()

    layer.cornerRadius = bounds.size.width / 2.0
    isUserInteractionEnabled = true
    contentMode = .center
  }
}

extension UIColor {
  static let dsSliderRedColor = UIColor(red: 0.92, green: 0.31, blue: 0.27, alpha: 1.0)
}

extension DSSlider {

  func dsSliderPrint(_ string: String) {
    guard isDebugPrintEnabled else { return }
    debugPrint("DSSlider: \(string)")
  }
}
