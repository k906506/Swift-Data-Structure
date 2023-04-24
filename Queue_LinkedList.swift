class Node<T> {
    var data: T
    var next: Node<T>?
    
    init(_ data: T) {
        self.data = data
    }
}

class Queue<T> {
    var front: Node<T>?
    var rear: Node<T>?
    
    public func enqueue(_ data: T) {
        let newNode = Node(data)
        
        if rear == nil { // 삽입은 rear, 삭제는 front
            front = newNode
            rear = newNode
        } else {
            rear?.next = newNode
            rear = newNode
        }
    }
    
    public func dequeue() -> T? {
        if let removedNode = front {
            front = removedNode.next
            
            if front == nil { // 원소가 없으면
                rear = nil
            }
            
            return removedNode.data
        } else {
            return nil
        }
    }
    
    public func peek() -> T? {
        return front?.data
    }
    
    public var isEmpty: Bool {
        return front == nil
    }
}

var queue = Queue<Int>()
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)
print(queue.peek()) // Optional(1)
print(queue.dequeue()) // Optional(1)
print(queue.dequeue()) // Optional(2)
print(queue.dequeue()) // Optional(3)
print(queue.dequeue()) // nil