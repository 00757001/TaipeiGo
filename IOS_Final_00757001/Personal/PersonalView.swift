//
//  ExampleView.swift
//  IOS_Final_00757001
//
//  Created by User08 on 2021/1/1.
//
// ASCollectionView. Created by Apptek Studios 2019

import ASCollectionView
import SwiftUI

struct PersonalView: View {
    let persistenceController = PersistenceController.shared
    enum Section
    {
        case upper
        case list
        case addNew
        case footnote
    }
    var upperData: [GroupModel] = [GroupModel(icon: "heart.fill", title: "收藏",color: Color.red, select:.favorite),
                                   GroupModel(icon: "camera.fill", title: "建立景點",color: Color.blue, select:.image),
                                   GroupModel(icon: "paperplane.fill", title: "我的景點",color: Color.green, select:.userspot)]
    
    var lowerData: [GroupModel] = [GroupModel(icon: "info.circle.fill", title: "API介紹",color: Color.orange, select:.info)]
    @State private var showSheet = false
    @State var sheetView: ViewState = .favorite

    var body: some View{
        NavigationView{
            ASCollectionView
            {
                ASCollectionViewSection<Section>(id: .list, data: self.upperData){ model, info in
                    VStack(spacing: 0)
                    {
                        GroupSmall(model: model,showSheet: $showSheet,sheetView: $sheetView)
                        if !info.isLastInSection
                        {
                            Divider()
                        }
                            
                    }
                }
                .sectionHeader{
                    Text("My List")
                        .font(.headline)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                ASCollectionViewSection<Section>(id: .addNew, data: self.lowerData){ model, info in
                    VStack(spacing: 0)
                    {
                        GroupSmall(model: model,showSheet: $showSheet,sheetView: $sheetView)
                        if !info.isLastInSection
                        {
                            Divider()
                        }
                            
                    }
                }
                .sectionHeader{
                    Text("Others")
                        .font(.headline)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
        
            }
            .layout(self.layout)
            .contentInsets(.init(top: 20, left: 0, bottom: 20, right: 0))
            .alwaysBounceVertical()
            .background(Color(.systemGroupedBackground))
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("個人")
            .sheet(isPresented: $showSheet, onDismiss:{
                        self.showSheet = false
                    }, content: {
                        if sheetView == .favorite {
                            FavoriteView()
                                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        }
                        if sheetView == .image {
                            ImageView()
                                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        }
                        if sheetView == .info {
                            InfoView()
                        }
                        if sheetView == .userspot {
                            UserSpotView()
                        }
            })
        }
        
    }

    let groupBackgroundElementID = UUID().uuidString

    var layout: ASCollectionLayout<Section>
    {
        ASCollectionLayout<Section>(interSectionSpacing: 20)
        { sectionID in
            switch sectionID
            {
            case .upper:
                return .grid(
                    layoutMode: .adaptive(withMinItemSize: 165),
                    itemSpacing: 20,
                    lineSpacing: 20,
                    itemSize: .estimated(90))
            case .list, .addNew, .footnote:
                return ASCollectionLayoutSection
                {
                    let itemSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .estimated(60))
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)

                    let groupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .estimated(60))
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                    let section = NSCollectionLayoutSection(group: group)
                    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)

                    let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
                    let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: supplementarySize,
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top)
                    let footerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: supplementarySize,
                        elementKind: UICollectionView.elementKindSectionFooter,
                        alignment: .bottom)
                    section.boundarySupplementaryItems = [headerSupplementary, footerSupplementary]

                    let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: self.groupBackgroundElementID)
                    sectionBackgroundDecoration.contentInsets = section.contentInsets
                    section.decorationItems = [sectionBackgroundDecoration]

                    return section
                }
            }
        }
        .decorationView(GroupBackground.self, forDecorationViewOfKind: groupBackgroundElementID)
    }
}

struct GroupBackground: View, Decoration
{
    let cornerRadius: CGFloat = 12
    var body: some View
    {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color(.secondarySystemGroupedBackground))
    }
}

struct RemindersScreen_Previews: PreviewProvider
{
    static var previews: some View
    {
        PersonalView()
    }
}

