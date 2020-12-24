//
//  ContentView.swift
//  Realm_Food
//
//  Created by 中村幸太 on 2020/11/28.
//
//realmは以下のurlから取ってきた
//ttps://github.com/realm/realm-cocoa

import SwiftUI
import RealmSwift

struct ContentView: View {
    @State var image = Data()
    @State var food = ""
    @State var day = Date()
    @State var memo = ""
    @State var id = 0
    
    var body: some View {
        TabView{
        NavigationView{
        
            Text("test")
            .navigationBarTitle("食材と期限", displayMode: .inline)
            .navigationBarItems(leading: NavigationLink(destination:
                    VStack{
                        Button(action: {}) {
                            Text("写真を選択")
                        }
                        TextField("食品名", text: $food).textFieldStyle(RoundedBorderTextFieldStyle())
                        DatePicker("賞味期限を選択", selection: $day, displayedComponents: .date)
                        TextField("メモ：例（ 2個 ）", text: $memo).textFieldStyle(RoundedBorderTextFieldStyle())
                        //保存
                        //アプリを再起動したあと保存しようとするとアプリが落ちる
                        Button(action: {
                            let config = Realm.Configuration(schemaVersion : 1)
                            
                            do{
                                let realm = try Realm(configuration: config)
                                let newdata = FoodData()
                                newdata.food = self.food
                                //newdata.day = self.day
                                newdata.memo = self.memo
                                //newdata.image = self.image
                                try realm.write({
                                    realm.add(newdata)
                                    print("success!")
                                })
                            }catch{print("Error - \(error.localizedDescription)")}
                            
                        }) {
                            Text("保存")
                        }
                        //保存されたものをprintで表示
                        Button(action: {
                            let config = Realm.Configuration(schemaVersion : 1)
                            
                            do{
                                let realm = try Realm(configuration: config)
                                let result = realm.objects(FoodData.self)
                                print(result)
                            }catch{print("Error - \(error.localizedDescription)")}
                            
                        }) {
                            Text("表示")
                        }
                        //削除
                        Button(action: {
                            let config = Realm.Configuration(schemaVersion : 1)
                            
                            do{
                                let realm = try Realm(configuration: config)
                                let result = realm.objects(FoodData.self)
                                for i in result{
                                    try realm.write{
                                        realm.delete(i)
                                    }
                                }
                                print(result)
                            }catch{print("Error - \(error.localizedDescription)")}
                            
                        }) {
                            Text("全削除")
                        }
                        }.padding(20))
                  {
                Text("追加")
            })
        }.tabItem {
            Image(systemName: "house")
            Text("Home")}
        //検索のタブ
        Text("検索タブ")
        .tabItem {
            Image(systemName: "magnifyingglass")
            Text("Search")}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //日本語対応
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}

class FoodData : Object{
    // 管理用 ID。プライマリーキー
    @objc dynamic var id = 0
    //食品の写真 realmは画像を何か変換しないと保存できないとかなんとか
    //@objc dynamic var image = Data()
    //食品の名前
    @objc dynamic var food = ""
    //賞味期限
    //Dateの保存でエラーするから調べる
    //@objc dynamic var day = Date()
    //個数などのメモ
    @objc dynamic var memo = ""
    //プライマリーキーの設定とやら。idをプライマリーキーにする
    override static func primaryKey() -> String? {
            return "id"
    }
    
}


