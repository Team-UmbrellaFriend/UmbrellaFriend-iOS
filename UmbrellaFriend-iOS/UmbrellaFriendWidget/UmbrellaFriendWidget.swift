//
//  UmbrellaFriendWidget.swift
//  UmbrellaFriendWidget
//
//  Created by 고아라 on 6/25/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> RainyEntry {
        RainyEntry(date: Date(), rainPercent: 0)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (RainyEntry) -> ()) {
        let entry = RainyEntry(date: Date(), rainPercent: 0)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [RainyEntry] = []
        
        let refreshHours = [2, 5, 8, 11, 14, 17, 20, 23]
        
        let currentDate = Date()
        let calendar = Calendar.current
        
        let currentHour = calendar.component(.hour, from: currentDate)
        let lastRefreshHour = refreshHours.last { $0 <= currentHour } ?? refreshHours.last!
        
        var lastRefreshDate = calendar.date(bySettingHour: lastRefreshHour, minute: 0, second: 0, of: currentDate)!
        if lastRefreshDate > currentDate {
            lastRefreshDate = calendar.date(byAdding: .day, value: -1, to: lastRefreshDate)!
        }
        
        for hour in refreshHours {
            let entryDate = calendar.date(bySettingHour: hour, minute: 10, second: 0, of: lastRefreshDate)!
            if entryDate >= currentDate {
                let entry = RainyEntry(date: entryDate, rainPercent: 0)
                entries.append(entry)
            }
        }
        
        let lastEntry = RainyEntry(date: lastRefreshDate, rainPercent: 0)
        entries.append(lastEntry)
        entries.sort { $0.date < $1.date }
        print("🍎🍎🍎🍎")
        print(entries)
        print("🍎🍎🍎🍎")
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct RainyEntry: TimelineEntry {
    let date: Date
    let rainPercent: Int
}

struct UmbrellaFriendWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 4){
                Text(formatDate(entry.date))
                    .umbrellaWidgetFont(.widgetTitle)
                    .foregroundStyle(.umbrellaWhite)
                
                HStack(
                    alignment: .bottom,
                    spacing: 0){
                        Text(UserDefaults.groupShared.string(forKey: "RainPercent") ?? "0000")
                            .umbrellaWidgetFont(.widgetNubmer)
                            .foregroundStyle(.umbrellaWhite)
                            .padding(.bottom, 5)
                        
                        Text("%")
                            .umbrellaWidgetFont(.widgetPercent)
                            .foregroundStyle(.umbrellaWhite)
                    }
                    .frame(height: 45)
                
            }
            .padding(.top, 16)
            .padding(.leading, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        
        HStack(
            alignment: .bottom,
            spacing: 0){
                Text("청파동")
                    .umbrellaWidgetFont(.widgetPlace)
                    .foregroundStyle(.umbrellaWhite)
                    .padding(.bottom, 16)
                
                Spacer()
                
                Image(.graphicPercentUmbrella)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .padding(.leading, 16)
            .frame(maxWidth: .infinity, maxHeight: 67, alignment: .bottom)
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 dd일"
        return dateFormatter.string(from: date)
    }
}

struct UmbrellaFriendWidgetPreview: PreviewProvider {
    static var previews: some View {
        UmbrellaFriendWidgetEntryView(entry: RainyEntry(date: Date(), rainPercent: 0))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

struct UmbrellaFriendWidget: Widget {
    let kind: String = "UmbrellaFriendWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                UmbrellaFriendWidgetEntryView(entry: entry)
                    .containerBackground(Color(UIColor.mainBlue), for: .widget)
            } else {
                UmbrellaFriendWidgetEntryView(entry: entry)
                    .padding()
                    .background(Color(UIColor.mainBlue))
            }
        }
        .configurationDisplayName("강수 확률")
        .description("오늘 청파동의 강수 확률을 확인합니다.")
        .contentMarginsDisabled()
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    UmbrellaFriendWidget()
} timeline: {
    RainyEntry(date: Date(), rainPercent: 333)
}
