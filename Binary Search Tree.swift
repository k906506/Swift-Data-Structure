class Node<T: Comparable> {
    var value: T
    var leftChild: Node?
    var rightChild: Node?
    
    init(value: T) {
        self.value = value
    }
}

class BinarySearchTree<T: Comparable> {
    private var root: Node<T>? // 루트 노드를 직접 변경할 수 없음
    
    public var isEmpty: Bool {
        return root == nil
    }
    
    public func getRoot() -> Node<T>? {
        return isEmpty ? nil : root
    }
    
    func insert(value: T) {
        guard let root else { // 루트 노드가 없으면, 현재 노드를 루트 노드로 추가
            root = Node(value: value)
            return
        }
        
        var rootNode = root // root가 let이므로 직접 변경할 수 없음 (class로 구현했으므로 같은 주소를 참조하고 있음)
        
        while true {
            if rootNode.value > value { // 루트 노드가 값이 더 크면, 왼쪽 서브 트리로 이동
                if let leftChild = rootNode.leftChild { // 왼쪽 서브 트리가 있다면, 해당 서브 트리로 이동
                    rootNode = leftChild // 재탐색을 위해 왼쪽 서브 트리의 부모 노드를 현재 노드로 변경
                } else { // 왼쪽 서브 트리가 없다면, 왼쪽 서브 트리에 현재 노드를 추가
                    rootNode.leftChild = Node(value: value)
                    return
                }
            } else { // 루트 노드보다 현재 노드가 더 크면, 오른쪽 서브 트리로 이동
                if let rightChild = rootNode.rightChild { // 오른쪽 서브 트리가 있다면, 해당 서브 트리로 이동
                    rootNode = rightChild // 재탐색을 위해 오른쪽 서브 트리의 부모 노드를 현재 노드로 변경
                } else { // 오른쪽 서브 트리가 없다면, 오른쪽 서브 트리에 현재 노드를 추가
                    rootNode.rightChild = Node(value: value)
                    return
                }
            }
        }
    }
    
    
    /// 삭제는 총 세 가지 경우가 존재
    func remove(value: T) -> T? {
        guard let root else { return nil } // 루트 노드가 없으면 nil을 반환
        
        var rootNode = root
        var childNode: Node<T>? = root
        
        while let currentNode = childNode {
            if currentNode.value == value { break } // 찾았으면 탐색 종료
            
            if currentNode.value > value {
                childNode = currentNode.leftChild
            } else {
                childNode = currentNode.rightChild
            }
            
            rootNode = currentNode
        }
        
        guard let childNode else { return nil } // 삭제하려는 노드가 없으면 nil을 반환
        
        // 1. 삭제하려는 노드가 리프 노드인 경우
        if childNode.leftChild == nil, childNode.rightChild == nil {
            if rootNode.value > value {
                rootNode.leftChild = nil
            } else {
                rootNode.rightChild = nil
            }
            
            return childNode.value
        }
        
        // 2. 삭제하려는 노드가 다른 서브 트리의 부모 노드인 경우 (자식을 한 개 갖고 있는 경우)
        if childNode.leftChild != nil, childNode.rightChild == nil { // 삭제하려는 노드의 왼쪽 서브 트리가 있는 경우
            if rootNode.value > value {
                rootNode.leftChild = childNode.leftChild // 부모 노드의 왼쪽 서브 트리에 연결
            } else {
                rootNode.rightChild = childNode.leftChild // 부모 노드의 오른쪽 서브 트리에 연결
            }
            
            return childNode.value
        } else if childNode.leftChild == nil, childNode.rightChild != nil { // 삭제하려는 노드의 오른쪽 서브 트리가 있는 경우
            if rootNode.value > value {
                rootNode.leftChild = childNode.rightChild // 부모 노드의 왼쪽 서브 트리에 연결
            } else {
                rootNode.rightChild = childNode.rightChild // 부모 노드의 왼쪽 서브 트리에 연결
            }
            
            return childNode.value
        }
        
        // 3. 삭제하려는 노드가 왼쪽, 오른쪽 서브 트리를 모두 갖고 있는 경우
        // ✅ 3.1 삭제하려는 노드의 왼쪽 서브 트리 중에서 가장 큰 값 (왼쪽 서브 트리의 가장 오른쪽 값)과 교체
        // 3.2 삭제하려는 노드의 오른쪽 서비 트리 중에서 가장 작은 값 (오른쪽 서브 트리의 가장 왼쪽 값)과 교체
        guard let leftChild = childNode.leftChild else { return nil }
        
        var willChangeNode = leftChild // 삭제하려는 노드의 자리에 들어갈 노드
        var rootOfwillChangeNode = leftChild // willChangeNode의 부모 노드
        
        while let currentNode = willChangeNode.rightChild { // 왼쪽 서브 트리 중에서 가장 큰 값(가장 오른쪽 값)을 탐색
            rootOfwillChangeNode = willChangeNode
            willChangeNode = currentNode
        }
        
        // 삭제된 자리에 들어갈 노드가 서브 트리를 갖고 있는 경우
        if let childNode = willChangeNode.leftChild {
            rootOfwillChangeNode.rightChild = childNode
        } else {
            rootOfwillChangeNode.rightChild = nil
        }
        
        // 삭제된 자리에 새로운 노드로 교체
        if rootNode.value > value {
            rootNode.leftChild = willChangeNode
            
            //교체된 노드에 삭제하려는 노드의 오른쪽 서브트리를 연결
            willChangeNode.rightChild = childNode.rightChild
        } else if rootNode.value < value {
            rootNode.rightChild = willChangeNode
            
            //교체된 노드에 삭제하려는 노드의 오른쪽 서브트리를 연결
            willChangeNode.rightChild = childNode.rightChild
        } else { // 루트 노드를 제거하려는 경우
            rootNode.value = willChangeNode.value
        }
        
        return childNode.value
    }
}

