//
//  UserData.swift
//  ToDokimi
//
//  Created by 田久保公瞭 on 2020/12/28.
//

import SwiftUI

class UserData: ObservableObject {
    @Published var tasks = [
        Task(title: "➕を押して追加しよう！", cheaked: false)
    ]
    @Published var isEditing: Bool = false

}
