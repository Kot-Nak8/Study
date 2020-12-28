//
//  ListRow.swift
//  ToDokimi
//
//  Created by 田久保公瞭 on 2020/12/28.
//

import SwiftUI

struct ListRow: View {
    let task: String
    let isCheak: Bool
    
    var body: some View {
        HStack {
            if isCheak {
                Text("✅")
                Text(task)
                    .strikethrough()
                    .fontWeight(.ultraLight)
            }else{
                Text("□")
                Text(task)
            }
           
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(task: "っっ",isCheak: true)
    }
}
