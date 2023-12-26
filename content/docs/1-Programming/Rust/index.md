---
title: Rust
date: 2023-12-02
---

# Rust
This is a note from youtube video <https://www.youtube.com/watch?v=BpPEoZW5IiY>
## Goals
- Getting familiar with core concepts and syntax
- Data types and Data Structures
- Ownership and Borrowing
- Allocating data to memory and accessing data from memory
- Standard Library
- Generics, Traits, Lifetimes, and much more...

## Why learning Rust
- Fastest after C
- Rich type system
- Faster runtime (no garbage collector)
- Useful compiler output
- Memory safety
- Most beloved programming language since 2016 (Stack Overflow)
- Fast adoption in various branches

## Some Resources
- The rust programming language
- Rustlings: small exercises, debug
- Rust by Example: concise version of the book focusing on code, less text
- Rust by Practice: Covered in this course. <https://practice.rs/>
- Office web: <https://www.rust-lang.org>, go to `Playground`

## Compile and run
Compile

```rust
rustc <name.rs>
```

After compiling, it will create a binary with same name. Run it as binary file `./name`

## Cargo

```bash
cargo --version
cargo new <name_project>
```
Build 
```bash
cargo build
```

Run, target at `./target/debug/<binary_name>`

Build+run
```bash
cargo run
```

Check compile but not create executable, faster than build
```bash
cargo check
```

Build for release: compile with optimizations.
```bash
cargo build --release
```

## Hello world
`println!`

## Variables
- **Assigned** using `let` keyword
- `print!()` and `println!()` (with newline)
- **Scope** of a variable defined by the **block of code** in which it is declared
- **Function** is a named block of code that is **reusable**
- **Shadowing** allows a variable to be **re-declared** in the **same scope** with the **same name**


### Binding and mutability
- A variable can be used only if it has been initialized
```rust
let x: i32 = 5;
```
If uninitialized but also unused, there will be a warning.

- Use `mut` to mark a variable as mutable. By default, it is immutable

### Scope

A scope is the range within the program for which the item is valid

### Shadowing
You can declare a new variable with the same name as a previous variable. Hence, you can change the type of this variable as you want.

### Unused variable
Two ways to avoid warning:
- Add `_` before the variable when declaring
- Add `#[allow(unused_variables)]`

### Destructuring
In Rust 1.59 or higher, you can use a pattern with `let` to destructure a tuple to separate variables.
```rust
let (mut x,y) = (1,2);
(x,..) = (3,4);
[x,..] = (3,4);
```
## Basic types

### Number

- signed integer (positive and negative) started with `i`; unsigned integer (only positive) started with `u`.
  - 8-bit: i8, u8
  - 16-bit: i16, u16
  - 32-bit: i32, u32
  - 64-bit: i64, u64
  - 128-bit: i128, u128
  - arch: isize, usize
- Default types:
  - Integers: i32
  - Floats: f64

- Range of 8-bit
  - unsigned integers: 0-255
  - signed integers: -128 - 127
- Range of 16-bit
  - unsigned: 0-65'535
  - signed integers: -32768 - 32767

- Signed integers:Two's complement:
42 = 00101010
First, inverse each bit, we get 11010101. Then plus 1, we will get
-42 = 11010110

- arch: Architecture dependent. When on 32-bit architecture, usize and isize are corresponding to 32-bit
- word: read one word at a time from memory:
  - in 32-bit processor, it can access 4 bytes (32 bits) at a time
  - in 64-bit processor, it can access 8 bytes (64 bits) at a time

- Floating point
  - 32 bits: f32
  - 64 bits: f64
  - Representation according to IEEE-754 specification

- Can not assign an a type to another type. Example below shows errors since x and y are different types.
```rust
let x = 5;
let mut y:u32 = 6;
y=x;
```

- Can also directly tell the type by using `38_u8`. It means that 38 is a 8-bit unsigned integer.
- Can convert an integer from different type to other type:
```rust
let v:u16 = 38_u38 as u16;
```
- Some functions:
```rust
"u32".to_string();
let x = 5;
type_of(&x); //will be i32
let y = i8::MAX  // will be 127
let z = u8::MAX // will be 255
```

- Strange:
```rust
fn main(){
    assert!(0.1+0.2 == 0.3); //error
    assert!(0.1_f32 +0.2_f32 == 0.3_f32); //correct
    assert!(0.1 as f32 + 0.2 as f32 == 0.3 as f32); // correct

}
```

