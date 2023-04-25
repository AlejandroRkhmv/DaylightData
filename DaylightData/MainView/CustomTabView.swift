//
//  CustomTabView.swift
//  DaylightData
//
//  Created by Александр Рахимов on 01.04.2023.
//

import SwiftUI

// MARK: - shadow
struct LightView: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX / 2, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX * 0.75, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}

// MARK: - Model
struct TabItem: Identifiable, Equatable {
    var id = UUID()
    let title: String
    let iconSystemName: String
}

// MARK: - create fill of tabbar
struct TabItemPreferenceKey: PreferenceKey {
    
    static var defaultValue: [TabItem] = []
    
    static func reduce(value: inout [TabItem], nextValue: () -> [TabItem]) {
        value += nextValue()
    }
}

// MARK: - Modifier
struct TabItemModifier: ViewModifier {
    let tabBarItem: TabItem
    
    func body(content: Content) -> some View {
        content
            .preference(key: TabItemPreferenceKey.self, value: [tabBarItem])
    }
}

// MARK: - extension for View
extension View {
    func tabItem(_ label: () -> TabItem) -> some View {
        modifier(TabItemModifier(tabBarItem: label()))
    }
}

// MARK: - CustomTabView
struct CustomTabView<Content: View>: View {
    
    private var content: Content
    @State private var tabItems: [TabItem] = []
    @Namespace private var tabBarItem
    @Binding var selected: Int
    @Binding var isAppear: Bool
    
    private var tabsView: some View {
        HStack(alignment: .center, spacing: 50) {
           
                
            ForEach(Array(tabItems.enumerated()), id: \.offset) { (index, element) in
                VStack {
                    Image(systemName: element.iconSystemName)
                    Text(element.title)
                }
                .frame(width: 70)
                .font(.system(size: 20))
                .foregroundColor(selected == index ? Color(ColorEnum.darkShadow.rawValue) : Color(ColorEnum.text.rawValue))
                .shadow(color: selected == index ? .white : Color.clear, radius: 10, x: 0, y: 0)
                .background(content: {
                    if selected == index {
                        ZStack(alignment: .top) {
                            LightView()
                                .fill(LinearGradient(colors: [Color(ColorEnum.blik.rawValue).opacity(0.3), Color(ColorEnum.lightShadow.rawValue)], startPoint: .top, endPoint: .bottom))
                                .frame(width: 100, height: 90)
                                .shadow(color: Color(ColorEnum.lightShadow.rawValue), radius: 10, x: 0, y: 10)
                            Rectangle()
                                .fill(Color(ColorEnum.blik.rawValue))
                                .frame(width: 100 / 2, height: 5)
                        }
                        .matchedGeometryEffect(id: "tabBarItem", in: tabBarItem)
                    }
                })
                .onTapGesture {
                    withAnimation(.linear(duration: 1)) {
                        selected = index
                        if selected == 1 {
                            isAppear = true
                        } else {
                            isAppear = false
                        }
                    }
                }
            }
        }
    }
    
    init(selected: Binding<Int>, isAppear: Binding<Bool>, @ViewBuilder content: () -> Content) {
        _selected = selected
        _isAppear = isAppear
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content
            VStack {
                Spacer()
                HStack(spacing: 20) {
                    tabsView
                }
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .padding(.vertical, 10)
                .background {
                    Color(ColorEnum.lightShadow.rawValue).opacity(0.5)
                }
                .shadow(radius: 10)
            }
        }
        .onPreferenceChange(TabItemPreferenceKey.self) { tab in
            self.tabItems = tab
        }
    }
}
