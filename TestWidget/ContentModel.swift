//
//  ContentModel.swift
//  LHQWidgetTestDemo
//
//  Created by Xhorse_iOS3 on 2021/1/8.
//

import Foundation
import WidgetKit

struct ContentModel : Codable {
    
    let title : String
    let iconImg : String
    
    let button1 : String
    let buttonUrl1 : URL
//
    let button2 : String
    let buttonUrl2 : URL
//
    let button3 : String
    let buttonUrl3 : URL
//
    let button4 : String
    let buttonUrl4 : URL
    
    var id: String {
        title
    }
    
    static var default1 = ContentModel(title: "WidgetDemo-default1",
                                       iconImg: "avatarImg",
                                       button1: "one-button1",
                                       buttonUrl1: URL(string: "widget://one-buttonUrl1")!,
                                       button2: "one-button2",
                                       buttonUrl2: URL(string: "widget://one-buttonUrl2")!,
                                       button3: "one-button3",
                                       buttonUrl3: URL(string: "widget://one-buttonUrl3")!,
                                       button4: "one-button4",
                                       buttonUrl4: URL(string: "widget://one-buttonUrl4")!
    )
    
    static var default2 = ContentModel(title: "WidgetDemo-default2",
                                       iconImg: "avatarImg",
                                       button1: "two-button1",
                                       buttonUrl1: URL(string: "widget://two-buttonUrl1")!,
                                       button2: "two-button2",
                                       buttonUrl2: URL(string: "widget://two-buttonUrl2")!,
                                       button3: "two-button3",
                                       buttonUrl3: URL(string: "widget://two-buttonUrl3")!,
                                       button4: "two-button4",
                                       buttonUrl4: URL(string: "widget://two-buttonUrl4")!
    )
    
    static var default3 = ContentModel(title: "WidgetDemo-default3",
                                       iconImg: "avatarImg",
                                       button1: "three-button1",
                                       buttonUrl1: URL(string: "widget://three-buttonUrl1")!,
                                       button2: "three-button2",
                                       buttonUrl2: URL(string: "widget://three-buttonUrl2")!,
                                       button3: "three-button3",
                                       buttonUrl3: URL(string: "widget://three-buttonUrl3")!,
                                       button4: "three-button4",
                                       buttonUrl4: URL(string: "widget://three-buttonUrl4")!
    )
    
    
//    https://pics2.baidu.com/feed/b151f8198618367ac926ec9d594b56d3b21ce587.jpeg?token=421a3a8765ee03e91f72ce2255374643&s=4BAC3A62FB9AFFB5C38548D20000A0A1
    
    
    static let availableDefaults = [default1, default2, default3]
  
    
}
