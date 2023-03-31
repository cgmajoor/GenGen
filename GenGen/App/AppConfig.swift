//
//  AppConfig.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 31/03/2023.
//

import UIKit

struct AppConfig {

    static func configure(_ application: UIApplication) {
        configureSecrets()
    }

    /**
     Get secrets from xcconfig file

     Make sure the Config file has some key value pair like this: API_KEY = XYZDefault

     - warning: Make sure you have added debug and release versions files to .gitignore.

     >
     1. Add Config.xcconfig file as a default dummy configuration file to Project that can be pushed to remote repository
     2. Add ConfigDebug and ConfigRelease versions which will be used locally
     3. Select Project -> Info -> Configurations -> Set to Config file
     4. Add to Project -> Info -> Add Custom iOS Target Property: with the name of the variable you use in the Config.
     -  EX: name: API_KEY, type: String, value: $(API_KEY)
     */
    private static func configureSecrets() {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY" as String) else {
            print("LOG: Couldn't find API_KEY")
            return
        }
        print("API_KEY: \(apiKey)")
    }
}
