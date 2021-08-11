//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by Baris Karalar on 11.08.2021.
//

import Foundation

enum BKError: String, Error {
    case invalidUsername = "This username created an invalid request, please try again."
    case unableToComplete = "Unable to complete your request, check internet connection"
    case invalidResponse = "Invalid response from the server"
    case invalidData = "Data received from server is invalid"
    
    
}
