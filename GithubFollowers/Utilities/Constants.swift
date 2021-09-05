//
//  Constants.swift
//  GithubFollowers
//
//  Created by Baris Karalar on 21.08.2021.
//

import UIKit

struct Constants {
    enum SFSymbols {
        static let location = "mappin.and.ellipse"
        static let repos = "folder"
        static let gists = "text.alignleft"
        static let followers = "heart"
        static let following = "person.2"
    }
    
    enum Images {
        static let bkLogo = UIImage(named: "gh-logo")
        static let placeHolder = UIImage(named: "avatar-placeholder")
        static let emptyStateLogo = UIImage(named: "empty-state-logo")
        
        static let location = UIImage(systemName: Constants.SFSymbols.location)
        static let repos = UIImage(systemName: Constants.SFSymbols.repos)
        static let gists = UIImage(systemName: Constants.SFSymbols.gists)
        static let followers = UIImage(systemName: Constants.SFSymbols.followers)
        static let following = UIImage(systemName: Constants.SFSymbols.following)
        
    }
    
    
    enum ScreenSize {
        static let width        = UIScreen.main.bounds.size.width
        static let height       = UIScreen.main.bounds.size.height
        static let maxLength    = max(ScreenSize.width, ScreenSize.height)
        static let minLength    = min(ScreenSize.width, ScreenSize.height)
    }
    
    enum DeviceTypes {
        static let idiom                    = UIDevice.current.userInterfaceIdiom
        static let nativeScale              = UIScreen.main.nativeScale
        static let scale                    = UIScreen.main.scale
        
        static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
        static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
        static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
        static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
        static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
        static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
        static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
        static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0
        
        static func isiPhoneXAspectRatio() -> Bool {
            return isiPhoneX || isiPhoneXsMaxAndXr
        }
    }
    
}
