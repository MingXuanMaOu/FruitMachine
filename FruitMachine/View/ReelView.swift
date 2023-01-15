//
//  ReelView.swift
//  FruitMachine
//
//  Created by 刘铭 on 2023/1/16.
//

import SwiftUI

struct ReelView: View {
    var body: some View {
        Image("槽位")
            .resizable()
            .modifier(ImageModifier())
    }
}

struct ReelView_Previews: PreviewProvider {
    static var previews: some View {
        ReelView()
    }
}
