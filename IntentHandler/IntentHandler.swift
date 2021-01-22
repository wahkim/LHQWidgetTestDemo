//
//  IntentHandler.swift
//  IntentHandler
//
//  Created by Xhorse_iOS3 on 2021/1/20.
//

import Intents

class IntentHandler: INExtension, DynamicSelectionIntentHandling {
    func provideCustomDataOptionsCollection(for intent: DynamicSelectionIntent, with completion: @escaping (INObjectCollection<ContentData>?, Error?) -> Void) {
        let list : [ContentData] = ContentModel.availableDefaults.map { (item) -> ContentData in
            let content = ContentData (
                            identifier: item.id,
                            display: item.title
                           )
            return content
        }

        let collection = INObjectCollection(items: list)
        completion(collection, nil)
    }
    

    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
