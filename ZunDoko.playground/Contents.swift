//: # ズンドコのSwift実装各種をまとめてみる
//: ## 再帰的enumでのズンドコキヨシ @kakajika
//: - [http://qiita.com/kakajika/items/d21e44ae427008493898](http://qiita.com/kakajika/items/d21e44ae427008493898)


import Foundation

enum Zundoko : CustomStringConvertible {
    case Start
    indirect case Zun(Zundoko)
    indirect case Doko(Zundoko)
    indirect case Kiyoshi(Zundoko)
    
    func zundoko() -> Zundoko {
        return (arc4random_uniform(2) > 0) ? Zun(self) : Doko(self)
    }
    var description: String {
        switch self {
        case Start: return "スタート!"
        case Zun(let zd): return "\(zd)\nズン"
        case Doko(let zd): return "\(zd)\nドコ"
        case Kiyoshi(let zd): return "\(zd)\nキ・ヨ・シ！"
        }
    }
}

var zd: Zundoko = .Start
while true {
    if case .Doko(.Zun(.Zun(.Zun(.Zun)))) = zd {
        zd = .Kiyoshi(zd)
        break
    } else {
        zd = zd.zundoko()
    }
}
print(zd)