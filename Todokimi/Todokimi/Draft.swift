//
//  Draft.swift
//  ToDokimi
//
//  Created by 田久保公瞭 on 2020/12/28.
//

import SwiftUI

struct Draft: View {
    @State var taskTitle = ""
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        TextField("タスクを入力してください", text: $taskTitle,onCommit: {
            self.createTask()
        })
    }
    
    func createTask() {
        let newTask = Task(title: self.taskTitle, cheaked: false)
        //insertを使ってuserDataのtasksの0番目に挿入する
        self.userData.tasks.insert(newTask, at: 0)
        self.taskTitle = ""
        //しめる
        self.userData.isEditing = false
    }
}

struct Draft_Previews: PreviewProvider {
    static var previews: some View {
        Draft()
            .environmentObject(UserData())
    }
}
