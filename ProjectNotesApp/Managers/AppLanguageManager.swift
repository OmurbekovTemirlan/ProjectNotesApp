//
//  AppLanguageManager.swift
//  ProjectNotesApp
//
//  Created by Apple on 29.3.2024.
//

import Foundation

enum LanguageType: String{
    case kg = "KG"
    case ru = "RUS"
    case usa = "USA"
}
class AppLanguageManager{
    static let shared = AppLanguageManager()
    
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
    
    func SetApplanguage(language: LanguageType){
        setCurrentLanguage(language: language)
        setCurrentBundlePath(languageCode: language.rawValue)
    }
}

extension String{
    func localized() -> String {
        let bundle = AppLanguageManager.shared.bundle
        return NSLocalizedString(self, tableName: "Localizable", bundle: bundle, value: "", comment: "")
    }
}
