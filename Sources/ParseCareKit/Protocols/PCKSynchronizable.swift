//
//  PCKSynchronizable.swift
//  ParseCareKit
//
//  Created by Corey Baker on 5/29/20.
//  Copyright © 2020 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import ParseSwift
import CareKitStore

/**
 Protocol that defines the properties and methods for parse carekit entities that are synchronized using a knowledge vector.
 */
public protocol PCKSynchronizable {
    func addToCloud(_ usingClock:Bool, overwriteRemote: Bool, completion: @escaping(Bool,Error?) -> Void)
    func updateCloud(_ usingClock:Bool, overwriteRemote: Bool, completion: @escaping(Bool,Error?) -> Void)
    func deleteFromCloud(_ usingClock:Bool, overwriteRemote: Bool, completion: @escaping(Bool,Error?) -> Void)
    func new(with careKitEntity: OCKEntity) throws -> PCKSynchronizable
    func pullRevisions(_ localClock: Int, cloudVector: OCKRevisionRecord.KnowledgeVector, mergeRevision: @escaping (OCKRevisionRecord) -> Void)
    func pushRevision(_ overwriteRemote: Bool, cloudClock: Int, completion: @escaping (Error?) -> Void)
}
