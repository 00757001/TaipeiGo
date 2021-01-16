// ASCollectionView. Created by Apptek Studios 2019

import SwiftUI

struct GroupSmall: View
{
	var model: GroupModel
    @Binding var showSheet: Bool
    @Binding var sheetView: ViewState

	var body: some View
	{
        Button(action:{
            showSheet = true
            sheetView = model.select
        }){
            HStack(alignment: .center)
            {
                Image(systemName: model.icon)
                    .font(.system(size: 16, weight: .regular))
                    .padding(14)
                    .foregroundColor(.white)
                    .background(
                        Circle().fill(model.color)
                    )

                Text(model.title)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(.label))

                Spacer()
            }
            .padding(10)
        }
		
	}
}

//struct GroupSmall_Previews: PreviewProvider
//{
//	static var previews: some View
//	{
//        GroupSmall(model: .demo, selectedView: .constant(.))
//	}
//}
