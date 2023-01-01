//
//  main.swift
//  contest-t
//
//  Created by Anvar Rahimov on 09.12.2022.
//

import Foundation


























// MARK: 1 - swift
/*
var n = Int(readLine()!)

var line = readLine()!
var colors = readLine()!


var words = Array(line.split(separator: " "))
var cols = Array(colors)

var schemes = [[Character]]()
var scheme = [Character]()
for word in words {
    for letter in word {
        scheme.append(cols.removeFirst())
    }
    schemes.append(scheme)
    scheme = []
}

var counter = 0
for scheme in schemes {
    for i in 1..<scheme.count {
        if scheme[i - 1] == scheme[i] {
            counter += 1
            break
        }
    }
}
print(counter)
*/

// MARK: 3 - python
/*
def res(X):
    if X % 2 != 0:
        A = X / 2
        B = X / 2 + 1
    else:
        if (X / 2) % 2 == 0:
            A = X / 2 - 1
            B = X / 2 + 1
        else:
            A = X / 2 - 2
            B = X / 2 + 2
    print(int(A), int(B), end=" ")



x = int(input())

res(x)
*/


// MARK: 6 - python
/*
 def max_xor(arr, n):
     maxXor = 0
     for i in range(n):
         for j in range(i + 1, n):
             maxXor = max(maxXor,\
                          arr[i] ^ arr[j])
  
     return maxXor
  

 n = int(input())
 numbers = []
 for i in range(n):
     num = int(input())
     if num not in numbers:
         numbers.append(num)
     print(max_xor(numbers, len(numbers)))
 */
