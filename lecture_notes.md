# Notes for Lectures

## Lecture 1:


## Lecture 2:


## Lecture 3:
### MVVM

Swift is serious about separation of **logic & data (MODEL)** from **ui (visual manifestation of the model)**
- SwiftUI takes care of making sure the UI gets rebuilt when model changes

So how would we connect the model to the UI?
1. Model could just be `@State` in a View (minimal separation)
2. Model accessible via a gatekeeper "View Model" class (full separation)
3. View Model class but model is still directly accessible (partial searation)

It depends on the complexity of the model:
- Simple data and little logic --> may opt for #1
- Logic required with lots of data manipulation --> #2 a better choice

> #2 = **M**odel-**V**iew-**V**iew**M**odel architecture -> **MVVM**
>
> This is the primary architecture for any reasonably
> complex SwiftUI application

![](images/mvvm1.png)

ViewModel provides the isolation between the Model (Logic & Data) and the View (UI)

![](images/mvvm2.png)

ViewModel also process the user's intent - will express that intent in the model and modifies the model:

![](images/mvvm3.png)

### Types
#### Struct & Class

- Pretty much the same syntax:
	- Store properties
	- Computed properties
	- Functions (methods)
	- Initialisers (Structs have a default one)

Structs are more commonly used in Swift. So what's the difference?

| struct                                                                                              | class                                                                                                                |
| --------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| Value type                                                                                          | Reference type                                                                                                       |
| Copied when passed or assigned<br><br>no single source of truth                                     | Passed around via pointers<br><br>shared single source of truth                                                      |
| Copy on write<br><br>only copies once changes are made i.e. copy doesn't immediately occur          | Automatically reference counted<br><br>keeps track of no. of pointers - when 0,  automatically cleans out memory     |
| Functional programming<br><br>Immutable data and pure functions - will always be provable i.e. work | Object-oriented programming<br><br>Sticks true to modelling real-world relationships via encapsulation & inheritance |
| No inheritance                                                                                      | Inheritance (single)                                                                                                 |
| "free" init initalises all `var`s                                                                   | "free" init initialises NO `var`s                                                                                    |
| Mutability is explicit (`var` vs `let`)                                                             | Always mutable                                                                                                       |
| Your "go to" data structure                                                                         | Used in specific circumstances                                                                                       |
| Everything seen so far is a `struct` (except `View` which is a protocol)                            | ViewModel in MVVM is always `class` - multiple pointers reference required                                           |

### Generics
**Type Agnostic** - sometimes we just down care about a data type, BUT Swift is a strongly-typed language (vars that are untyped are not used)

**How do we specify a type when we don't care what it is?** = Generics


> **EXAMPLE - Array**
> Arrays use a "don't care type":
> 
> `struct Array<Element>` - when someone uses Array, that's when `Element` get's decided
> 
> Essentially, Array uses a **Type Parameter** (aka a don't care type)

### `protocol`
- A stripped down struct/class
	- has functions and vars, but no implementation or storage

```swift
// EXAMPLE
protocol Moveable {
	func move(by: Int)
	var hasMoved: Bool { get }
	var distanceFromStart: Int { get set }
}
```
- Any type can now claim to implement the `protocol` 
	- `struct PortableThing: Moveable { ... }`
	- --> PortableThing conforms to / behaves like a Moveable
- Protocols can have inheritance
	- e.g. `protocol Vehicle: PortableThing { ... }` then `class Car: Vehicle { ... }`
	- Car must implement the funcs/vars in protocol moveable
- Multiple protocols can be implemented
	- e.g. `class Car: Vehicle, Impoundable, Leasable {...}`
	- Must now implement funcs/vars in Vehicle, Impoundable and Leasable protocols



#### What is it used for?
> N.B. a **PROTOCOL** is a **TYPE** (e.g. a var type or a return type)


Used to specify behaviours for a struct, class or enum
- CONSTRAINS & GAINS
- e.g. a View has to implement var body

Turns "don't cares" into "somewhat cares" using its constrains
- e.g. `struct Array<Element> where Element: Equatable`
- constrains the Element as an Equatable protocol

A way for a type (structs/classes/other protocols) to say what they are capable of + other code can demand certain behaviour out of another type
- neither side has to reveal the implmentation

Functional programming - not about how data structures are formed/stored, focus is on the **functionality** and **hiding the implementation details** behind it


### Functions as Types

A variable can be declared to be of type "function"
- Syntax: (TYPES) -> return value
```swift
(Int, Int) -> Bool    // takes two Ints, returns Bool
(Double) -> Void      // takes a Double, returns nothing
() -> Array<String>   // no argsd, returns Array of Strings
() -> Void            // no args, returns nothing (common)

// functions as types
var operation: (Double) -> Double    // assign operation as type function

// specify a function with the same type-ing
func square(operand: Double) -> Double {
	return operand * operand
}

operation = square    // assign value to operation
operation(4)   // would return 16!
```

Closures - equivalent to inline function types
- i.e. passing a function as an inline type
- used a lot
