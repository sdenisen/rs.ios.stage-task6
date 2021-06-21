import Foundation

class CoronaClass {
 
    var seats = [Int]()
    let n: Int
    

     init(n: Int) {
        if n > 0 && n <= 100 {
            self.n = n
        } else {
            self.n = 0
        }
     }
     
     func seat() -> Int {
        var numOfSeat = 0

        if seats.isEmpty {
            numOfSeat = 0
            seats.append(0)
        } else if seats.count == n {
            numOfSeat = 0
        } else {
            numOfSeat = maxOfSeat()
            setToArray(seatNumber: numOfSeat)
        }
        
        return numOfSeat
     }
     
     func leave(_ p: Int) {
        if seats.contains(p) {
            if let index = seats.index(of: p) {
                seats.remove(at: index)
            }
        }
     }

    func indexOfArray(index: Int) -> Int {
        var index: Int = 0
        for (id, numberOfSeat) in seats.enumerated() {
            if index == numberOfSeat {
                index = id
            }
        }
        
        return index
    }

    func setToArray(seatNumber: Int) {
        var indexMax: Int = -1
        for (id, numberOfSeat) in seats.enumerated() {
            if seatNumber < numberOfSeat {
                indexMax = id
                break
            }
        }
        
        if indexMax == -1 {
            seats.append(seatNumber)
        } else {
            seats.insert(seatNumber, at: indexMax)
        }
    }

    func getMaxDistanation(a: Int?, b: Int?, c: Int?) -> Int? {
        var max: Int?
        if let aTmp = a {
            if let bTmp = b {
                if let cTmp = c {
                    max = aTmp > bTmp ? (cTmp < aTmp ? aTmp : cTmp) : (cTmp < bTmp ? bTmp : cTmp)
                }
                
            } else if let cTmp = c  {
                max = cTmp < aTmp ? aTmp : cTmp
            } else {
                max = aTmp
            }
        } else if let bTmp = b {
            if let cTmp = c  {
                max = cTmp < bTmp ? bTmp : cTmp
            } else {
                max = bTmp
            }
        } else if let cTmp = c  {
            max = cTmp
        } else {
            max = nil
        }

        return max
    }

    func maxOfSeat() -> Int {
        var index: Int = 0
        if seats.count == 1 {
            let numOfSeat = seats[0]
            if (numOfSeat - 0) < (n - numOfSeat) {
                index = n - 1
            } else {
                index = 0
            }
        } else {
            var seatsSpace = [Int]()
            
            for (index, number) in seats.enumerated() {
                if index != 0 {
                    seatsSpace.append((number - seats[index - 1])/2 == 0 ? 1 : (number - seats[index - 1])/2)
                }
            }
            
            var spaceFromMin: Int? = nil
            var spaceFromMax: Int? = nil
            if !seats.contains(0) {
                spaceFromMin = (seats[0] - 0)
            }
            
            if !seats.contains(n - 1) {
                spaceFromMax = (n - 1 - seats[seats.count - 1])
            }
            let maxFromArSpace = seatsSpace.max()
            
            if let maxSpace = getMaxDistanation(a: maxFromArSpace, b: spaceFromMin, c: spaceFromMax) {
                if maxSpace == spaceFromMin {
                    index = 0
                } else if maxSpace == maxFromArSpace {
                    var indexBefore = 0

                    for (i, number) in seats.enumerated() {
                        if i != 0 {
                            if ((number - seats[i - 1]) / 2 == 0 ? 1 : (number - seats[i - 1]) / 2) == maxSpace {
                                indexBefore = seats[i - 1]
                                if !seats.contains(indexBefore + maxSpace) {
                                    break
                                }
                            }
                        }
                    }

                    return indexBefore + maxSpace
                    
                } else {
                    index = n - 1
                }
            }
        }
        
        return index
    }
}
