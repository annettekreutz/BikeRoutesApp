//
//  DateUtil.swift
//  BikeHistorie
//
//  Created by Team_iOS on 01.06.17.
//  Copyright © 2017 Team_iOS. All rights reserved.
//

import UIKit

extension DateFormatter {
    static let standard: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        return dateFormatter
    }()
}

