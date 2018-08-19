//
//  PurveyorService.swift
//  MovileHack
//
//  Created by Movile Hack on 19/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import Foundation

final class PurveyorService {
    class func getPurveyor(purveyorId: String, completion: @escaping (Purveyor?) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(1000) / 1000.0) {
            if purveyorId == "500" {
                completion(Purveyor(id: "500", name: "ACME Ltda."))
            } else if purveyorId == "501" {
                completion(Purveyor(id: "501", name: "Rocket"))
            } else if purveyorId == "502" {
                completion(Purveyor(id: "502", name: "Caffeine"))
            }
        }
    }
}
