//
//  UserData.swift
//  ChangeTextColor
//
//  Created by 田久保公瞭 on 2020/12/27.
//

import SwiftUI

//ObservableObjectプロトコルを付けたクラス
class UserData: ObservableObject {
    @Published var name : String
    @Published var age : Int
    
    init(name : String, age : Int) {
        self.name = name
        self.age = age
    }
}

class kimi_data: ObservableObject {
    @Published var name = "田久保"
    @Published var age = 23
    
}
