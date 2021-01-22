//
//  TestWidget.swift
//  TestWidget
//
//  Created by Xhorse_iOS3 on 2021/1/6.
//

import WidgetKit
import SwiftUI
import Intents


struct Provider: IntentTimelineProvider {
    
    public typealias Entry = SimpleEntry
    
    typealias Intent = DynamicSelectionIntent
    
    let defaultRes = Response(id: "", bgImage: UIImage(named: "widgetBg"))
    // 占位视图，是一个标准的 SwiftUI View，当第一次展示或者发生错误时都会展示该 View。
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), contentModel: .default1, titleStr: "111", res: defaultRes)
    }

    // 编辑屏幕在左上角选择添加Widget、第一次展示时会调用该方法
    func getSnapshot(for configuration: DynamicSelectionIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        // 取数据
        let ud = UserDefaults(suiteName: "group.LHQ.LHQWidgetDemo")
        var title : String = ud?.value(forKey: "titleKey") as! String
        if title.count == 0 {
            title = "Snapshot"
        }
       
        let entry = SimpleEntry(date: Date(), contentModel: .default1, titleStr: title, res: defaultRes)
        completion(entry)
    }

    // 进行数据的预处理，转化成Entry
    // 最后一定要调用 completion，进而刷新Widget
    func getTimeline(for configuration: DynamicSelectionIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let selectedData = DynamicConfig(for: configuration)
        // 取数据
        let ud = UserDefaults(suiteName: "group.LHQ.LHQWidgetDemo")
        var title : String = ud?.value(forKey: "titleKey") as! String
        let randomNumber:Int = Int(arc4random() % 100) + 1
        title.append(String(randomNumber))
        print("title = \(title)")
        if title.count == 0 {
            title = "Timeline"
        }
//        let entryDate = Calendar.current.date(byAdding: .minute, value: 2, to: Date())!
        RequsetHandler.request { (response) in
            var res : Response
            if case .success(let result) = response {
                res = result
            } else {
                res = Response(id: "1", bgImage: UIImage.init())
            }
            
            let entry = SimpleEntry(date: Date(), contentModel: selectedData, titleStr: title, res: res)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            
            completion(timeline)
        }
        
        // 刷新时机 .never（不刷新），.atEnd（Entry 显示完毕之后自动刷新） 或 .after(date)（到达某个特定时间后自动刷新）
        // 1.
//        let entry = SimpleEntry(date: Date(), configuration: configuration,contentModel: .defaultData, titleStr: title)
//        let timeline = Timeline(entries: [entry], policy: .atEnd)
        
        // 2.
//        let entry = SimpleEntry(date: Date(), configuration: configuration, contentModel: selectedData, titleStr: title)
//        let date = Calendar.current.date(byAdding: .minute, value: 1, to: Date()) ?? Date()
//        let timeline = Timeline(entries: [entry], policy: .after(date))
        
        // 3. [每秒刷新一次 60*60 .section]、 [每分钟刷新一次 60*5 准备5小时的数据 .minute]]
//        var entries: [SimpleEntry] = []
//        let currentDate = Date()
//        for hourOffset in 0...60*5 {
//            let randomNumber:Int = Int(arc4random() % 100) + 1
//            if hourOffset == 0 {
//                title = "Timeline".appending(title)
//            } else {
//                title = String(randomNumber)
//            }
//            print("title = \(title)")
//            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, contentModel: selectedData, titleStr: title)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)

    }
