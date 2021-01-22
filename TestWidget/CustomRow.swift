//
//  CustomRow.swift
//  LHQWidgetTestDemo
//
//  Created by Xhorse_iOS3 on 2021/1/8.
//

import Foundation
import SwiftUI

struct CustomRow : View {
    
    var name : String
    
    @available(iOS 13.0.0, *)
    var body: some View {
        Text("name = \(name)")
    }
}
