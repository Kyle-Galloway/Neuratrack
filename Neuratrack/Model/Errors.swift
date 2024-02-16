//
//  Errors.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 05/02/2024.
//

import Foundation

enum DataErrors: Error
{
    case ImportError
    case ExportError
}

enum EventKitImporterErrors: Error
{
    case FailedToReadStartTrackingDateFromUserDefaults
    case FailedToWriteStartTrackingDateToUserDefaults
    case FailedToAccessCalendar
    
    case FailedToCreateMedicationObject
}
