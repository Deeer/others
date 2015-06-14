//: Playground - noun: a place where people can play

import UIKit

func swapTT<T> (inout a:T ,inout b:T )
{
    let tep = a
    a = b
    b = tep
}
var a:String =  "aaa"
var b:String = "bbb"

swapTT(&a, b: &b)
a
b


let string = "Hellow,Worlf"
print(string)

let subSTring  = string.componentsSeparatedByString(",")
print(subSTring)
for c in subSTring
{
    print(c)
}
let  string2:NSString = "hellow,world;dee;see"
let subString = string2.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString:";,"))
for sub in subString
{
    print(sub)
}

print(string2.substringFromIndex(2))
print(string2.substringToIndex(3))
print(string2.substringWithRange(NSMakeRange(2, 9)))

let string3:NSString =  "Apple;ios;swift;string;NSMutableString"
let rangForString = string3.rangeOfString("String")
print("\(rangForString):\(string3.substringWithRange(rangForString))")


let rangForSting2 = string3.rangeOfString("dee")

if rangForSting2.location == NSNotFound
{
    print("not found")
}else{
    print(rangForSting2)
}
let  rangForstr = string3.rangeOfString("string",options:NSStringCompareOptions.CaseInsensitiveSearch)
print(rangForstr)







