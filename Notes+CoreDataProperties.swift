//
//  Notes+CoreDataProperties.swift
//  ProjectNotesApp
//
//  Created by Apple on 26.3.2024.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var date: Date?

}

extension Notes : Identifiable {

}
