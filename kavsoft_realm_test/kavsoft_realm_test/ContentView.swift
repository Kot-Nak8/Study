//
//  ContentView.swift
//  kavsoft_realm_test
//
//  Created by 中村幸太 on 2020/12/25.
//
//Realmとかを入れるときは「File」の「SwiftPackages」の「Add Package Depen...」から以下のURLを貼り付ける
//Realmは https://github.com/realm/realm-cocoa
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @State var name = ""
    @State var age = ""
    @ObservedObject private var viewModel = get_data()
    
    var body: some View {
        NavigationView{
            //ホーム画面に表示する
            List {
                ForEach(viewModel.itemEntities, id: \.id) { datatype in
                    Text("\(datatype.name)" + "　" + "\(datatype.age)")
                }}
                .navigationBarTitle("ホーム", displayMode: .inline)
                .navigationBarItems(leading: NavigationLink(destination:
                //追加ボタンを押すと出てくる画面
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
                                            //主キーを決定するやつ
                                            //保存されてるデータの最大のidを取得
                                            var maxId: Int { return try! Realm().objects(datatype.self).sorted(byKeyPath: "id").last?.id ?? 0 }
                                            newdata.id = maxId + 1
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
                                            print(result)
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
                                        Text("全削除")
                                    }
                }.padding(20)){
                        Text("追加")
                })//BarItems
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    

//RealmのEntity
class datatype :Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var name = ""
    @objc dynamic var age = ""
    private static var config = Realm.Configuration(schemaVersion :1)
    private static var realm = try! Realm(configuration: config)
    //idを主キーに設定
    override static func primaryKey() -> String? {
            return "id"
    }
    //realmのデータを取り出す関数
    static func all() -> Results<datatype> {
        realm.objects(datatype.self)
    }
}

//データを取得するクラス
class get_data : ObservableObject{
    @Published var itemEntities: Results<datatype> = datatype.all()
    
    private var notificationTokens: [NotificationToken] = []

    //よくわからんけど下のをコピペしたら更新してくれるようになった
        init() {
            // DBに変更があったタイミングでitemEntitiesの変数に値を入れ直す
            notificationTokens.append(itemEntities.observe { change in
                switch change {
                case let .initial(results):
                    self.itemEntities = results
                case let .update(results, _, _, _):
                    self.itemEntities = results
                case let .error(error):
                    print(error.localizedDescription)
                }
            })
        }

        deinit {
            notificationTokens.forEach { $0.invalidate() }
        }
}
