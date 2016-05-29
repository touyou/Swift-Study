//: Playground - noun: a place where people can play
// 遺伝的アルゴリズムでN-Queen問題の解を求める (1) http://qiita.com/kanlkan/items/f1110b9546de567f7075
// 上のQiita記事のSwift実装版です。

import Foundation

var gGeneCnt = 4
var gMutationSpan = 4
var gRange = 0
var gVec = [(-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)]
var gGaIdx = [4, 6]

func makeIniGene() -> [[Int]] {
    //print("makeIniGene")
    var ini_gene = [[Int]]()
    for _ in 0 ..< gGeneCnt {
        var line = [Int]()
        for _ in 0 ..< 8 {
            let val = Int(arc4random_uniform(8))
            line.append(val)
        }
        ini_gene.append(line)
    }
    return ini_gene
}

func calcFitness(gene: [Int]) -> Int {
    //print("calcFitness")
    var fitness = 0
    var board = [[Int]]()
    var line = [Int]()
    for i in 0 ..< 8 {
        line = []
        for j in 0 ..< 8 {
            if j == gene[i] {
                line.append(1)
            } else {
                line.append(0)
            }
        }
        board.append(line)
    }

    for i in 0 ..< 8 {
        for j in 0 ..< 8 {
            let val = getCell(board, pos: (i,j), ofst: (0,0))
            if val == 1 {
                for vec in gVec {
                    for k in 1 ..< 8 {
                        let valofst = getCell(board, pos: (i,j), ofst: (vec.0*k, vec.1*k))
                        if valofst == 1 {
                            fitness += 1
                        } else if valofst == -1 {
                            break
                        }
                    }
                }
            }
        }
    }
    return fitness
}

func getCell(board: [[Int]], pos: (Int, Int), ofst: (Int, Int)) -> Int {
    let posx = pos.0 + ofst.0
    let posy = pos.1 + ofst.1
    if posx >= 0 && posy >= 0 && posx < 8 && posy < 8 {
        return board[posx][posy]
    } else {
        return -1
    }
}

func simpleGa(gene_list: [[Int]], rank_list: [Int]) -> [[Int]] {
    //print("simpleGa")
    var new_gene_list = [[Int]]()
    for i in 0 ..< gGeneCnt {
        if i == rank_list[3] {
            new_gene_list.append(gene_list[rank_list[0]])
        } else {
            new_gene_list.append(gene_list[i])
        }
    }
    var updated_gene_list = [[Int]]()
    var line1 = [Int]()
    var line2 = [Int]()
    for i in 0 ..< 8 {
        if i < gGaIdx[0] {
            line1.append(new_gene_list[rank_list[0]][i])
            line2.append(new_gene_list[rank_list[1]][i])
        } else {
            line1.append(new_gene_list[rank_list[1]][i])
            line2.append(new_gene_list[rank_list[0]][i])
        }
    }
    updated_gene_list.append(line1)
    updated_gene_list.append(line2)

    line1 = []
    line2 = []
    for i in 0 ..< 8 {
        if i < gGaIdx[0] {
            line1.append(new_gene_list[rank_list[2]][i])
            line2.append(new_gene_list[rank_list[3]][i])
        } else {
            line1.append(new_gene_list[rank_list[3]][i])
            line2.append(new_gene_list[rank_list[2]][i])
        }
    }
    updated_gene_list.append(line1)
    updated_gene_list.append(line2)
    return updated_gene_list
}

func printBoard(gene: [Int]) {
    for i in 0 ..< gene.count {
        var line = [Int]()
        for j in 0 ..< gene.count {
            if j == gene[i] {
                line.append(1)
            } else {
                line.append(0)
            }
        }
        print(line)
    }
}

func function() {
    var gene_list = makeIniGene()
    print("Initial gene = ")
    print(gene_list)

    var fitness = [Int]()
    for _ in 0 ..< gGeneCnt {
        fitness.append(0)
    }

    var loop = 0
    while true {
        print("Loop count :"+String(loop))
        loop += 1
        var idx = 0
        var max_fitness_idx: (Int, Int)!
        var min_fitness_idx: (Int, Int)!

        // mutation
        if loop % gMutationSpan == 0 {
            let geneidx = Int(arc4random_uniform(UInt32(gGeneCnt)))
            let posidx = Int(arc4random_uniform(8))
            let valrand = Int(arc4random_uniform(8))
            gene_list[geneidx][posidx] = valrand
        }

        // compare fitness
        for gene in gene_list {
            fitness[idx] = calcFitness(gene)
            if idx == 0 {
                max_fitness_idx = (fitness[0], 0)
                min_fitness_idx = (fitness[0], 0)
            }

            if max_fitness_idx.0 < fitness[idx] {
                max_fitness_idx = (fitness[idx], idx)
            }

            if min_fitness_idx.0 > fitness[idx] {
                min_fitness_idx = (fitness[idx], idx)
            }

            print(fitness[idx])
            idx += 1
        }

        let min_fitness = fitness.reduce(fitness[0]) { (n1, n2) -> Int in
            return min(n1, n2)
        }
        if min_fitness <= gRange {
            print("Loop end = "+String(loop)+", Fitness = "+String(min_fitness))
            printBoard(gene_list[min_fitness_idx.1])
            break
        }

        var ranktemp = [Int]()
        for i in 0 ..< gGeneCnt {
            if i != max_fitness_idx.1 && i != min_fitness_idx.1 {
                ranktemp.append(i)
            }
        }

        var rank_list = [Int]()
        if fitness[ranktemp[0]] > fitness[ranktemp[1]] {
            rank_list = [min_fitness_idx.1, ranktemp[1], ranktemp[0], max_fitness_idx.1]
        } else {
            rank_list = [min_fitness_idx.1, ranktemp[0], ranktemp[1], max_fitness_idx.1]
        }
        let updated_gene_list = simpleGa(gene_list, rank_list: rank_list)
        gene_list = updated_gene_list
    }
}

function()