//
    func DynamicConfig(for configuration: DynamicSelectionIntent) -> ContentModel {
        switch configuration.customType {
        case .default1:
            return .default1
        case .default2:
            return .default2
        case .default3:
            return .default3
        default:
            return .default1
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    var contentModel : ContentModel
    var titleStr: String
    var res : Response
}

struct TestWidgetEntryView : View {
    
    @Environment(\.widgetFamily) var family : WidgetFamily
    
    var entry: Provider.Entry

    
    var body: some View {
        
//        Text(entry.contentModel.title)
        switch family {
        case .systemSmall:
            // systemSmall这个类型只容许一个点击
            ZStack(alignment: .center, content: {
                Image(uiImage: entry.res.bgImage!)
                    .resizable()
                HStack(alignment: .center, spacing:5, content: {
                    Image(entry.contentModel.iconImg)
                        .resizable() /// 图片设置大小要先设置resizable，否则不生效
                        .scaledToFill()
                        .clipShape(Circle(), style: FillStyle())
                        .frame(width: 50, height: 50, alignment: .center)
                    VStack(alignment: .center, spacing: 10, content: {
                        Text(entry.contentModel.button1)
                            .frame(width: 100, height: 30, alignment: .center)
                            .foregroundColor(.red)
                            .background(Color.orange)
                            .font(.system(size: 14))
//                            .widgetURL(URL(string: "widget://dianwo1"))
                        
                        Text(entry.contentModel.button2)
                            .frame(width: 100, height: 30, alignment: .center)
                            .foregroundColor(.red)
                            .background(Color.orange)
                            .font(.system(size: 14))
//                            .widgetURL(URL(string: "widget://dianwo2"))

                    }).widgetURL(URL(string: "widget://VStack"))

                })
            })
        case .systemMedium:
            ZStack(alignment: .center, content: {
                Image(uiImage: entry.res.bgImage!)
                    .resizable()
                HStack(alignment: .center, spacing: AdaptLen(30), content: {
                    Image(entry.contentModel.iconImg)
                        .resizable() /// 图片设置大小要先设置resizable，否则不生效
                        .scaledToFill()
                        .clipShape(Circle(), style: FillStyle())
                        .frame(width: AdaptLen(50), height: AdaptLen(50), alignment: .center)
                    VStack(alignment: .center, spacing: AdaptLen(10), content: {
                        HStack(alignment: .center, spacing: AdaptLen(10), content: {
                            Link(destination: entry.contentModel.buttonUrl1, label: {
                                Button(entry.contentModel.button1) {}
                                    .frame(width: AdaptLen(100), height: AdaptLen(40), alignment: .center)
                                    .foregroundColor(.white)
                                    .background(Color.orange)
                            })
                            Link(destination: entry.contentModel.buttonUrl2, label: {
                                Button(entry.contentModel.button2) {}
                                    .frame(width: AdaptLen(100), height: AdaptLen(40), alignment: .center)
                                    .foregroundColor(.white)
                                    .background(Color.orange)
                            })
                        })
                        HStack(alignment: .center, spacing: AdaptLen(10), content: {
                            Link(destination: entry.contentModel.buttonUrl3, label: {
                                Button(entry.contentModel.button3) {}
                                    .frame(width: AdaptLen(100), height: AdaptLen(40), alignment: .center)
                                    .foregroundColor(.white)
                                    .background(Color.orange)
                            })
                            Link(destination: entry.contentModel.buttonUrl4, label: {
                                Button(entry.contentModel.button4) {}
                                    .frame(width: AdaptLen(100), height: AdaptLen(40), alignment: .center)
                                    .foregroundColor(.white)
                                    .background(Color.orange)
                            })
                        })

                    })
                })
            })
        case .systemLarge:
            ZStack(alignment: .center, content: {
                Image(uiImage: entry.res.bgImage!)
                    .frame(width: AdaptLen(100), height: AdaptLen(100), alignment: .center)
                VStack(alignment: .center, spacing: AdaptLen(30), content: {
                    ListView(content: entry.titleStr)
                    HStack(alignment: .center, spacing: AdaptLen(30), content: {
                        Image(entry.contentModel.iconImg)
                            .resizable() /// 图片设置大小要先设置resizable，否则不生效
                            .scaledToFill()
                            .clipShape(Circle(), style: FillStyle())
                            .frame(width: AdaptLen(50), height: AdaptLen(50), alignment: .center)
                        VStack(alignment: .center, spacing: AdaptLen(10), content: {
                            HStack(alignment: .center, spacing: AdaptLen(10), content: {
                                Link(destination: entry.contentModel.buttonUrl1, label: {
                                    Button(entry.contentModel.button1) {}
                                        .frame(width: AdaptLen(100), height: AdaptLen(40), alignment: .center)
                                        .foregroundColor(.white)
                                        .background(Color.orange)
                                })
                                Link(destination: entry.contentModel.buttonUrl2, label: {
                                    Button(entry.contentModel.button2) {}
                                        .frame(width: AdaptLen(100), height: AdaptLen(40), alignment: .center)
                                        .foregroundColor(.white)
                                        .background(Color.orange)
                                })
                            })
                            HStack(alignment: .center, spacing: AdaptLen(10), content: {
                                Link(destination: entry.contentModel.buttonUrl3, label: {
                                    Button(entry.contentModel.button3) {}
                                        .frame(width: AdaptLen(100), height: AdaptLen(40), alignment: .center)
                                        .foregroundColor(.white)
                                        .background(Color.orange)
                                })
                                Link(destination: entry.contentModel.buttonUrl4, label: {
                                    Button(entry.contentModel.button4) {}
                                        .frame(width: AdaptLen(100), height: AdaptLen(40), alignment: .center)
                                        .foregroundColor(.white)
                                        .background(Color.orange)
                                })
                            })

                        })
                    })
                })



            })
        default:
            ZStack(alignment: .center, content: {
                Image(uiImage: entry.res.bgImage!)
                    .frame(width: AdaptLen(100), height: AdaptLen(100), alignment: .center)

            })
        }
    }
}

//@main
struct TestWidget: Widget {
    let kind: String = "TestWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: DynamicSelectionIntent.self,
            provider: Provider()
        ) { entry in
            TestWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("这是小组件的demo")
        .supportedFamilies([.systemSmall,.systemMedium,.systemLarge])
    }
}

struct AnotherWidget: Widget {
    let kind: String = "AnotherWidget TestWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: DynamicSelectionIntent.self,
            provider: Provider()
        ) { entry in
            AnotherWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My AnotherWidget Widget")
        .description("这是小组件的AnotherWidget demo")
        .supportedFamilies([.systemSmall,.systemMedium,.systemLarge])
    }
}

struct AnotherWidgetEntryView : View {
    
    var entry: Provider.Entry

    
    var body: some View {
        Text("another EntryView")
    }
}


struct TestWidget_Previews: PreviewProvider {
    static var previews: some View {
        let defaultRes = Response(id: "", bgImage: UIImage(named: "widgetBg"))
        Group {
            TestWidgetEntryView(entry: SimpleEntry(date: Date(), contentModel: .default1,titleStr: "Preview", res: defaultRes))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            AnotherWidgetEntryView(entry: SimpleEntry(date: Date(), contentModel: .default1,titleStr: "Preview", res: defaultRes))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
        
    }
}

@main
struct Widgets : WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        TestWidget()
        AnotherWidget()
    }
}


