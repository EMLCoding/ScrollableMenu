//
//  Home.swift
//  ScrollableMenu
//
//  Created by Eduardo Martin Lorenzo on 20/6/22.
//

import SwiftUI

struct Home: View {
    @State var currentTab = ""
    @Namespace var animation
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack(spacing: 15) {
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.left")
                    }
                    
                    Text("McDonald's")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
                .foregroundColor(.primary)
                
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            ForEach(tabsItems) { tab in
                                VStack {
                                    Text(tab.tab)
                                        .foregroundColor(currentTab.replacingOccurrences(of: " SCROLL", with: "") == tab.id ? .black : .gray)
                                    
                                    if currentTab.replacingOccurrences(of: " SCROLL", with: "") == tab.id {
                                        Capsule()
                                            .fill(.black)
                                            .matchedGeometryEffect(id: "TAB", in: animation)
                                            .frame(height: 3)
                                            .padding(.horizontal, -10)
                                    } else {
                                        Capsule()
                                            .fill(.clear)
                                            .frame(height: 3)
                                            .padding(.horizontal, -10)
                                    }
                                }
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        currentTab = "\(tab.id) TAP"
                                        proxy.scrollTo(currentTab.replacingOccurrences(of: " TAP", with: ""), anchor: .topTrailing)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 30)
                    }
                    .onChange(of: currentTab) { _ in
                        if currentTab.contains(" SCROLL") {
                            proxy.scrollTo(currentTab.replacingOccurrences(of: " SCROLL", with: ""), anchor: .topTrailing)
                        }
                    }
                }
                .padding(.top)
            }
            .padding([.top])
            .background(scheme == .dark ? Color.black : Color.white)
            .overlay(
                Divider()
                    .padding(.horizontal, -15)
                , alignment: .bottom
            )
            
            ScrollView(.vertical, showsIndicators: false) {
                ScrollViewReader { proxy in
                    VStack(spacing: 15) {
                        ForEach(tabsItems) { tab in
                            MenuCardView(tab: tab, currentTab: $currentTab)
                                .padding(.top)
                        }
                    }
                    .padding([.horizontal, .bottom])
                    .onChange(of: currentTab) { newValue in
                        if currentTab.contains("TAP") {
                            withAnimation(.easeInOut) {
                                proxy.scrollTo(currentTab.replacingOccurrences(of: " TAP", with: ""), anchor: .topTrailing)
                            }
                        }
                    }
                }
            }
            .coordinateSpace(name: "SCROLL")
        }
        .onAppear {
            currentTab = tabsItems.first?.id ?? ""
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct MenuCardView: View {
    var tab: Tab
    @Binding var currentTab: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(tab.tab)
                .font(.title.bold())
                .padding(.vertical)
            
            ForEach(tab.foods) { food in
                HStack(spacing: 15) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(food.title)
                            .font(.title3.bold())
                        
                        Text(food.description)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text("Price: \(food.price)")
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Divider()
            }
        }
        .modifier(OffsetModifier(currentTab: $currentTab, tab: tab))
        .id(tab.id)
    }
}
