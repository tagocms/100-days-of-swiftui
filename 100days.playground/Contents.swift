@propertyWrapper
struct NonNegative<Value: BinaryInteger> {
    var value: Value
    
    init(wrappedValue: Value) {
        self.value = Self.calculateValue(wrappedValue)
    }
    
    var wrappedValue: Value {
        get { value }
        set {
            self.value = Self.calculateValue(newValue)
        }
    }
    
    static func calculateValue(_ newValue: Value) -> Value {
        if newValue < 0 {
            return 0
        } else {
            return newValue
        }
    }
}

struct User {
    @NonNegative private var age: Int
    private var name: String
    
    init(age: Int, name: String) {
        self.age = age
        self.name = name
    }
    
    func printUser() {
        print("Name: \(name), Age: \(age)")
    }
}


for i in 0..<3 {
    let user = User(age: i, name: "John \(i)")
    user.printUser()
}


var exampleValue = NonNegative(wrappedValue: 10)
print("Example Value before: \(exampleValue.wrappedValue)")
exampleValue.wrappedValue -= 100
print("Example Value after: \(exampleValue.wrappedValue)")