- For loop: 1..7 (not include 7); 1..=7 (include 7). print a character as number: `println!("{}",c as u8);`

- Boolean Operation: &&, ||, !
- Bitwise operations:
  - AND: &. Ex: 0b001u32 & 0b0101
  - OR: |. Ex: 0b0011u32 | 0b0101
  - XOR: ^. Ex: 0b0011u32 ^ 0b0101
  - left shift: <<. Ex: 1u32 << 5
  - right shift: >>. Ex: 0x80u32 >> 2


### Char, Bool, Unit
- `use std::mem::size_of_val;` returns size of value in bytes

```rust
use std::mem::size_of_val;
fn main(){
    let c1: char = 'a'; //4 bytes
    assert_eq!(size_of_val(&c1),4);
}
```

- `let t: bool = false && true;// false`
- Unit type: `()`. Empty tuple of size 0 bytes, used to return "nothing" in expressions or functions. Ex: if a function does not return anything, it will default return unit type

```rust
use std::mem::size_of_val
fn main() {
    let unit: () = ();
    assert!(size_of_val(&unit) ==0);
    println!("Success");
}
```
### Statement and Expression
- Statement
  - Instructions that perform some action but do not produce a value
  - Function definitions are statements, as well as code that ends with ";" (usually)
- Expression: Evaluate to a resultant value
```rust
let y= {
    let x = 1;
    x + 1+3+4  //no ; in the end. This will assign to 'y'
};
```
```rust
let z:() = {
    2*3; // The semi colon suppresses this expression and return nothing. `()` is assigned to 'z'
}
```
```rust
let t:() = {
    let mut x=1;
    x+=2   //even if there is no semicolon, t still is a unit type. x+=2 is a statement.
}
```

### Functioons
- Blocks of reusable code that performs a specific tasks
- Can take arguments, processes those inputs and returns a result
- Diverging functions: never return to the caller: panic, looping forever, quitting the program
- Function always need to annotate type of inputs

Never return functions:
```rust
fn never_return_fn() -> !{
    panic!()
    // other way is use unimplemented!() or todo!()
}
```

- `match`: returns to it latter. Only a much more powerful than if else.


## Ownership
### Ownership
- Unique to Rust.
- Set of rules that govern memory management
- Rules are enforced at compile time
- If any of the rules are violated, the program won't compile
- Three Rules of Ownership
  - Each value in Rust has an owner
  - There can only be one owner at a time
  - When the owner goes out of scope, the value will be dropped
- **Owner:** The owner of a value is the variable or data structure that holds it and is responsible for allocating and freeing the memory used to store that data
- **Scope:** Range within a program for which an item is valid
  - Global scope: Accessible throughout the entire program
  - Local scope:
    - Accessible only within particular function or block of code
    - Not accessible outside of that function or block
- Example:
```rust
{                       // s is not valid here, it's not declared yet
    let s = "hello";    // s is valid from this point forward. s is the owner of string "hello"
    // do something with s
} // this scope is now over, and s is no longer valid
//General rule: Scope ends where block of code ends (curly brackets)
```

### Memory
- Component in a computer to store data and instructions for the processor to execute
- Random access memory (RAM) is volatile, when power turned off all contents are lost
- Two types of regions in RAM used by a program at runtime: Stack memory and heap memory

#### Stack Memory
- Last in, first out
- All data stored on the stack must have a known, fixed size (like integers, floats, char, bool, etc...)
- Pushing to the stack is faster than allocating on the heap, because the location for new data is always at the top of the stack
- Types of unknown size will get allocated to the heap and a pointer to the value is pushed to the stack, because a pointer is fixed size (usize)

#### Heap memory
- Data of no known, fixed size belongs on the heap
- Allocating data on the heap will return a pointer (an address to location where data has been allocated)
- Allocating on the heap is slower than pushing to stack
- Accessing data on the heap is also slower, as it has to b e accessed using a pointer which points to an address
- Example: String type
  - String is mutable
  - String size can change at runtime
  - String stored on the stack with a pointer to the heap
  - Value of String is stored on the heap
  - `let s1 = String::from("Hello");` size of s1 will be 24 bytes (3*8) which contains:
    - ptr: pointer to data stored on the heap.
    - len: data size in bytes
    - capacity: total amount of memory received from the allocator

