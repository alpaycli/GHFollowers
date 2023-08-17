////
////  TestView.swift
////  GHFollowers
////
////  Created by Alpay Calalli on 17.08.23.
////
//
//import SwiftUI
//
//struct DetectScrollPosition: View {
//    @State private var scrollPosition: CGPoint = .zero
//    let columns = [
//        GridItem(.adaptive(minimum: 120))
//    ]
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                LazyVGrid(columns: columns) {
//                    ForEach((1...80), id: \.self) { row in
//                        Text("Row \(row)")
//                            .frame(height: 100)
//                            .id(row)
//                    }
//                }
//                .background(GeometryReader { geometry in
//                    Color.clear
//                        .onAppear(perform: {
//                            let contentHeight = geometry.size.height
//                            let screenHeight = ScreenSize.height
//                            print(contentHeight - screenHeight)
//                        })
//                        .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
//
//                })
//                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
//                    self.scrollPosition = value
//
//                }
//            }
//            .onAppear {
//                print()
//            }
//           // .coordinateSpace(name: "scroll")
//            .navigationTitle("Scroll offset: \(abs(scrollPosition.y))")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//struct DetectScrollPosition_Previews: PreviewProvider {
//    static var previews: some View {
//        DetectScrollPosition()
//    }
//}
