//
//  UploadAudio.swift
//  LAAS
//
//  Created by Sophie Lin on 10/12/22.
//

import UIKit
import AVFoundation
import AVKit

func myAudioUploadRequest(_ url:String, _ nameOfAudioForToSave:String, _ recording:Recording)
{
    
    let myUrl = URL(string: url)!
    var request = URLRequest(url: myUrl)
    request.httpMethod = "POST"
    
//    let fileUrl = URL(string: nameOfAudioForToSave)!

    let boundary = generateBoundaryString()
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
//        guard let fileUrl = Bundle.main.url(forResource: "audio", withExtension: "mp3") else { return }
    
    let audioData = recording.recordingData! as Data
  
    var body = Data()
    body = createBodyWithParameters(nil , "file", audioData, boundary, recording.name! + ".m4a")
    request.httpBody = body
        
    
    let task = URLSession.shared.dataTask(with: request as URLRequest) {
        (data, response, error) in
        do {
            if let data = data {
                let response = try JSONSerialization.jsonObject(with: data, options: [])
                print(response)
            }
            else {
                // Data is nil.
            }
        } catch let error as NSError {
            print("json error: \(error.localizedDescription)")
        }
    }
    task.resume()
}

func generateBoundaryString() -> String {
    return "Boundary-\(NSUUID().uuidString)"
}


func createBodyWithParameters(_ parameters: [String: String]?,_ filePathKey: String?,_ imageDataKey: Data,_ boundary: String, _ nameOfImageForToSave:String) -> Data {
    var body = Data()
    
    if parameters != nil {
        for (key, value) in parameters! {
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
    }
    
    let filename = nameOfImageForToSave
//    let mimetype = "image/jpeg"
    let mimetype = "audio/mpeg"
    
    body.appendString("--\(boundary)\r\n")
    body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
    
    
    body.appendString("Content-Type: \(mimetype)\r\n\r\n")
    body.append(imageDataKey)
    body.appendString("\r\n")
    body.appendString("--\(boundary)--\r\n")
    return body
}

extension Data {
    mutating func appendString(_ string: String) {
        let data = string.data(
            using: String.Encoding.utf8,
            allowLossyConversion: true)
        append(data!)
    }
}

