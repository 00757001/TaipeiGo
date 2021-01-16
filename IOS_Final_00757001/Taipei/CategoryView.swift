//
//  CategoryView.swift
//  IOS_Final_00757001
//
//  Created by User04 on 2020/12/30.
//

import SwiftUI

struct CategoryView: View {
    var body: some View {
        List{
            ForEach(0..<categories.count) { (i) in
                NavigationLink(destination: SpotView(apiString: categoriesLink[i],offsetNum:12)){
                    Text(categories[i])
                        .font(.system(size: 25))
                }
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
