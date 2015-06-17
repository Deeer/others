//: Playground - noun: a place where people can play

import UIKit
let age = 3

assert(age >= 0 ,"dee")

let  defaultColor = "red"
var userDefinedColorName:String?
var colorNameToUse  =  userDefinedColorName ?? defaultColor

let spark = "\u{1f496}"
let balck = "\u{2665}"
let nk = "\u{2664}"
//for cha in 1...100
//{
//    
//    print( "\u{\(i)}" )
//    
//}
let e = "\u{e9}"
let d:Character = "\u{65}\u{301}"
let  da:String = "deawasdasdasdasdas"
da[da.startIndex]
da[da.endIndex.predecessor()]
da[da.startIndex.successor()]

let  qq = "\u{41}" //美式的A
let qw = "\u{0410}"//俄式的A
//两者不等

var threeDouble = [Double](count: 3, repeatedValue: 0.0)
var arr = ["A","B","C","D","E","F"]

arr [2...4] = ["dee","ss"]
var ud:Array<String> = ["a"]
var dds:Set<String> = ["b"]
var dic:Dictionary = [Int:String]()
var dic1:[String:String] = ["a":"a"]
var dic2 = ["a":"c"]
var arrss  = ["a","aa"]
var se:Set = ["a","d","c","b"]
var se1:Set = ["a","b","c"]
var ss:Set = [1,2,3,4]
var ss1:Set = [5,6]

ss.isDisjointWith(ss1)

se1.intersect(se)
se1.exclusiveOr(se)
se1.union(se)
se.subtract(se1)
se.sort()

se1.isDisjointWith(se)
se1.isSubsetOf(se)
se1.isSupersetOf(se)
se1.isStrictSupersetOf(se)
se1.isStrictSubsetOf(se)


