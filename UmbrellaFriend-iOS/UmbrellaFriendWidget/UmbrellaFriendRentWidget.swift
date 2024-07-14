//
//  UmbrellaFriendRentWidget.swift
//  UmbrellaFriendWidgetExtension
//
//  Created by 고아라 on 7/5/24.
//

import WidgetKit
import SwiftUI

struct RentEntry: TimelineEntry {
    let date: Date
    let rentDto: RentWidgetDto
    
    static func rentEntryInitial() -> RentEntry {
        return RentEntry(date: Date(), rentDto: RentWidgetDto(isRent: false, isOverdue: false, returnDay: 0))
    }
    
    static func rentDtoInitial() -> RentWidgetDto {
        return RentWidgetDto(isRent: false, isOverdue: false, returnDay: 0)
    }
}

struct RentProvider: TimelineProvider {
    func placeholder(in context: Context) -> RentEntry {
        RentEntry.rentEntryInitial()
    }
    
    func getSnapshot(in context: Context, completion: @escaping (RentEntry) -> ()) {
        let entry = RentEntry(date: Date(), rentDto: self.loadRentData())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
        let entry = RentEntry(date: currentDate, rentDto: self.loadRentData())
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
        completion(timeline)
    }
    
    func loadRentData() -> RentWidgetDto {
        if let data = UserDefaults.groupShared.data(forKey: "rentData") {
            let decoder = JSONDecoder()
            do {
                let rentDto = try decoder.decode(RentWidgetDto.self, from: data)
                return rentDto
            } catch {
                print("Failed to decode RentWidgetDto: \(error)")
            }
        }
        return RentEntry.rentDtoInitial()
    }
}

struct UmbrellaFriendRentWidgetEntryView : View {
    var entry: RentProvider.Entry
    
    var body: some View {
        ZStack (alignment: .topLeading){
            VStack(
                alignment: .leading,
                spacing: 2){
                    if entry.rentDto.isOverdue {
                        Text("우산 반납")
                            .umbrellaWidgetFont(.widgetRent)
                            .foregroundStyle(Color(UIColor(.widgetDarkOrange)))
                        Text("D+\(entry.rentDto.returnDay)")
                            .umbrellaWidgetFont(.widgetRent)
                            .foregroundStyle(Color(UIColor(.widgetDarkOrange)))
                    } else {
                        if entry.rentDto.isRent {
                            Text("우산 반납")
                                .umbrellaWidgetFont(.widgetRent)
                                .foregroundStyle(Color(UIColor(.widgetDarkOrange)))
                            Text("D-\(entry.rentDto.returnDay)")
                                .umbrellaWidgetFont(.widgetRent)
                                .foregroundStyle(Color(UIColor(.darkOrange)))
                        } else {
                            Text("우산 대여")
                                .umbrellaWidgetFont(.widgetRent)
                                .foregroundStyle(Color(UIColor(.widgetDarkBlue)))
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
            
            ZStack {
                if entry.rentDto.isOverdue {
                    Image(.widgetNoReturn)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 87, height: 113, alignment: .bottomTrailing)
                } else {
                    if entry.rentDto.isRent {
                        Image(.widgetReturn)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 87, height: 113, alignment: .bottomTrailing)
                    } else {
                        Image(.widgetBorrow)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 87, height: 106, alignment: .bottomTrailing)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(.trailing, 16)
        }
        .padding(.top, 16)
        .padding(.leading, 16)
    }
}

struct UmbrellaFriendRentWidget: Widget {
    let kind: String = "UmbrellaFriendRentWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: RentProvider()) { entry in
            if #available(iOS 17.0, *) {
                UmbrellaFriendRentWidgetEntryView(entry: entry)
                    .containerBackground(backgroundColorBasedOnDto(entry.rentDto), for: .widget)
            } else {
                UmbrellaFriendRentWidgetEntryView(entry: entry)
                    .padding()
                    .background(backgroundColorBasedOnDto(entry.rentDto))
            }
        }
        .configurationDisplayName("대여 및 반납")
        .description("우산을 바로 대여 및 반납할 수 있습니다.")
        .contentMarginsDisabled()
        .supportedFamilies([.systemSmall])
    }
    
    private func backgroundColorBasedOnDto(_ rentDto: RentWidgetDto) -> Color {
        if !rentDto.isRent && !rentDto.isOverdue {
            return Color(UIColor.widgetLightBlue)
        } else {
            return Color(UIColor.widgetLightOrange)
        }
    }
}
