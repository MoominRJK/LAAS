//
//  UploadTask.swift
//  LAAS
//
//  Created by Sophie Lin on 10/11/22.
//

import Foundation

class UploadTask {
  var file: File
  var inProgress = false
  var task: URLSessionUploadTask?

    init(file: File) {
    self.file = file
  }
}
