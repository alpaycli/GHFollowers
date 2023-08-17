////
////  TestView.swift
////  GHFollowers
////
////  Created by Alpay Calalli on 17.08.23.
////
//
//import SwiftUI
//
//struct TestView: View {
//    @State private var verticalOffset: CGFloat = 0
//    @State private var contentOffset: CGFloat = 0
//    var body: some View {
//        VStack {
//            Text("\(verticalOffset)")
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(.purple)
//
//            OffsettableScrollView(showIndicators: false) { point in
//                verticalOffset = point.y
//            } content: {
//                ForEach(0..<30) { item in
//                    Text("\(item)")
//                        .padding()
//                }
//            }
//        }
//    }
//}
//
//struct OffsettableScrollView<T: View> : View {
//    let axes: Axis.Set
//    let showIndicators: Bool
//    let offsetChanged: (CGPoint) -> Void
//    let content: T
//
//    init(axes: Axis.Set = .vertical,
//         showIndicators: Bool = true,
//         offsetChanged: @escaping (CGPoint) -> Void = { _ in },
//         @ViewBuilder content: () -> T
//    ) {
//        self.axes = axes
//        self.showIndicators = showIndicators
//        self.offsetChanged = offsetChanged
//        self.content = content()
//    }
//
//    var body: some View {
//        ScrollView(axes, showsIndicators: showIndicators) {
//            GeometryReader { proxy in
//                Color.clear.preference(key: ScrollOffsetPreferenceKey.self , value: proxy.frame(in: .named("ScrollView")).origin)
//            }
//            .frame(width: 0, height: 0)
//            content
//        }
//        .coordinateSpace(name: "ScrollView")
//        .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetChanged)
//    }
//}
//
//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//    }
//}
