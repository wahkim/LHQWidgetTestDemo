//
//  WidgetManager.swift
//  LHQWidgetTestDemo
//
//  Created by Xhorse_iOS3 on 2021/1/8.
//

import Foundation
import WidgetKit
import UIKit

//声明 14以上的系统才可用此 api
@available(iOS 14.0, *)
//定义 oc 方法
@objcMembers final class WidgetManager : NSObject {
    class func reloadAllWidgets() {
       // arm64架构真机以及模拟器可以使用
        #if arch(arm64) || arch(i386) || arch(x86_64)
            WidgetCenter.shared.reloadAllTimelines()
        #endif
    }
    
    class func reloadWidgetWithKind(kind : String) {
       // arm64架构真机以及模拟器可以使用
        #if arch(arm64) || arch(i386) || arch(x86_64)
        WidgetCenter.shared.reloadTimelines(ofKind: kind)
        #endif
    }
}

//MARK: 适配
let widgetTargetWidth: CGFloat = 329
let iPhoneHeight = UIScreen.main.bounds.size.height

func AdaptLen(_ length: CGFloat) -> CGFloat {
  if iPhoneHeight == 812 {
    return length
  }
  else if iPhoneHeight == 896 {
    return (length * 360 / widgetTargetWidth)
  }
  else if iPhoneHeight == 736 {
    return (length * 348 / widgetTargetWidth)
  }
  else if iPhoneHeight == 667 {
    return (length * 321 / widgetTargetWidth)
  }
  else if iPhoneHeight == 568 {
    return (length * 292 / widgetTargetWidth)
  }
  return length
}



//MARK:HTTP

struct Response {
    let id : String
    var bgImage : UIImage? = UIImage(named: "widgetBg")
}

struct RequsetHandler {
    // https://api.uomg.com/api/rand.avatar?sort=%E7%94%B7&format=json
    static func request(completion: @escaping (Result<Response, Error>) -> Void) {

        let url = URL(string: "https://api.uomg.com/api/rand.avatar?sort=%E7%94%B7&format=json")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
           let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
           let imgurl = json["imgurl"]!
//            let imgurl : String = "https://pics4.baidu.com/feed/cb8065380cd7912338dfcffdf336b685b2b78002.jpeg?token=f967255eb271408ee48ff09a30140659&s=B90BA056487498DE001A8C870300F08B"

           var image : UIImage = UIImage(named: "widgetBg")!
           print(json["imgurl"] as Any)
            if let imageData = try? Data(contentsOf: (URL.init(string: imgurl as! String)!)) {
                image = UIImage(data: imageData)!
           }
           completion(.success(Response(id: "", bgImage: image)))
       }
       task.resume()
    }
}
