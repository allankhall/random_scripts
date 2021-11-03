class ListNode:
    def __init__(self,data):
        self.data = data
        self.next = None 

class TreeNode:
    def __init__(self,data):
        self.data = data
        self.left = None
        self.right = None

class Queue:
    def __init__(self):
        self.head = None
        self.tail = None

    def enqueue(self,data):
        node = ListNode(data)
        if self.head == None:
            self.head = node
            self.tail = node
        else :
            self.tail.next = node
            self.tail = node

    def dequeue(self):
        if self.head == None:
            return None
        else:
            returnData = self.head.data
            self.head = self.head.next
            if self.head == None:
                self.tail = None
            return returnData 
        
class Stack:
    def __init__(self):
        self.head = None
 
    def push(self,data):
        node = ListNode(data)
        if self.head == None:
            self.head = node
        else:
            node.next = self.head
            self.head = node

    def pop(self):
        if self.head == None:
            return None
        else:
            returnData = self.head.data
            self.head = self.head.next
            return returnData

def printTreeRecursive(node):
    if node == None:
        return
    else:
       printTreeRecursive(node.left)
       print(node.data)
       printTreeRecursive(node.right)

def printTreeIterative(node):
    if node == None:
        return
    stack = Stack()
    stack.push(node)
    while stack.head != None:
        current = stack.pop()
        print(current.data)
        if current.left != None:
            stack.push(current.left)
        if current.right != None:
            stack.push(current.right)

"""
    1
   / \
  2   5
 / \
3   4
"""
n1 = TreeNode(1)
n2 = TreeNode(2)
n3 = TreeNode(3)
n4 = TreeNode(4)
n5 = TreeNode(5)

n1.left = n2
n1.right = n5
n2.left = n3
n2.right = n4

print("print tree recursive")
printTreeRecursive(n1)
print("print tree iterative")
printTreeIterative(n1)
