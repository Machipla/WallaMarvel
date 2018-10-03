//
//  ComicOrderBy.swift
//  WallaMarvelAPI
//
//  Created by Mario Plaza on 3/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import Foundation

public enum ComicOrderBy: String{
    case ascendingByFOCDate         = "focDate"
    case ascendingByOnSaleDate      = "onsaleDate"
    case ascendingByTitle           = "title"
    case ascendingByIssueNumber     = "issueNumber"
    case ascendingByModified        = "modified"
    case descendingByFOCDate        = "-focDate"
    case descendingByOnSaleDate     = "-onsaleDate"
    case descendingByTitle          = "-title"
    case descendingByIssueNumber    = "-issueNumber"
    case descendingByModified       = "-modified"
}

