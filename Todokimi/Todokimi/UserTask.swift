//
//  UserTask.swift
//  ToDokimi
//
//  Created by 田久保公瞭 on 2020/12/28.
//

import SwiftUI

struct Task:Equatable, Identifiable {
    let id = UUID()
    var title: String
    var cheaked: Bool
    
    init(title: String,cheaked:Bool) {
        self.title = title
        self.cheaked = cheaked
    }
}
