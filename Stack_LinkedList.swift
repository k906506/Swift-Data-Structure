class Node<T> {
    var data: T
    var next: Node<T>?
    
    init(_ data: T) {
        self.data = data
    }
}

class Stack<T> {
    private var top: Node<T>?
    
    public func push(_ data: T) {
        let newNode = Node(data)
        
        if top == nil { // 노드가 하나도 없는 경우, 새로 들어온 노드를 top으로 지정
            top = newNode 
        } else { // 기존에 존재하는 노드를 next로, 새로 들어온 노드를 top으로 지정
            newNode.next = top
            top = newNode
        }
    }
    
    public func pop() -> T? {
        if let removedNode = top {
            top = removedNode.next // 다음 노드를 top 노드로 변경
            return removedNode.data
        } else { // 노드가 하나도 없는 경우
            return nil
        }
    }
    
    public func peek() -> T? {
        if let currentNode = top {
            return currentNode.data
        } else {
            return nil    
        }
    }
    
    public var isEmpty: Bool {
        return top == nil
    }
}

var stack = Stack<Int>()
stack.push(1)
stack.push(2)
stack.push(3)
print(stack.peek()) // Optional(3)
print(stack.pop()) // Optional(3)
print(stack.pop()) // Optional(2)
print(stack.pop()) // Optional(1)
print(stack.pop()) // -> nil