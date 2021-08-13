//
//  Follower.swift
//  GithubFollowers
//
//  Created by Baris Karalar on 9.08.2021.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
}
