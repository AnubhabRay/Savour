//
//  Others.swift
//  Savour
//
//  Created by FNSPL on 26/01/21.
//  Copyright © 2021 FNSPL. All rights reserved.
//

import Foundation

enum StatusDining {
    case notStarted
    case havingFood
    case completed
    
    var status : Int{
        switch self {
        case .notStarted:
            return 1
        case .havingFood:
            return 2
        case .completed:
            return 3
        default:
            return 4
        }
    }
    var words: String{
        switch self {
        case .notStarted:
            return "Not Started"
        case .havingFood:
            return "Dining"
        case .completed:
            return "Completed"
        }
    }
}

enum StatusAttendance {
    case notComing
    case notYetPresent
    case present
    
    var status : Int{
        switch self {
        case .notComing:
            return 1
        case .notYetPresent:
            return 2
        case .present:
            return 3
        default:
            return 4
        }
    }
    var words: String{
        switch self {
        case .notComing:
            return "Not Coming"
        case .notYetPresent:
            return "On the way"
        case .present:
            return "Present"
        }
    }
}

enum StatusReturn {
    case notReturning
    case stillHere
    case returned
    
    var status : Int{
        switch self {
        case .notReturning:
            return 1
        case .stillHere:
            return 2
        case .returned:
            return 3
        default:
            return 4
        }
    }
    var words: String{
        switch self {
        case .notReturning:
            return "Not Returning"
        case .stillHere:
            return "Still Here"
        case .returned:
            return "Returned"
        }
    }
}
