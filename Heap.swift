struct Heap<T: Comparable> {
    private var heap: [T] = []
    
    public func getHeap() -> [T] {
        return heap
    }
    
    public var isEmpty: Bool {
        return heap.isEmpty
    }
    
    /// 힙에 원소를 추가하는 메서드
    public mutating func insert(_ element: T) {
        if heap.count == 0 { // 1번째 인덱스부터 탐색하기 위해 0번째 인덱스를 강제로 채워넣음
            heap.append(element)
            heap.append(element)
            return
        }
        
        heap.append(element) // 배열의 마지막에 원소를 추가
        
        // 부모 노드와 비교하고, 추가한 원소가 더 큰 경우에는 swap을 진행 (Bottom - Up 방식)
        var index = heap.count - 1
        
        while index > 1, heap[index / 2] < heap[index] {
            heap.swapAt(index, index / 2) // 부모 노드와 현재 노드를 swap
            index /= 2 // 부모 노드의 위치로 포인터 이동
        }
    }
    
    /// 힙에서 원소를 제거하는 메서드
    /// - 첫 번째 인덱스의 원소를 제거하고, 마지막 인덱스의 원소를 첫 번째 인덱스로 이동 (최대 힙일 경우, 가장 작은 원소가 맨 앞으로 오게 됨)
    /// - 자식 노드들과 비교하면서 이동이 불가능해질 때까지 이동
    public mutating func remove() -> T? {
        if heap.count > 1 {
            heap.swapAt(1, heap.count - 1) // 첫 번째 원소와 마지막 원소를 swap
            
            let removedElement = heap.removeLast()
            
            var parentIndex = 1
            var childIndex = parentIndex * 2
            
            while childIndex <= heap.count - 1{
                // 왼쪽, 오른쪽 자식 노드가 모두 존재할 경우, 더 큰 자식 노드로 교체
                if childIndex < heap.count - 1, heap[childIndex + 1] > heap[childIndex] {
                    childIndex += 1
                }
                
                // 더 큰 자식 노드보다 부모 노드가 크다면 종료
                if heap[childIndex] < heap[parentIndex] {
                    break
                }
                
                // 더 큰 자식 노드가 부모 노드보다 크다면 재탐색을 위해 교체
                parentIndex = childIndex
                childIndex *= 2
            }
            
            heap.swapAt(1, parentIndex) // 첫 번째 원소(가장 작은 원소)와 가장 큰 원소를 swap
            
            return removedElement
        } else {
            return nil
        }
    }
}

var heap = Heap<Int>()

for _ in 0..<10 {
    heap.insert(Int.random(in: 0..<100))
}

print(heap.getHeap())
print()

for _ in 0..<10 {
    let removedElement = heap.remove()
    print("제거된 원소는 \(removedElement)입니다.\n현재 힙의 상태는 \(heap.getHeap())", terminator: "\n\n")
}