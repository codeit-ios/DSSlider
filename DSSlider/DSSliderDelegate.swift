//
//  DSSliderDelegate.swift
//  DoubleSidedSlideToUnlock
//
//  Created by Konstantin Stolyarenko on 06.02.2020.
//  Copyright © 2020 SKS. All rights reserved.
//

import Foundation

// MARK: DSSliderDelegate

protocol DSSliderDelegate: class {
  func sliderDidFinishSliding(_ slider: DSSlider, at position: DSSliderPosition)
}
