//
//  ListView.swift
//  LHQWidgetTestDemo
//
//  Created by Xhorse_iOS3 on 2021/1/8.
//

import Foundation
import SwiftUI

struct ListView : View {
    
    var content : String
    
    @available(iOS 13.0.0, *)
    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
            Text("\(content)")
                .foregroundColor(.orange)
                .font(.title)
            /// 不支持列表项 我丢
//            List {
////                CustomRow(name: "linhuaqin1")
////                CustomRow(name: "linhuaqin2")
////                CustomRow(name: "linhuaqin3")
//                Text("1")
//                Text("2")
//            }
            
            
        })
        
    }
}
