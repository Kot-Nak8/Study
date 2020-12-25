//
//  ContentView.swift
//  kavsoft_realm_test
//
//  Created by 中村幸太 on 2020/12/25.
//
//主キーは設定してない
//アプリを落として起動させると保存も表示もできない

import SwiftUI
import RealmSwift

struct ContentView: View {
    @State var name = ""
    @State var age = ""
    var body: some View {
        VStack{
        //入力するところ
            TextField("name", text: $name).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField ("age", text: $age).textFieldStyle(RoundedBorderTextFieldStyle())
            
        //入力したのを保存するところ
            Button(action: {
                let config = Realm.Configuration(schemaVersion :1)
                do{
                    let realm = try Realm(configuration: config)
                    let newdata = datatype()
                    newdata.name = self.name
                    newdata.age = self.age
                    try realm.write({
                        realm.add(newdata)
                        print("success")
                    })
                    
                }
                catch{
                    print(error.localizedDescription)
                }
                
            }) {
                Text("保存")
            }
            
        //デバッグエリアに保存したものを表示する
            Button(action: {
                let config = Realm.Configuration(schemaVersion :1)
                do{
                    let realm = try Realm(configuration: config)
                    let result = realm.objects(datatype.self)
                    //取り出し
                    print(result[0].age)
                }
                catch{
                    print(error.localizedDescription)
                }
                
            }) {
                Text("表示")
            }
        
        //データ全削除
            Button(action: {
                let config = Realm.Configuration(schemaVersion :1)
                do{
                    let realm = try Realm(configuration: config)
                    let result = realm.objects(datatype.self)
                    for i in result{
                        try realm.write({
                            realm.delete(i)
                        })
                    }
                    print("delete")
                }
                catch{
                    print(error.localizedDescription)
                }
                
            }) {
                Text("削除")
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class datatype :Object{
    
    @objc dynamic var name = ""
    @objc dynamic var age = ""
    
}

