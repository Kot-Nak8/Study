//
//  ContentView.swift
//  ChangeTextColor
//
//  Created by 田久保公瞭 on 2020/12/26.
//
//importでswiftUIを取り込んでいる
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, swiftUI!")
            .foregroundColor(Color.purple)
            .padding()
    }
}

//リストの使い方
struct ContentView_List: View {
    var body: some View{
        List{
            Text("りんご")
            Text("レモン")
            Text("オレンジ")
        }
    }
}

//NavigationBarTitle
//タイトルを作るモディファイヤのこと
struct ContentView_NavigationBarTitle: View {
    var body: some View{
        NavigationView {
            Text("米")
                .navigationTitle(Text("タイトル"))
        }
    }
    
}

//NavigationBarItems
//上の方にTextやButtonなどのUI部品を配置したい時に使うモデルファイヤ
struct ContentView_NavigationBarItem: View {
    var body: some View{
        NavigationView {
            //trailing右
            //leading 左
            Text("Hello")
                .navigationBarItems(leading: Text("アイテム"))
        }
    }
}

//HStack
//複数のUI部品を水平方向に配置する
struct ContentView_HStack: View {
    var body: some View{
        HStack {
            Text("✅")
            Text("hello world")
        }
    }
}

//VStack
//複数のUI部品を垂直方向に配置する
struct ContentView_VStack: View {
    var body: some View{
        VStack {
            Text("you")
            Text("hello swift")
            Text("hello world")
        }
    }
}

//font
//文字の大きさを変える
struct ContentView_font: View {
    var body: some View{
        List{
            Text("hello world(largetitle)").font(.largeTitle)
            Text("hello world(title)").font(.title)
            Text("hello world(headline)").font(.headline)
            Text("hello world(body)").font(.body)
            Text("hello(callout)").font(.callout)
            Text("hello(subheadline))").font(.subheadline)
            Text("hello(footnote)").font(.footnote)
            Text("hello(caption)").font(.caption)
        }
    }
}

//button
//クリックした時に何らかの処理を行うUI部品　主に関数やクロージャ
struct ContentView_Button: View {
    var body: some View{
        Button(action: {print("ボタンが押されました")}){
            Text("ボタンを押してください")
        }
    }
}
func Report() {
    print("ボタンが押されました")
}

//ForEach
//UI部品を繰り返し生成するためのもの
//１数値範囲を用いて複数回繰り返す方法
//2構造体の配列から要素を一つづつ取り出していく方法
struct ContentView_ForEach : View {
    var body: some View{
        List{
            ForEach(0..<11){num in
                Text("\(num):hello,wolrd")
            }
        }
    }
}
//構造体の配列　ForEach
//identifiableプロトコルとはインスタンスを特定するためのIDを持たせると言ったもの
struct Human: Identifiable {
    let name:String
    let id = UUID()
}
struct ContentView_ForEach_Array: View {
    let humans = [
        Human(name: "田久保"),
        Human(name: "kimi"),
        Human(name: "kuma")
    ]
    var body: some View{
        List{
            ForEach(humans){human in
                Text("\(human.name)さん、こんにちは。idは\(human.id.description)")
            }
        }
    }
}

//@State
//プロパティを変更できるようにするもの
//＠Stateを付けたプロパティが変わった時にViewが更新される
//selfはこの構造体だからってこと
struct ContentView_State: View {
    @State var lastName = "田中"
    let firstName = "太郎"
    
    var body: some View{
        VStack{
            Button(action: {self.lastName = "島田"}){
                Text("名字を変える")
            }
            Text(lastName + firstName)
        }
    }
}

//observedObject
//インスタンス版の@State
//インスタンスのプロパティが変更された時にViewを更新する。@Publishedがついているプロパティだけ
struct ContentView_observedObject: View {
    @ObservedObject var userData = UserData(name: "スズキ", age: 20)
    
    var body: some View{
        VStack{
            Button(action: {
                userData.name =  "佐藤"
            }) {
                Text("名前を変える")
                    .padding()
            }
            Button(action: {
                userData.age += 1
            })
            {
                Text("歳を増やす")
                    .padding()
            }
            Text("\(userData.name)の年齢は\(userData.age)歳です")
        }
    }
}

//EnvironmentObject
//Viewで共通のプロパティを使えるようにしたもの
//@ObservedObjectっを付けた場合、インスタンスはそれぞれのViewで独立した値を取ります。
//EnvironmentObjectだと結合された形になる
struct ContentView_EnvironmentObject: View {
    @EnvironmentObject var kimiData: kimi_data
    
    var body: some View{
        VStack{
            Button(action:{
                kimiData.age += 1
            }){
                Text("年齢を増やす")
            }
            Text("contentView: \(kimiData.name)さん\(kimiData.age)さい")
                    .padding()
            EnvironmentObject_anotherContentView()
        }
    }
}
struct EnvironmentObject_anotherContentView: View{
    @EnvironmentObject var kimiData: kimi_data
    
    var body: some View{
        Text("another content view\(kimiData.name)さん\(kimiData.age)歳")
    }
}

//TextField
//文字を入力するためのUI部品
//入力された文字は@Stateのついた変数に格納されます
//プレースホルダーというのは何も値が入力されていない時に薄く表示される文字のこと。
struct ContentView_TextFiled: View {
    @State var favoriteAnimal = ""
    
    var body: some View{
        VStack {
            TextField("好きな動物を入力してください",text: $favoriteAnimal)
            Text("好きな動物は\(favoriteAnimal)")
                .padding()
        }
    }
}
//onCommit
//TextFiled
//リターンキーを押した時に、何らかの処理をすることができる
struct ContentView_onCommit: View {
    @State var favoriteAnimal = ""
    var body: some View{
        VStack{
            TextField("好きな動物を入力してください", text: $favoriteAnimal, onCommit: {favoriteAnimal = ""})
            Text("好きな動物は\(favoriteAnimal)")
                .padding()
        }
    }
}

//試したいものをコメントアウトにする
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //ContentView()
        //ContentView_List()
        //ContentView_NavigationBarTitle()
        //ContentView_NavigationBarItem()
        //ContentView_HStack()
        //ContentView_VStack()
        //ContentView_font()
        //ContentView_Button()
        //ContentView_ForEach()
        //ContentView_ForEach_Array()
        //ContentView_State()
        ContentView_observedObject()
        ContentView_EnvironmentObject()
            .environmentObject(kimi_data())
        ContentView_TextFiled()
        ContentView_onCommit()
    }
}

