//
//  MyGroupListView.swift
//  
//
//  Created by tigi KIM on 2021/01/18.
//

import SwiftUI

public struct MyGroupListView: View {
    
    struct MyGroupView: View {
        
        let image: String
        let name: String
        let date: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                Image(image)
                    .resizable()
                    .frame(width: 130, height: 130, alignment: .center)
                    .cornerRadius(5)
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.headline)
                        .fontWeight(.regular)
                    Text(date)
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
                        MyGroupView(image: myGroupEntity.image, name: myGroupEntity.name, date: myGroupEntity.date)
                    }
                }
            }
        }
        .onAppear {
            self.viewModel.executeFetch()
        }
    }
}
