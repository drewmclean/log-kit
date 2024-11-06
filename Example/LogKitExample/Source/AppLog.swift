//
//  AppLogManager.swift
//  LogKitExample
//
//  Created by Andrew McLean on 12/8/23.
//

import Foundation
import LogKit

public struct AppLog {
    public static var services = Logger(category: "Services")
    public static var view = Logger(category: "View")
}
