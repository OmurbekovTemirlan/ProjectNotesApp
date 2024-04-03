//
//  AppLanguageManager.swift
//  ProjectNotesApp
//
//  Created by Apple on 29.3.2024.
//

import Foundation
import UIKit

enum LanguageType: String{
    case kg = "ky-KG"
    case ru = "ru"
    case en = "en"
}

class AppLanguageManager{
    
    static let shared = AppLanguageManager()
    
    private let selectedLanguageKey = "selectedLanguage"
    
    private var currentLanguage: LanguageType?
    
    private var currentBundle: Bundle = Bundle.main
    
    var bundle: Bundle {
        return currentBundle
    }
    
   private func setCurrentLanguage(language: LanguageType){
        currentLanguage = language
    }
    
    private func setCurrentBundlePath(languageCode: String ){
        guard let bundle = Bundle.main.path(forResource: languageCode, ofType: "lproj"), let langBundle = Bundle(path: bundle) else {
            currentBundle = bundle
            return
        }
        currentBundle = langBundle
    }
    
    func setApplanguage(language: LanguageType){
        setCurrentLanguage(language: language)
        setCurrentBundlePath(languageCode: language.rawValue)
    }
    private func savedSelectedLanguage(_ language: String){
        UserDefaults.standard.setValue(language, forKey: selectedLanguageKey)
    }
    func getSelectedanguage() -> LanguageType? {
        guard let languageString = UserDefaults.standard.string(forKey: selectedLanguageKey), let languageType = LanguageType(rawValue: languageString) else {
            return nil
        }
        return languageType
    }
}
                         
extension String{
    func localized() -> String {
        let bundle = AppLanguageManager.shared.bundle
        return NSLocalizedString(self, tableName: "Localizable", bundle: bundle, value: "", comment: "")
    }
}
