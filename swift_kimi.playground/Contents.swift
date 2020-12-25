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

//明示的な方の説明
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
