//
//  ShareController.swift
//  IOS_Final_00757001
//
//  Created by User04 on 2021/1/6.
//

import SwiftUI

struct ShareController: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
       
       let activityItems: [Any]
       let applicationActivities: [UIActivity]? = nil
       let excludedActivityTypes: [UIActivity.ActivityType]? = nil
       let callback: Callback? = nil
       
       func makeUIViewController(context: Context) -> UIActivityViewController {
           let controller = UIActivityViewController(
               activityItems: activityItems,
               applicationActivities: applicationActivities)
           controller.excludedActivityTypes = excludedActivityTypes
           controller.completionWithItemsHandler = callback
           return controller
       }
       
       func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
           // nothing to do here
       }
}
