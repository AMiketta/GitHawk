//
//  GithubAPIDateFormatter.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

private let dateFormatter = ISO8601DateFormatter()
func GithubAPIDateFormatter() -> ISO8601DateFormatter {
    // TODO: REVISE (Should be static)
    // https://developer.github.com/v3/#schema
    return dateFormatter
}
