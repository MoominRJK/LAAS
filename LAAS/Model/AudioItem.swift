//
//  AudioItem.swift
//  LAAS
//
//  Created by Sophie Lin 
//

import Foundation

import SwiftUI

struct AudioItem: Identifiable, Codable {
    var id = UUID()
    var seq: String
    var name: String
    var recordFilePath: URL?
}
