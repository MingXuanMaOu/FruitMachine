//
//  InfoView.swift
//  FruitMachine
//
//  Created by 刘铭 on 2023/1/16.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            LogoView()
            Spacer()
            Form{
                Section(header: Text("关于应用程序"), content: {
                    FormRowView(firstItem: "应用程序", secondItem: "奇妙水果机")
                    FormRowView(firstItem: "平台", secondItem: "iPhone、iPad、Mac")
                    FormRowView(firstItem: "开发者", secondItem: "LiuMing")
                    FormRowView(firstItem: "设计者", secondItem: "Oscar")
                    FormRowView(firstItem: "音效", secondItem: "Star")
                    FormRowView(firstItem: "网站", secondItem: "www.liuming.cn")
                    FormRowView(firstItem: "版本", secondItem: "0.0.1")
                    
                })
            }
            .font(.system(.body,design: .rounded))
        }
        .padding(.top,40)
        .overlay(
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark.circle")
                    .font(.title)
            })
            .padding(.top,30)
            .padding(.trailing,20)
            .accentColor(.secondary)
            ,alignment: .topTrailing
        )
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

struct FormRowView: View {
    var firstItem: String
    var secondItem: String
    var body: some View {
        HStack{
            Text(firstItem)
                .foregroundColor(.gray)
            Spacer()
            Text(secondItem)
        }
    }
}
