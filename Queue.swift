struct Queue<T> {
    private var queue: [T] = []
    
    public var count: Int {
        return queue.count
    }
    
    public var isEmpty: Bool {
        return queue.isEmpty
    }
    
    public func peek() -> T? {
        return queue.first
    }
    
    public mutating func enqueue(_ element: T) {
        queue.append(element)
    }
    
    /// isEmpty인 경우 nil을 반환
    public mutating func dequeue() -> T? {
        return isEmpty ? nil : queue.removeFirst()
    }
}

var queue = Queue<Int>()

queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)
print(queue)

print(queue.dequeue()) // 3
print(queue.dequeue()) // 2
print(queue.dequeue()) // 1
print(queue.dequeue()) // nli
print(queue)
