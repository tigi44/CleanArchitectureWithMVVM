//
//  GroupView.swift
//  
//
//  Created by tigi KIM on 2021/01/18.
//

import SwiftUI
import Model
import ViewModel

public struct GroupView: View {
    
    struct MyGroupView: View {
        
        let myGroupEntity: MyGroupEntity
        
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                Image(myGroupEntity.image)
                    .resizable()
                    .frame(width: 130, height: 130, alignment: .center)
                    .cornerRadius(5)
                VStack(alignment: .leading) {
                    Text(myGroupEntity.name)
                        .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                        .fontWeight(.regular)
                    Text(myGroupEntity.date)
                        .font(/*@START_MENU_TOKEN@*/.footnote/*@END_MENU_TOKEN@*/)
                }
            }
        }
    }
    
    @ObservedObject public var viewModel: MyGroupListViewModel
        
    public init(viewModel: MyGroupListViewModel) {
        self.viewModel = viewModel
    }
        
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("내 그룹 목록")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(self.viewModel.myGroups) { myGroupEntity in
                        MyGroupView(myGroupEntity: myGroupEntity)
                    }
                }
            }
        }
        .onAppear {
            self.viewModel.didFetch()
        }
    }
}

//struct GroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupView()
//    }
//}
