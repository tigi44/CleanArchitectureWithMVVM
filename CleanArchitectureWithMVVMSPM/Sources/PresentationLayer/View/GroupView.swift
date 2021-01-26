//
//  GroupView.swift
//  
//
//  Created by tigi KIM on 2021/01/18.
//

import SwiftUI
import DomainLayer

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
                        .font(.headline)
                        .fontWeight(.regular)
                    Text(myGroupEntity.date)
                        .font(.footnote)
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
                    .font(.title)
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
            self.viewModel.executeFetch()
        }
    }
}

//struct GroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupView()
//    }
//}
