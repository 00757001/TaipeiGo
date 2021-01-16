//
//  SearchBar.swift
//  IOS_Final_00757001
//
//  Created by User08 on 2021/1/1.
//
import Foundation
import UIKit
import SwiftUI

struct SearchBar: UIViewRepresentable {

    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            debugPrint("textChange")
            text = searchText
        }
        
//        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//            UIApplication.shared.endEditing()
//        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = context.coordinator
        //searchBar.autocapitalizationType = .none
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        debugPrint("updateUIView")
        uiView.text = text
    }
    typealias UIViewType = UISearchBar
}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("test"))
    }
}
