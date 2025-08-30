//
//  AudioMedia.swift
//  LAAS
//
//  Created by Sophie Lin on 10/12/22.
//

import Foundation
struct AudioMedia {
let key: String
let audioURL : URL
let mimeType: String

init?(audioWithURL url: URL, forKey key: String) {
    self.key = key
    self.mimeType = "audio/m4a"
    self.audioURL = url
  }
}
