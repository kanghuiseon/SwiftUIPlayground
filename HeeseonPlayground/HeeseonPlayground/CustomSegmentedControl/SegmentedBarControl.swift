//
//  SegmentedBarControl.swift
//  HeeseonPlayground
//
//  Created by 강희선 on 2022/05/12.
//

import SwiftUI

struct SegmentedBarControl: View {
    @State var selected: String = "치킨"
    @Namespace var animation
    
    let titles: [String] = ["치킨", "회/돈까스", "중식", "백반/죽/국수", "까페/디저트"]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(titles, id: \.self) { title in
                    Text(title)
                        .font(.system(size: 20))
                        .bold()
                        .padding(.bottom, 6)
                        .overlay(alignment: .bottom) {
                            if selected == title {
                                Rectangle()
                                    .fill(.black)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 5)
                                    .matchedGeometryEffect(id: "Segmented", in: animation)
                            }
                        }
                        .onTapGesture {
                            selected = title
                        }
                        .animation(.easeOut, value: selected)
                }
            }
        }
        .padding(.horizontal, 25)
    }
}

struct SegmentedBarControl_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedBarControl()
    }
}
