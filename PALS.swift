//: 生命科学 宿題１２ 最適成長スケジュールのSwiftでの実装

import Foundation

func seq(s: Int, t: Int, length: Int) -> [Double] {
    var ret: [Double] = [Double(s)]
    let step = Double(t - s) / Double(length - 1)
    var temp = Double(s) + step
    while temp <= Double(t) {
        ret.append(temp)
        temp += step
    }
    return ret
}
func seq(s: Int, t: Int, step: Double) -> [Double] {
    var ret = [Double]()
    var temp = Double(s)
    while temp <= Double(t) {
        ret.append(temp)
        temp += step
    }
    return ret
}

var p = 11  // 投資量uが0から1になるときの場合の数（毎日変わる）
let sub = 100   // sub-strategyの数
let Tf = 100    // 最終時間ステップ
var us = seq(0, t: 1, length: p)    // 最適なuを探す
var U = Array(count: sub, repeatedValue: 0.5)   // 最適なuは毎日u=0.5と仮定する
var Uoptimal = Array(count: sub, repeatedValue: 0.5)
var ymax = 0

for i in (0 ..< sub).reverse() {    // i+1日目の最適戦略をj=0~p-1(11種)から探す
    for j in 0 ..< p {
        U[i] = us[j]    // i日目のU値を選ぶ
        // 初期化
        var x0 = 1
        var y0 = 1
        var ti = 0
        for k in 0 ..< sub {
            // ルンゲ＝クッタ法
            // パラメータ：u=U[k], r=0.05, x=x0, y=y0, tf=Tf/sub*k, times=seq(ti, t: tf, step: st)
            // dx = (1-u)*r*x
            // dy = u*r*x
            var u = U[k]; var r = 0.05; var x = x0; var y = y0
            let tf = Tf / sub * k; let st = 0.1; let times = seq(ti, t: tf, step: st)
            // 結果をti, x0, y0に入れる
        }
        if y0 > ymax {
            ymax = y0   // ymaxを更新
        }
        for k in 0 ..< sub {
            Uoptimal[k] = U[k]
        }
    }
    for j in 0 ..< sub {
        U[j] = Uoptimal[j]
    }
}
