//: # SemiEncoder & Decoder
//: 元ネタは[Swift で SemiEncoder, SemiDecoder を作る](http://qiita.com/Code-Hex/items/84e2f6470361b1e33bc6)
//:
//: 楽しいエクステンション

import Foundation

extension String {
//: - ２進数表示
    var binary: String {
        let chars = self.characters.map { String($0).unicodeScalars.first!.value }
        return chars.map({ String($0, radix: 2).pad(24) }).joinWithSeparator("")
    }
//: - ２進数からもとへ
    func bintostr() -> String {
        let binaries = self.match("[01]{1,24}")
        var orig = ""
        for b in binaries {
            orig += String(UnicodeScalar(Int(strtoul(b, nil, 2))))
        }
        return orig
    }
//: - すべて２４桁の２進数に
    func pad(toSize: Int) -> String {
        var padded = self
        for _ in 0..<toSize-self.characters.count {
            padded = "0" + padded
        }
        return padded
    }
//: - 正規表現で２進数表示の文字列を一文字づつに分ける
    func match(pattern: String) -> [String] {
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let range = NSMakeRange(0, self.characters.count)
        let matches = regex.matchesInString(self, options: [], range: range)
        
        var matchedTokens = [String]()
        for result in matches {
            for r in [result] {
                if r.range.location <= self.characters.count && r.range.length > 0 {
                    matchedTokens.append((self as NSString).substringWithRange(r.range))
                }
                break
            }
        }
        return matchedTokens
    }
//: - 文字列の置き換え用
    func replace(pattern: String, _ withString: String) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let range = NSMakeRange(0, self.characters.count)
        return regex.stringByReplacingMatchesInString(self, options: [], range: range, withTemplate: withString)
    }
}

//: こっから蝉
extension String {
    func SemiEncode() -> String {
        return self.binary.replace("0", "ﾐﾝ").replace("1", "ﾐｰﾝ").replace("(ﾐﾝﾐﾝﾐﾝﾐｰﾝ)", "$0…")
    }
    func SemiDecode() -> String {
        return self.replace("…", "").replace("ﾐﾝ", "0").replace("ﾐｰﾝ", "1").bintostr()
    }
}

let str = "Hello, World!こんにちは世界！はじめまして、私はSemiです。"
let crows = str.SemiEncode()
crows.SemiDecode()