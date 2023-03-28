struct Stack<T> {
    private var stack: [T] = []
    
    public var count: Int {
        return stack.count
    }
    
    public var isEmpty: Bool {
        return stack.isEmpty
    }
    
    public mutating func push(_ element: T) {
        stack.append(element)
    }
    
    /// isEmpty인 경우 nil을 반환
    public mutating func pop() -> T? {
        return stack.popLast()
        
        // MARK: removeLast는 Optional이 아니므로 isEmpty에서 removeLast를 하면 Exception 발생
        // isEmtpy를 확인하는 추가적인 조건이 필요
        // return isEmpty ? nil : stack.removeLast()
    }
}

var stack = Stack<Int>()

stack.push(1)
stack.push(2)
stack.push(3)
print(stack)

print(stack.pop()) // 3
print(stack.pop()) // 2
print(stack.pop()) // 1
print(stack.pop()) // nli
print(stack)
