//
//  ExcersizeTypeUtil.swift
//  PushUps Count
//
//  Created by mac on 2022/5/6.
//

import Foundation

class ExcersizeTypeUtil {
    let excersizes: [Excersize]
    
    init() {
        self.excersizes = [Excersize(code: "100", name: "Push-ups", image: "pushups", plusButton: [20, 30, 40, 50]),
                           Excersize(code: "101", name: "Sit-ups", image: "situps", plusButton: [50, 100, 150, 200, 300]),
                           Excersize(code: "102", name: "Skipping-rpoe", image: "skipping-rope", plusButton: [100, 300, 500, 700, 1000]),
                           Excersize(code: "103", name: "Squats", image: "squats", plusButton: [100, 300, 500, 700]),
        Excersize(code: "104", name: "Weight-lifting", image: "weightlifting", plusButton: [20, 30, 40, 50, 60])]
    }
    
    // MARK: Find img by excersize type code.
    func findImgByTypeCode(typeCode: String) -> String {
        var img: String = ""
        for idx in 0..<self.excersizes.count {
            if self.excersizes[idx].code == typeCode {
                img = self.excersizes[idx].image
                break
            }
        }
        return img
    }
    
}

struct Excersize: Identifiable {
    var id = UUID()
    var code: String
    var name: String
    var image: String
    var plusButton: [Int]
}
