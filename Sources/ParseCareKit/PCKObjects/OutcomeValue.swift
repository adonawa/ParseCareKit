//
//  OutcomeValues.swift
//  ParseCareKit
//
//  Created by Corey Baker on 1/15/20.
//  Copyright © 2020 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import ParseSwift
import CareKitStore


public class OutcomeValue: PCKObjectable {
    
    public internal(set) var uuid: UUID?
    
    public internal(set) var entityId: String?
    
    public internal(set) var logicalClock: Int?
    
    public internal(set) var schemaVersion: OCKSemanticVersion?
    
    public internal(set) var createdDate: Date?
    
    public internal(set) var updatedDate: Date?
    
    public internal(set) var deletedDate: Date?
    
    public var timezone: TimeZone?
    
    public var userInfo: [String : String]?
    
    public var groupIdentifier: String?
    
    public var tags: [String]?
    
    public var source: String?
    
    public var asset: String?
    
    public var notes: [Note]?
    
    public var remoteID: String?
    
    var encodingForParse: Bool = true
    
    public var objectId: String?
    
    public var createdAt: Date?
    
    public var updatedAt: Date?
    
    public var ACL: ParseACL?
    

    public var index:Int?
    public var kind:String?
    public var units:String?
    public var value: AnyCodable?
    //private var typeString: String?
    var type: OCKOutcomeValueType? /*{
        get {
            guard let type = typeString else {
                return nil
            }
            return OCKOutcomeValueType(rawValue: type)
        }
        set { typeString = newValue?.rawValue }
    }*/
/*
    var textValue: String?
    var binaryValue: Data?
    var booleanValue: Bool?
    var integerValue: Int?
    var doubleValue: Double?
    var dateValue: Date?

    var valueType: OCKOutcomeValueType? /*{
        get {
            guard let valueType = type else {
                return nil
            }
            switch valueType {
            case .integer:
                guard let integerValue = integerValue else {
                    return nil
                }
                return Int(integerValue)
            case .double: return doubleValue
            case .boolean: return booleanValue
            case .text: return textValue
            case .binary: return binaryValue
            case .date: return dateValue
            }
        }

        set {
            switch newValue {
            case let int as Int:
                reset()
                integerValue = Int64(int)
                type = .integer

            case let double as Double:
                reset()
                doubleValue = double
                type = .double

            case let bool as Bool:
                reset()
                booleanValue = bool
                type = .boolean

            case let text as String:
                reset()
                textValue = text
                type = .text

            case let binary as Data:
                reset()
                binaryValue = binary
                type = .binary

            case let date as Date:
                reset()
                dateValue = date
                type = .date

            default: fatalError("Unexpected type!")
            }
        }
    }*/

    private func reset() {
        textValue = nil
        binaryValue = nil
        booleanValue = nil
        integerValue = nil
        doubleValue = nil
        dateValue = nil
        index = nil
    }*/

    init() {
    }
    
