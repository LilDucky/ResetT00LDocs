//
//  Command.swift
//  xDripG5
//
//  Created by Paul Dickens on 22/03/2018.
//  Copyright © 2018 LoopKit Authors. All rights reserved.
//

import Foundation


public enum Command: RawRepresentable {
    public typealias RawValue = [String: Any]

    case startSensor(at: Date)
    case stopSensor(at: Date)
    case resetTransmitter

    public init?(rawValue: RawValue) {
        guard let action = rawValue["action"] as? Action.RawValue else {
            return nil
        }

        let date = rawValue["date"] as? Date

        switch Action(rawValue: action) {
        case .startSensor?:
            guard let date = date else {
                return nil
            }
            self = .startSensor(at: date)
        case .stopSensor?:
            guard let date = date else {
                return nil
            }
            self = .stopSensor(at: date)
        case .resetTransmitter?:
            self = .resetTransmitter
        case .none:
            return nil
        }
    }

    private enum Action: Int {
        case startSensor, stopSensor, resetTransmitter
    }

    public var rawValue: RawValue {
        switch self {
        case .startSensor(let date):
            return [
                "action": Action.startSensor.rawValue,
                "date": date
            ]
        case .stopSensor(let date):
            return [
                "action": Action.stopSensor.rawValue,
                "date": date
            ]
        case .resetTransmitter:
            return [
                "action": Action.resetTransmitter.rawValue
            ]
        }
    }
}
