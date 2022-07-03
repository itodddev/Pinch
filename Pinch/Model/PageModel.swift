//
//  PageModel.swift
//  Pinch
//
//  Created by Todd James on 7/3/22.
//

import Foundation

struct Page: Identifiable {
  let id: Int
  let imageName: String
}

extension Page {
  var thumbnailName: String {
    return "thumb-\(imageName)"
  }
}
