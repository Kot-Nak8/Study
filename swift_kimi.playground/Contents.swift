print("hello,world")
print("文字列")

//変数と定数
//変数の場合
var variable = 30
//変数は変更できる
variable = 60
//定数の場合、変更できない
let constant = 22

//推論型
//型を予測して自動でつけてくれる機能←Int型かStr型か自動でつけてくれる
var implicitInteger = 59
//型を返してくれる
print(type(of: implicitInteger))

//明示的な型の説明
//初期値を指定したくない場合や、その方がわかりやすいと感じる場合に扱う
var explicitInteger:Int
var explicitInteger2:String = "初期を指定することもできる"

//型変換
//変数や定数の型を別の型に変換すること
var label = "横幅:"
var width = 80
//print(label + width)エラーが起こる
print(label + String(width))

//文字列に変数を埋め込む
//\はoptionキーを押しながら￥を押す
var apple = 10
print("私は\(apple)個リンゴを持っています")

//if文
var number = 20

if number == 10 {
    print(number)
}
else if number > 10{
    print(number)
}
else{
    print("それ以外")
}

//guard文
//条件に一致しなかった時に処理を中断する文法 returnは書く
//if文より可読性が上がるかもしれない（予期しない処理が起こった時に処理を中断したい）
var age = 20
//関数
func Drink(){
    guard age >= 20 else {
        print("お酒が飲めない")
        return
    }
    print("お酒が飲める")
}
//関数実行
Drink()

//switchとは
//条件分岐をするための文法
//三つ以上条件がある時にコードが読みやすくなる
var num = 290

switch num {
case 10:
    print(num)
case 30:
    print(num)
case 290:
    print(num)
default:
    print("それ以外")
}

//オプショナル型基本
//nilを入れることができるデータ型
//ラップする
var optionalInt: Int? = 12
//アンラップする（強制）
print(optionalInt!)

//オプショナル型；オプショナルバインディング
//条件分岐を使って、オプショナル型の値がnilかどうかで処理を分ける方法
//if
var optionalInt_If: Int? = 30
if let unwrapedInt_if = optionalInt_If{
    print(unwrapedInt_if)
}
else{
    print("unwrapedIntはnil")
}
//guardを使ったオプショナルバインティング
//guradの場合はguardの外でも定数を使うことができる。
var optionalInt_guard:Int? = 20

func Unwrap(){
    guard let unwrapedInt_gurad = optionalInt_guard else {
        print("unwrapedInt_guradはnil")
        return
    }
    print(unwrapedInt_gurad)
}
Unwrap()

//配列
//複数の値を格納出来るデータの構造
var sports = ["サッカー","テニス","バスケ"]
print(sports[1])
//要素を追加
sports.append("マラソン")
print(sports)
//空の配列を作ってみる
var emptyArray = [String]()

//辞書
//辞書とはキーと値のペアを持つ複数の値を格納できるデータ構造のこと
//配列との違いはキーと値のペアを持つ
var occupations = [
    "ヒロシ":"経営者",
    "タツヒロ":"詩人",
    "ヨシノブ":"数学者"
]
//辞書から取り出すときはオプショナル型になるから！が必要になる。
print(occupations["タツヒロ"]!)
//追加するとき
//辞書には順序を持たない、追加された位置が違くても問題ない
occupations["ノブサダ"] = "哲学者"
print(occupations)
//空の辞書
var emptyDictionary = [String: Int]()

//繰り返し
//for in
var names = ["太郎","次郎","三郎"]
for name in names {
    print(name)
}
//数値の時
//範囲演算子と呼ばれるもの
//..< 10とすると０〜９までになる
for i in 1...10 {
    print(i)
}
//関数
//関数とは処理をまとめたもの
//値に処理を加えて別の値を出力します
func Hello(name: String) -> String{
    return "こんにちは、\(name)さん"
}
print(Hello(name: "タクボ"))

func Hello2(name: String, age: Int) -> String{
    return "僕は\(name)で\(age)歳です"
}
print(Hello2(name: "takubo", age: 18))
//引数と戻り値無しの関数
func helloWorld(){
    print("helloword")
}
helloWorld()

//クロージャ
//簡略化した、名前のない関数
//一度しか使わない、わざわざ関数を定義するまでもない場合
//let hello = { (name: String) -> String in
//    return "こんにちは、\(name)さん"
//}
//print(hello("もぎ"))
//引数を省略したクロージャ
//let hello = { () -> String in
//    return "こんにちは、ジョンソン"
//}
//print(hello())
//戻り値を省略したクロージャ
let hello = {print("こんにちは、ジョンソンさん")}
hello()

//クラス
//クラスタとは設計図のようなもの
//クラスを使ってインスタンスを作ることで使えるようになります
//インスタンスはクラスを元にして作った実体のこと例）動物クラスから犬ねこパンダのようなもの
//クラスには変数、定数、関数を書き込むことができる
//変数、定数をプロパティ　関数のことをメソッドと呼ぶ
class Animal{
    var age = 2
    let kind = "犬"
    
    func Bite(){
        print("\(age)歳の\(kind)が噛み付く")
    }
}
var dog = Animal()
print(dog.age)
print(dog.kind)
dog.Bite()
//イニシャライザ
//インスタンスに応じて値を変えられるようにすること
//インスタンスを作る時にプロパティに初期値を与えるもの
class Animal2{
    var age: Int
    let kind :String
    
    func Bite(){
        print("\(age)歳の\(kind)が噛み付く")
    }
    
    init(age: Int,kind: String) {
        self.age = age
        self.kind = kind
    }
}

var cat = Animal2(age: 3, kind: "ねこ")
cat.Bite()

//構造体の基本
//値をまとめておくためのもの
//クラスに似ている、swiftUiで多く使われている、クラスよりアップルに押されている
struct Animal3{
    let age = 5
    var kind = "犬"
    func Bite() {
        print("\(age)歳の\(kind)が噛み付く")
    }
}
var dog2 = Animal3()
dog2.Bite()
//イニシャルライザ
struct Animal4{
    let age: Int
    var kind: String
    func Bite() {
        print("\(age)歳の\(kind)が噛み付く")
    }
    
    init(age: Int, kind:String) {
        self.age = age
        self.kind = kind
    }
}
var panda = Animal4(age: 4, kind: "panda")
panda.Bite()
//構造体配列
var animals: [Animal4] = [
    Animal4(age: 34, kind: "dog"),
    Animal4(age: 8, kind: "cat"),
    Animal4(age: 1, kind: "panda")
]
animals[1].Bite()

//プロトコル
//構造体やクラスの実装を保証するもの←前書きみたいなもの？もう少し詳しく調べる。
//プロトコルの定義時はプロパティやメソッドの中身は書かず、構造体などの中で実装するのがポイント
protocol Animal_protocol{
    //getにすることで実装した時にプロパティを定数（let）にすることができる
    //get は読み取り専用
    var age: Int{get}
    func bark()
}
//プロトコルを構造体に適応させる
struct Dog: Animal_protocol{
    var age: Int
    
    func bark() {
        print("\(age)歳の犬が吠える")
    }
}

Dog(age: 34).bark()
