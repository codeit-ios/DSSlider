//
//  DSSliderPosition.swift
//  DoubleSidedSlideToUnlock
//
//  Created by Konstantin Stolyarenko on 06.02.2020.
//  Copyright © 2020 SKS. All rights reserved.
//

import Foundation

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
