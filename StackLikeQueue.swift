struct StackLikeQueue<T> {
    private var enqueueDatas: [T] = []
    private var dequeueDatas: [T] = []
    
    public mutating func push(_ data: T) {
        enqueueDatas.append(data)
    }
    
    public mutating func pop() -> T? {
        // MARK: popLast는 Optional이므로 훨씬 간결하게 구현할 수 있다.
        if dequeueDatas.isEmpty { // dequeue Stack이 비어 있으면 enqueue Stack에서 데이터를 가져오는 로직 수행
            while let data = enqueueDatas.popLast() {
                dequeueDatas.append(data)
            }
        }
        
        return dequeueDatas.popLast()
        
//        if dequeueDatas.isEmpty { 
//            if enqueueDatas.isEmpty {
//                return nil
//            } else {
//                while !enqueueDatas.isEmpty {
//                    dequeueDatas.append(enqueueDatas.removeLast())
//                }
//                
//                return dequeueDatas.removeLast()
//            }
//        } else {
//            return dequeueDatas.removeLast()
//        }
        
    }
    
    public mutating func peek() -> T? {
        if dequeueDatas.isEmpty { // dequeue Stack이 비어 있으면 enqueue Stack에서 데이터를 가져오는 로직 수행
            while let data = enqueueDatas.popLast() {
                dequeueDatas.append(data)
            }
        } 
        
        return dequeueDatas.last
        
//        if dequeueDatas.isEmpty { 
//            if enqueueDatas.isEmpty {
//                return nil
//            } else {
//                while !enqueueDatas.isEmpty {
//                    dequeueDatas.append(enqueueDatas.removeLast())
//                }
//                
//                return dequeueDatas.last
//            }
//        } else {
//            return dequeueDatas.last
//        }
    }
    
    public var isEmpty: Bool {
        return enqueueDatas.isEmpty && dequeueDatas.isEmpty
    }
}

var stack = StackLikeQueue<Int>()
stack.push(1)
stack.push(2)
stack.push(3)
print(stack.peek()) // Optional(1)
print(stack.pop()) // Optional(1)
print(stack.pop()) // Optional(2)
print(stack.pop()) // Optional(3)
print(stack.pop()) // -> nil