### Copy and Move
- Scalar values with fixed sizes will automatically get copied in the stack, copying here is cheap
- Dynamically sized data won't get copied, but moved, copying would be too expensive
- Example

```rust
let x = 5;
let y = x; //here the value of x will get copied into y and both variable are usable because i32 is fixed size

let s1 = String::from("Hello"); //s1 is just a pointer to data on the heap.
let s2 = s1 // just the pointer will get copied into s2. However since there is only one owner, s1 will be dropped and can not be used
```

- Deep copy:
```rust
let s1 =  String::from("hello");
let s2 = s1.clone();
```

### Ownership and Functions
```rust
fn main(){
    let s = String::from("hello");  // s comes into scope
    takes_ownership(s);             // s's value moves into the function
                                    // and so is no longer valid here
    let x = 5;                      // x comes into scope
    makes_copy(x);                  // x would move into the function,
                                    // but i32 is copy, so it's ok to still use x afterward
}                                   // Here, x goes out of scope, then s.

fn takes_ownership(some_string: String) { // some_string comes into scope
    println!("{}", some_string);
} // Here, some_string goes out of scope and 'drop' is called. The backing memory is freed.

fn makes_copy(some_integer: i32) { // some_integer comes into scope
    println!("{}", some_integer);
} // Here, some_integer goes out of scope.
```

another example
```rust
fn main(){
    let s1 = gives_ownership(); // s1 is the owner of string "Yours"
    let s2 = String::from("Hello"); // s2 is the owner of string "Hello"
    let s3 = takes_and_gives_back(s2); // s3 becomes the owner of "Hello" and s2 is dropped
}
fn gives_ownership() -> String {
    let some_string = String::from("Yours");
    some_string
}
fn takes_and_gives_back(a_string: String) -> String {
    a_string
}
```

#### Preventing issues
Ownership prevents memory safety issues:
- Dangling pointers
- Double-free
  - Trying to free memory that has already been freed
- Memory leaks
  - Not freeing memory that should have been freed

#### Exercies
- use `.clone()` for copying
- `.into_bytes()` method: consumes the String
- `.as_bytes`: does not consume the data
- Don't use clone, use copy instead. Below, we see that most parts of x are fixed sizes. We will use string litural (hardcode string at compile time, hence fixed size at compiled time)
```rust
fn main(){
    let x = (1,2,(),"hello".to_string());
    let y = x.clone();// dont use this. Instead let y: (i32, i32, (), &str) = x;
    println!("{:?}, {:?}", x, y);
}
```

#### Mutability can be changed when ownership is transferred
```rust
fn main() {
    let s:String = String::from("Hello");
    let mut s1 = s; // Here s1 takes the ownership and can be mutable
    s1.push_str(" world");
}
```
#### Box - allocate on the heap
- `Box::new(5)` allows to directly allocate on the heap
```rust
fn main(){
    let x: Box<i32> = Box::new(5);
    let mut y = Box::new(1); // we can change the value of y latter
    *y = 4; // dereference y using *
    assert_eq!(*x,5);
}
```
#### Partial move
Within the destructuring of a single variable, both by-move and by-reference pattern bindings can be used at the same time. Doing this will result in a partial move of the variable, which means that parts of the variable will be moved while other parts stay. In such a case, the parent variable cannot be used afterwards as a whole, however the parts that are only referenced (and not moved) can still be used.

```rust
fn main(){
    #[derive(Debug)]
    struct Person {
        name: String,
        age: Box<u8>,
    }
    
    let person = Person{
        name: String::from("Alice"),
        age: Box::new(20),
    }

    let Person{name, ref age} = person;
    // `name` is moved our of person, but `age` is referenced
    // `person` can not be used but `person.age` can be used as it is not moved
}
```
#### Accessing list
```rust
let t = (String::from("Hello"), String::from("world"));
let _s = t.0 // _s takes the ownership of "Hello". We can not access t anymore, but can still access t.1
```
### Borrowing
- Way of temporarily access data **without taking ownership** of it
- When borrowing, you're taking a **reference** (pointer) to the data, not the data itself
- Prevention of dangling pointers and data races
- Data can be borrowed **immutabily** and **mutably**
- There are certain rules when borrowing which we have to comply with, otherwise the program won't compile

#### Rules of references
- At any given time, you can have either **one mutable reference** or **any number** of **immutable references**
- References must **always be valid**