//
//  ContentView.swift
//  kavsoft_realm_test
//
//  Created by 中村幸太 on 2020/12/25.
//
//Realmとかを入れるときは「File」の「SwiftPackages」の「Add Package Depen...」から以下のURLを貼り付ける
//Realmは https://github.com/realm/realm-cocoa
//更新と削除した時にAlertの表示ができなかった
//削除した時にホームに戻りたい
//ビューごとにまとめてたりしてないからとてつもなく見にくい

import SwiftUI
import RealmSwift

struct ContentView: View {
    @State var name = ""
    @State var age = ""
    @State var day = Date()
    @State private var updateAlert = false
    @State private var newAlert = false
    @State private var deleteAlert = false
    @ObservedObject private var viewModel = get_data()

    var body: some View {
        TabView{
        NavigationView{
            //ホーム画面にリスト表示する
            List {
                //freeze()を追加したら削除ができるっぽい https://software.small-desk.com/development/2020/09/07/swiftuirealmxcode12-realm-edit/を参照
                ForEach(viewModel.itemEntities.freeze(), id: \.id) { datatypes in
                    //リストをタップで遷移する画面
                    NavigationLink(destination:
                                    VStack{
                                    Text("編集画面").padding(40)
                                    Text("登録した名前：「 " + "\(datatypes.name)" + " 」")
                                    TextField("名前の変更", text: $name).textFieldStyle(RoundedBorderTextFieldStyle())
                                    Text("登録した年齢：「 " + "\(datatypes.age)" + " 」")
                                    TextField("年齢の変更", text: $age).textFieldStyle(RoundedBorderTextFieldStyle())
                                    Text("登録した日付：「 " + "\(datatypes.day)" + " 」")
                                    DatePicker("新しい日付を選択", selection: $day, displayedComponents: .date)
                                        //要素の変更編ボタン
                                        Button(action: {
                                            let config = Realm.Configuration(schemaVersion :1)
                                            do{
                                                let realm = try Realm(configuration: config)
                                                let result = realm.objects(datatype.self)
                                                try realm.write({
                                                    //繰り返しと条件一致での方法しか考えられなかった
                                                    for i in result{
                                                        if i.id == datatypes.id{
                                                            i.name = self.name
                                                            i.age = self.age
                                                            i.day = self.day
                                                            realm.add(i)
                                                        }
                                                    }
                                                    print("success")
                                                    //変更したあとnameとageに残っているデータを初期値に戻す
                                                    self.name = ""
                                                    self.age = ""
                                                    self.day = Date()
                                                })
                                                //アラートのフラグ
                                                //self.updateAlert = true
                                                
                                            }
                                            catch{
                                                print(error.localizedDescription)
                                            }
                                            
                                            }) {
                                            Text("更新")
                                            }.padding(20)
                                        //ここに削除ボタンを設置
                                        Button(action: {
                                            let config = Realm.Configuration(schemaVersion :1)
                                            do{
                                                let realm = try Realm(configuration: config)
                                                let result = realm.objects(datatype.self)
                                                try! realm.write({
                                                    //コピーではなくrealmの本体を消したい
                                                    //全データからidの一致で削除
                                                    for i in result{
                                                        if i.id == datatypes.id{
                                                            realm.delete(i)
                                                        }}
                                                    })
                                            }
                                            catch{
                                                print(error.localizedDescription)
                                            }
                                            
                                            }) {
                                            Text("削除")
                                            }.padding(20)
                                        

                                    }.padding(20)
                    ){
                    //↑までは遷移画面の描写
                    //ここからリスト表示の描写
                    VStack{
                    Text("\(datatypes.name)" + "　" + "\(datatypes.age)")
                    Text("\(datatypes.day)")
                        }}}}
                .navigationBarTitle("ホーム", displayMode: .inline)
                .navigationBarItems(leading: NavigationLink(destination:
                                                                
                //追加ボタンを押すと出てくる画面
                                VStack{
                                //入力するところ
                                    TextField("名前", text: $name).textFieldStyle(RoundedBorderTextFieldStyle())
                                    TextField ("年齢", text: $age).textFieldStyle(RoundedBorderTextFieldStyle())
                                    //日付を取得
                                    DatePicker("日付を選択", selection: $day, displayedComponents: .date)
                                    
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
                                            newdata.day = self.day
                                            try realm.write({
                                                realm.add(newdata)
                                                print("success")
                                                //アラートのフラグ
                                                self.newAlert = true
                                                //変更したあとnameとageに残っているデータを初期値に戻す
                                                self.name = ""
                                                self.age = ""
                                                self.day = Date()
                                            })
                                            
                                        }
                                        catch{
                                            print(error.localizedDescription)
                                        }
                                        
                                    }) {
                                        Text("追加")
                                    }.alert(isPresented: $newAlert) {
                                        Alert(title: Text("追加完了"),
                                              message: Text("内容が追加されました"))   // 詳細メッセージの追加
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
                                        Text("デバッグエリアに表示")
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
                })//BarItemsの終わりのカッコ
            //１つ目のタブ
        }.tabItem {
            Image(systemName: "house")
            Text("Home")}
            //２つ目のタブのビューの描写
                Text("検索")
                //２つ目のタブ
                    .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")}
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
    @objc dynamic var day = Date()
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

//データを取得しておくクラス
class get_data : ObservableObject{
    @Published var itemEntities: Results<datatype> = datatype.all()
    //よくわからんけどここから下のずらっと書いてあるやつをコピペしたら保存した時にビューを更新してくれるようになった
    private var notificationTokens: [NotificationToken] = []
    
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
