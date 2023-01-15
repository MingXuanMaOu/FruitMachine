//
//  LogoView.swift
//  FruitMachine
//
//  Created by 刘铭 on 2023/1/15.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("奇妙水果机")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 256,idealWidth: 300,maxWidth: 320,minHeight: 82,idealHeight: 92,maxHeight: 112,alignment: .center)
            .padding(.horizontal)
            .layoutPriority(1)
            .modifier(shadowModifier())
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