final class BSTManager {
    static let shared = BSTManager()
    
    private init() {}
    
    /// 부모 노드 -> 왼쪽 서브 트리 -> 오른쪽 서브 트리
    func PreOrder(_ node: Node<Int>?) {
        guard let node else { return }
        
        print(node.value, terminator: " ")
        if (node.leftChild != nil) { PreOrder(node.leftChild) }
        if (node.rightChild != nil) { PreOrder(node.rightChild) }
    }
    
    /// 왼쪽 서브 트리 -> 부모 노드 -> 오른쪽 서브 트리
    func InOrder(_ node: Node<Int>?) {
        guard let node else { return }
        
        if (node.leftChild != nil) { InOrder(node.leftChild) }
        print(node.value, terminator: " ")
        if (node.rightChild != nil) { InOrder(node.rightChild) }
    }
    
    /// 왼쪽 서브 트리 -> 오른쪽 서브 트리 -> 부모 노드
    func PostOrder(_ node: Node<Int>?) {
        guard let node else { return }
        
        if (node.leftChild != nil) { PostOrder(node.leftChild) }
        if (node.rightChild != nil) { PostOrder(node.rightChild) }
        print(node.value, terminator: " ")
    }
}

let binarySearchTree = BinarySearchTree<Int>()
binarySearchTree.insert(value: 7)
binarySearchTree.insert(value: 1)
binarySearchTree.insert(value: 8)
binarySearchTree.insert(value: 0)
binarySearchTree.insert(value: 3)
binarySearchTree.insert(value: 2)
binarySearchTree.insert(value: 5)
binarySearchTree.insert(value: 4)
binarySearchTree.insert(value: 6)
binarySearchTree.insert(value: 10)
binarySearchTree.insert(value: 9)
binarySearchTree.insert(value: 11)

let root = binarySearchTree.getRoot()

BSTManager.shared.PreOrder(root) // 7 1 0 3 2 5 4 6 8 10 9 11
print("")
BSTManager.shared.InOrder(root) // 0 1 2 3 4 5 6 7 8 9 10 11
print("")
BSTManager.shared.PostOrder(root) // 0 2 4 6 5 3 1 9 11 10 8 7
print("")

print(binarySearchTree.remove(value: 7))
BSTManager.shared.PreOrder(root)
print("")

print(binarySearchTree.remove(value: 6))
BSTManager.shared.PreOrder(root)
print("")

print(binarySearchTree.remove(value: 3))
BSTManager.shared.PreOrder(root)
print("")