//
//  ContentView.swift
//  ToDokimi
//
//  Created by 田久保公瞭 on 2020/12/28.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    var body: some View {
        NavigationView{
            List{
                ForEach(userData.tasks){task in
                    Button(action:{
                        //firstIndexとは配列から引数で指定した要素を探し出し、見つけかればその要素番号を、見つからなければ「nil」を返すメソッド
                        guard let index = self.userData.tasks.firstIndex(of: task) else{
                            return
                        }
                        //toggle 逆にする
                        self.userData.tasks[index].cheaked.toggle()
                    }){
                    ListRow(task: task.title, isCheak: task.cheaked)
                    }
                }
                if self.userData.isEditing{
                    Draft()
                }
                else{
                    Button(action: {
                        self.userData.isEditing = true
                    })
                    {
                        Text("➕").font(.title)
                    }
                }
            }
            //タイトルを追加するモデルファイヤ
            .navigationBarTitle(Text("Tasks"))
            .navigationBarItems(trailing: Button(action:{
                DeleteTask()
            }){
                Text("Delete")
            }
            )
        }
        
    }
    func DeleteTask() {
        //消すのではなく、チェックが付いてないものだけを表示させるコード
        //filter
        //配列から、引数に指定した条件を満たす要素だけが格納された配列を返す。
        //ここでの!は「ではない」を使っている
        //falseの要素だけが格納された配列を返す
        let necessaryTask = self.userData.tasks.filter({!$0.cheaked})
        self.userData.tasks = necessaryTask
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserData())
    }
}
