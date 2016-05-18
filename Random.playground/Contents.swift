//: Playground - noun: a place where people can play

import Cocoa
import Foundation

var array = Array<String>()

array.append("フンジン")
array.append("とうよう")
array.append("ふなみん")
array.append("うえちゃん")
array.append("ほなみ")
array.append("さきんちょ")
array.append("アルティメット")
array.append("ながた")
array.append("いのっち")
array.append("えぐっち")
array.append("ちゃりん")
array.append("なべ")

var i = 0
let size = array.count
while i < size {
    let num = Int(arc4random_uniform(UInt32(array.count)))
    print(array[num])
    array.removeAtIndex(num)
    i += 1
}