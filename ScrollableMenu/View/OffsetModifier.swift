//
//  OffsetModifier.swift
//  ScrollableMenu
//
//  Created by Eduardo Martin Lorenzo on 20/6/22.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    @Binding var currentTab: String
    
    var tab: Tab
    
    func body(content: Content) -> some View {
        content.overlay(
            GeometryReader { proxy in
                Color.clear
                    .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")))
            }
        )
        .onPreferenceChange(OffsetKey.self) { proxy in
            let offset = proxy.minY
            
            withAnimation(.easeInOut) {
                currentTab = (offset < 20 && -offset < (proxy.midX / 2) && currentTab != ("\(tab.id) SCROLL")) ? tab.id : currentTab
            }
        }
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