    public convenience init?(careKitEntity:OCKOutcomeValue) {
        self.init()
        do {
            _ = try Self.copyCareKit(careKitEntity)
        } catch {
            return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case uuid, schemaVersion, createdDate, updatedDate, timezone, userInfo, groupIdentifier, tags, source, asset, remoteID, notes, logicalClock
        case index, kind, units, value, type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        kind = try container.decodeIfPresent(String.self, forKey: .kind)
        index = try container.decodeIfPresent(Int.self, forKey: .index)
        units = try container.decodeIfPresent(String.self, forKey: .units)
        type = try container.decodeIfPresent(OCKOutcomeValueType.self, forKey: .type)
        value = try container.decode(AnyCodable.self, forKey: .value)
        
        uuid = try container.decodeIfPresent(UUID.self, forKey: .uuid)
        createdDate = try container.decodeIfPresent(Date.self, forKey: .createdDate)
        updatedDate = try container.decodeIfPresent(Date.self, forKey: .updatedDate)
        schemaVersion = try container.decodeIfPresent(OCKSemanticVersion.self, forKey: .schemaVersion)
        groupIdentifier = try container.decodeIfPresent(String.self, forKey: .groupIdentifier)
        tags = try container.decodeIfPresent([String].self, forKey: .tags)
        remoteID = try container.decodeIfPresent(String.self, forKey: .remoteID)
        source = try container.decodeIfPresent(String.self, forKey: .source)
        userInfo = try container.decodeIfPresent([String: String].self, forKey: .userInfo)
        timezone = try container.decode(TimeZone.self, forKey: .timezone)
    }
    /*
    public required init(from decoder: Decoder) throws {
        return
    }
    
    enum CodingKeys: String, CodingKey {
        case index, kind, units, textValue, binaryValue
        case booleanValue, integerValue, doubleValue, dateValue
    }
    
    public func encode(to encoder: Encoder) throws {
        //try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(index, forKey: .index)
        try container.encode(kind, forKey: .kind)
        try container.encode(units, forKey: .units)
        try container.encode(textValue, forKey: .textValue)
        try container.encode(binaryValue, forKey: .binaryValue)
        try container.encode(booleanValue, forKey: .booleanValue)
        try container.encode(integerValue, forKey: .integerValue)
        try container.encode(doubleValue, forKey: .doubleValue)
        try container.encode(dateValue, forKey: .dateValue)
    }*/
    
    public static func copyValues(from other: OutcomeValue, to here: OutcomeValue) throws -> Self {
        var here = here
        here.copyCommonValues(from: other)
        here.index = other.index
        here.kind = other.kind
        here.units = other.units
        here.type = other.type
        /*here.textValue = other.textValue
        here.binaryValue = other.binaryValue
        here.booleanValue = other.booleanValue
        here.integerValue = other.integerValue
        here.doubleValue = other.doubleValue
        here.dateValue = other.dateValue*/
       
        guard let copied = here as? Self else {
            throw ParseCareKitError.cantCastToNeededClassType
        }
        return copied
    }
    
    open class func copyCareKit(_ outcomeValue: OCKOutcomeValue) throws -> OutcomeValue {
        let encoded = try JSONEncoder().encode(outcomeValue)
        let decoded = try JSONDecoder().decode(Self.self, from: encoded)
        
        return decoded
        /*
        if let uuid = OutcomeValue.getUUIDFromCareKitEntity(outcomeValue) {
            self.uuid = uuid
        }else{
            print("Warning in \(className).copyCareKit(). Entity missing uuid: \(outcomeValue)")
        }
        
        if let schemaVersion = OutcomeValue.getSchemaVersionFromCareKitEntity(outcomeValue){
            self.schemaVersion = schemaVersion
        }else{
            print("Warning in \(className).copyCareKit(). Entity missing schemaVersion: \(outcomeValue)")
        }
        self.timezone = outcomeValue.timezone.abbreviation()!
        self.userInfo = outcomeValue.userInfo
        self.kind = outcomeValue.kind
        
        if let index = outcomeValue.index{
            self.index = NSNumber(value: index)
        }else{
            //Can't set nil because of ObjC, make sure to guard against negative index when retreiving
            self.index = nil
        }
        
        self.typeString = outcomeValue.type.rawValue
        self.value = outcomeValue.value
        self.units = outcomeValue.units
        
        self.groupIdentifier = outcomeValue.groupIdentifier
        self.tags = outcomeValue.tags
        self.source = outcomeValue.source
        self.updatedDate = outcomeValue.updatedDate
        self.remoteID = outcomeValue.remoteID
        self.createdDate = outcomeValue.createdDate
        self.notes = outcomeValue.notes?.compactMap{Note(careKitEntity: $0)}
        
        
        return self*/
    }
    
    open func convertToCareKit(fromCloud:Bool=true) throws -> OCKOutcomeValue {
        
        let encoded = try JSONEncoder().encode(self)
        return try JSONDecoder().decode(OCKOutcomeValue.self, from: encoded)
        
        /*
        //If super passes, can safely force unwrap entityId, timeZone
        guard self.canConvertToCareKit() == true,
              let value = self.value else {
            return nil
        }
        
        var outcomeValue:OCKOutcomeValue!
        if fromCloud{
            guard let decodedOutcomeValue = decodedCareKitObject(value, units: units)else{
                print("Error in \(className). Couldn't decode entity \(self)")
                return nil
            }
            outcomeValue = decodedOutcomeValue
        }else{
            //Create bare Entity and replace contents with Parse contents
            outcomeValue = OCKOutcomeValue(value, units: self.units)
        }
        outcomeValue.remoteID = self.remoteID
        outcomeValue.index = self.index as? Int
        outcomeValue.kind = self.kind
        outcomeValue.groupIdentifier = self.groupIdentifier
        outcomeValue.tags = self.tags
        outcomeValue.source = self.source
        outcomeValue.notes = self.notes?.compactMap{$0.convertToCareKit()}
        outcomeValue.remoteID = self.remoteID
        outcomeValue.userInfo = self.userInfo
        if let timeZone = TimeZone(abbreviation: self.timezone!){
            outcomeValue.timezone = timeZone
        }
        return outcomeValue*/
    }
    
    func stamp(_ clock: Int){
        self.logicalClock = clock
        self.notes?.forEach{
            $0.logicalClock = self.logicalClock
        }
    }
    
    open class func replaceWithCloudVersion(_ local:inout [OutcomeValue], cloud:[OutcomeValue]){
        for (index,value) in local.enumerated(){
            guard let cloudNote = cloud.first(where: {$0.uuid == value.uuid}) else{
                continue
            }
            local[index] = cloudNote
        }
    }
}

extension OutcomeValue {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(kind, forKey: .kind)
        try container.encodeIfPresent(units, forKey: .units)
        try container.encodeIfPresent(index, forKey: .index)
        try container.encodeIfPresent(value, forKey: .value)
        try self.encodeObjectable(to: encoder)
    }
}
