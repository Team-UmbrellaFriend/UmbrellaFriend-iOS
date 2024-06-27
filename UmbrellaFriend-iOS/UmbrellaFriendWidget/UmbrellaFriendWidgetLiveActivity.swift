//
//  UmbrellaFriendWidgetLiveActivity.swift
//  UmbrellaFriendWidget
//
//  Created by 고아라 on 6/25/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct UmbrellaFriendWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct UmbrellaFriendWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: UmbrellaFriendWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension UmbrellaFriendWidgetAttributes {
    fileprivate static var preview: UmbrellaFriendWidgetAttributes {
        UmbrellaFriendWidgetAttributes(name: "World")
    }
}

extension UmbrellaFriendWidgetAttributes.ContentState {
    fileprivate static var smiley: UmbrellaFriendWidgetAttributes.ContentState {
        UmbrellaFriendWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: UmbrellaFriendWidgetAttributes.ContentState {
         UmbrellaFriendWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: UmbrellaFriendWidgetAttributes.preview) {
   UmbrellaFriendWidgetLiveActivity()
} contentStates: {
    UmbrellaFriendWidgetAttributes.ContentState.smiley
    UmbrellaFriendWidgetAttributes.ContentState.starEyes
}
