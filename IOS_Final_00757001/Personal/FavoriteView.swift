//
//  FavoriteView.swift
//  IOS_Final_00757001
//
//  Created by User08 on 2021/1/2.
//

import SwiftUI

struct FavoriteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var showShareSheet = false
    var body: some View {
        NavigationView{
            List {
                ForEach(items) { item in
                    NavigationLink(destination:WebView(urlString: item.urlString!)){
                        Text(item.name!)
                            .font(.system(size: 20))
                            .contextMenu{
                                Button(action:{
                                    showShareSheet = true
                                }){
                                    Image(systemName: "square.and.arrow.up.on.square")
                                    Text("分享")
                                }
                            }
                            .sheet(isPresented: $showShareSheet){
                                ShareController(activityItems: [URL(string: item.urlString!)!])
                            }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("我的收藏")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    HStack{
                        EditButton()
                    }
                }
            }
        }
    }
  
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
