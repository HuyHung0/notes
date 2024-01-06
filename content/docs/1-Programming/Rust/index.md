---
title: Rust
date: 2023-12-02
---
{{< expand "Table of contents">}}
- [Rust](#rust)
  - [Introduction](#introduction)
    - [Goals](#goals)
    - [Why learning Rust](#why-learning-rust)
    - [Some Resources](#some-resources)
  - [Getting started](#getting-started)
    - [`rustc` - compile and run](#rustc-compile-and-run)
    - [Cargo](#cargo)
    - [Guessing game](#guessing-game)
      - [Get user input](#get-user-input)
  - [Common concepts](#common-concepts)
    - [Variables and constants](#variables-and-constants)
      - [Immutable and Mutable](#immutable-and-mutable)
      - [Shadowing](#shadowing)
      - [Unused variable](#unused-variable)
    - [Data types](#data-types)
      - [Scalar types](#scalar-types)
        - [Integer types](#integer-types)
        - [Floating point](#floating-point)
        - [Operations](#operations)
        - [Character type](#character-type)
        - [Char, Bool, Unit](#char-bool-unit)
      - [Compound Types](#compound-types)
        - [Typle - unit](#typle-unit)
        - [Array - Vector](#array-vector)
    - [Functions - Statement -Expression](#functions-statement-expression)
      - [Functions](#functions)
      - [Statement and Expression](#statement-and-expression)
    - [Comments](#comments)
    - [Control Flow](#control-flow)
      - [`if` - `else if` -  `else`](#if-else-if-else)
      - [Loops- break - label](#loops-break-label)
      - [while](#while)
      - [for](#for)
  - [Practice](#practice)
    - [Convert Fahrenheit to Celsius](#convert-fahrenheit-to-celsius)
    - [Fibonacci](#fibonacci)
  - [Ownership - References - Borrowing - Slices](#ownership-references-borrowing-slices)
    - [The Stack and the Heap](#the-stack-and-the-heap)
      - [Stack Memory](#stack-memory)
      - [Heap memory](#heap-memory)
    - [Ownership](#ownership)
    - [Variable scope](#variable-scope)
    - [The String type](#the-string-type)
      - [Garbage collector (GC)](#garbage-collector-gc)
      - [Representation of String in Memory](#representation-of-string-in-memory)
      - [Variables and Data Interacting with Move](#variables-and-data-interacting-with-move)
      - [Variable and Data Interacting with Clone](#variable-and-data-interacting-with-clone)
      - [Stack-only data: Copy](#stack-only-data-copy)
    - [Ownership and Functions](#ownership-and-functions)
    - [Returning values and scope](#returning-values-and-scope)
    - [Ownership - Preventing issues](#ownership-preventing-issues)
    - [Exercies](#exercies)
      - [Mutability can be changed when ownership is transferred](#mutability-can-be-changed-when-ownership-is-transferred)
      - [Box - allocate on the heap](#box-allocate-on-the-heap)
      - [Partial move](#partial-move)
      - [Accessing list](#accessing-list)
    - [Borrowing](#borrowing)
      - [Rules of references](#rules-of-references)
      - [Examples of Borrowing rules](#examples-of-borrowing-rules)
      - [ref](#ref)
  - [Compound types](#compound-types-1)
    - [String](#string)
      - [Str and \&str - need review](#str-and-str-need-review)
  - [Some small things](#some-small-things)


{{</expand>}}
# Rust
This is a note from youtube video <https://www.youtube.com/watch?v=BpPEoZW5IiY>
and mixed with <https://doc.rust-lang.org/book/title-page.html>.

Link for the practices: <https://practice.rs/why-exercise.html>

## Introduction

### Goals
- Getting familiar with core concepts and syntax
- Data types and Data Structures
- Ownership and Borrowing
- Allocating data to memory and accessing data from memory
- Standard Library
- Generics, Traits, Lifetimes, and much more...

### Why learning Rust
- Fastest after C
- Rich type system
- Faster runtime (no garbage collector)
- Useful compiler output
- Memory safety
- Most beloved programming language since 2016 (Stack Overflow)
- Fast adoption in various branches

### Some Resources
- The rust programming language
- Rustlings: small exercises, debug
- Rust by Example: concise version of the book focusing on code, less text
- Rust by Practice: Covered in this course. <https://practice.rs/>
- Office web: <https://www.rust-lang.org>, go to `Playground`

## Getting started
### `rustc` - compile and run
Compile

```rust
rustc <name.rs>
```

After compiling, it will create a binary with same name. Run it as binary file `./name`

### Cargo

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

### Guessing game
#### Get user input
- The library is `use std::io;`
```rust
// Need to modify the Cargo.toml file to include the `rand` crate as a dependency
// [dependencies]
// rand = "0.8.5"


use rand::Rng;
use std::cmp::Ordering;
use std::io;

fn main() {
    println!("Guess the number!");

    let secret_number = rand::thread_rng().gen_range(1..=100);

    loop {
        println!("Please input your guess.");

        let mut guess = String::new();

        // take user input
        io::stdin()
            .read_line(&mut guess)
            .expect("Failed to read line");
        // Can be written in one line of code
        // io::stdin().read_line(&mut guess).expect("Failed to read line");

        let guess: u32 = match guess.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };
        // trim() eliminate any whitespace at the beginning and end (when user hits enter, it add newline character \n to the string input. We need to remove this \n)
        // parse(): converts a string to another type and need to tell exactly what type, it is u32. 

        println!("You guessed: {guess}");

        match guess.cmp(&secret_number) {
            Ordering::Less => println!("Too small!"),
            Ordering::Greater => println!("Too big!"),
            Ordering::Equal => {
                println!("You win!");
                break;
            }
        }
    }
}
```
## Common concepts
### Variables and constants
- Variables are assigned using `let` keyword. A variable can be used only if it has been initialized
```rust
let x: i32 = 5;
```
If uninitialized but also unused, there will be a warning.

- Constants are assigned using `const` keyword, can be declared in any scope, including the global scope. **Convention**: Uppercase with underscores between words.
```rust
const ABC_DEF: u32 = 60*60*3;
```

#### Immutable and Mutable
- By default, variables are immutable. To make them mutable, adding `mut` in front of the variable name.
- Constants are `always` immutable.

#### Shadowing
- **Shadowing** allows a variable to be **re-declared** in the **same scope** with the **same name**.
- You can declare a new variable with the same name as a previous variable. Hence, you can change the type of this variable as you want.

- By using `let` keyword, we can perform a few transformations on a value but have the variable be immutable after those transformations have been completed.

#### Unused variable
Two ways to avoid warning:
- Add `_` before the variable when declaring
- Add `#[allow(unused_variables)]`



### Data types
This session, we will covered the data types of fixed size. The data types of unknown size will be covered in the session about ownership.
#### Scalar types
- A scalar type represents a single value.
  - Integers
  - Floating-point numbers
  - Booleans
  - characters

##### Integer types
- Default types: `i32`
- Range: 0 to $2^n-1$ for unsigned; -(2^{n-1}) to 2^{n-1}-1 for signed.
- Signed integer (positive and negative) started with `i`; unsigned integer (only positive) started with `u`.
  - 8-bit: `i8`, `u8`
  - 16-bit: `i16`, `u16`
  - 32-bit: `i32`, `u32`
  - 64-bit: `i64`, `u64`
  - 128-bit: `i128`, `u128`
  - arch: `isize`, `usize`

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

- `arch`: Architecture dependent. When on 32-bit architecture, usize and isize are corresponding to 32-bit
- `word`: read one word at a time from memory:
  - in 32-bit processor, it can access 4 bytes (32 bits) at a time
  - in 64-bit processor, it can access 8 bytes (64 bits) at a time
##### Floating point
- Floating point
  - 32 bits: `f32`
  - 64 bits: `f64`
  - Representation according to IEEE-754 specification

- Default type is `f64`. The type `f32` is capable of more precision.
```rust
fn main(){
    assert!(0.1+0.2 == 0.3); //error
    assert!(0.1_f32 +0.2_f32 == 0.3_f32); //correct
    assert!(0.1 as f32 + 0.2 as f32 == 0.3 as f32); // correct
}
```

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

- For loop: 1..7 (not include 7); 1..=7 (include 7). print a character as number: `println!("{}",c as u8);`
##### Operations
- Numeric operations: `+`, `-`, `*`, `/`, `%`
- Boolean Operation: `&&`, `||`, `!`
- Bitwise operations:
  - AND: `&`. Ex: 0b001u32 & 0b0101
  - OR: `|`. Ex: 0b0011u32 | 0b0101
  - XOR: `^`. Ex: 0b0011u32 ^ 0b0101
  - left shift: `<<`. Ex: 1u32 << 5
  - right shift: `>>`. Ex: 0x80u32 >> 2

##### Character type
- We specify `char` with single quotes. For string, we use double quotes.
- `char` type is 4 bytes in size and represents a Unicode Scalar Value ranging from `U+0000` to `U+D7FF` and `U+E000` to `U+10FFFF`. 
- Example
```rust
fn main(){
    let c = 'z',
    let z:char = 'Z'
}
```
##### Char, Bool, Unit

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
#### Compound Types
##### Typle - unit
- A tuple: has a fixed length. Once declared, they cannot grow or shrink in size. We creating by using comma-separated inside parentheses. Example
```rust
let tup: (i32,f53,u8)=(500,6.4,1);
```
- In Rust 1.59 or higher, you can use a pattern with `let` to destructure a tuple to separate variables.
```rust
let (mut x,y) = (1,2);
(x,..) = (3,4);
[x,..] = (3,4);
```
- We can also use `.` followed by the index (starting from 0) of the value we want to access.
- Typle without any values is called `unit`.

##### Array - Vector
- Use comma-separated with square brackets.
```rust
let a=[1,2,3,4];
let b: [i32;5] = [1,2,3,4,5];
let c =[3;5]; //initialize the array
let first = a[0]; //accessing the array
```
- Arrays are useful when you want your data allocated on the stack rather than the heap or when you want to ensure you always have a fixed number of elements.
- A vector is a similar collection type provided by the standard library that is allowed to grow or shrink in size.

### Functions - Statement -Expression
#### Functions
- The `main` function: the entry point of many program
- `fn` keyword allows to declare a new function
- Convention style: snake case (function and variable names): all lowercase letter and underscores separate words
- Parameters: if have, you **must** declare the type of each parameter; separate parameters with commas
```rust
fn test(value:i32, unit_label: char){
    printlns!("it is {value}{unit_label}");
}
```
- Diverging functions: never return to the caller: panic, looping forever, quitting the program

- Never return functions:
```rust
fn never_return_fn() -> !{
    panic!()
    // other way is use unimplemented!() or todo!()
}
```

- `match`: returns to it latter. Only a much more powerful than if else.

#### Statement and Expression
- Statement: Instructions that perform some action and do not return a value
  - Function definitions are statements, as well as code that ends with ";" (usually)
- Expression: Evaluate to a resultant value
  - Calling a function is an expression
  - A new scope block created with curly brackets is an expression
  - Expression does not include ending semicolons. If we add semicolons, it will turn to a statement and it will then not return a value

```rust
let x = (let y = 6); //Error since statement does not return anything
```
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
### Comments
- Using `//`
- There is another kind of comment, documentation comments, which is discussed in <https://doc.rust-lang.org/book/ch14-02-publishing-to-crates-io.html>

### Control Flow

#### `if` - `else if` -  `else`
- Example
```rust
let number =3;
if number % 3 == 0 {
    println!("Some");
} else if  number % 3 == 1 {
    println!("thing");
} else {
    println!("happened");
}
```

- `if` in `let` statement
```rust
let condition = true;
let number = if condition {5} else {6}; //ok
println!("The value is {number}");
let number2 =  if condition {5} else {"six"}; //Error since two arms are not same types
```

#### Loops- break - label
- The `loop` keyword tells Rust to execute a block of code over and over again forever or until you explicitly tell it to stop.
- We can use `break` or `continue` to exit the loop or go to the next iteration
- Can return values from Loops using `break`
- Labels: start with single quote. For multi nested loops, if not specify label, the `break` will exit the inner loop only. With label, `break` can exit the outer loop
```rust
let mut counter = 0;
let result = loop {
    counter +=1;
    if counter == 10{
        break counter *2; // Return value from loops
    }
};
println!("The result is {result}");
```

```rust
let mut counter = 0;
'count: loop{
    println!("counter = {counter}");
    let mut remain = 10;
    loop {
        println!("remain = {remain}");
        if remain == 9{
            break;
        }
        if counter ==2 {
            break 'count;
        }
        remain -=1;
    }
    counter +=1;
}
println!("End counter = {counter}")
```
#### while
```rust
let mut number =3;
while number !=0 {
    println!("{number}");
    number -= 1;
}
println!("LIFTOFF");
```

#### for
```rust
let a =[1,2,3,4,5];
for element in a {
    println!("value {element}");
}

for number in (1..4).rev() {         // not include 4
    println!("{number}");
}
```

## Practice
### Convert Fahrenheit to Celsius
```rust
use std::io;

fn main() {
    println!("Convert temperature from Fahrenheit to Celsius");
    
    loop {
        println!("Please input a Fahrenheit degree:");
        let mut degree_f = String::new();

        io::stdin()
            .read_line(&mut degree_f)
            .expect("Failed to read line");

        let degree_f: f32 = match degree_f.trim().parse() {
            Ok(num) => num,
            Err(_) => {
                println!("Wrong input, please input a number");
                continue;
            }
        };

        println!("You enter: {degree_f} degree Fahrenheit");

        let degree_c: f32 = (degree_f - 32.0) * 5.0 / 9.0;

        println!("The result is: {degree_c} degree Celsius");

        
    }
}
```

### Fibonacci
```rust
// Generate the nth Fiboncacci number
use std::io;
fn main() {
    println!("Generate the nth Fiboncacci number");
    loop{
        println!("Enter the n_th number: ");
        let mut n_th = String::new();

        io::stdin().read_line(&mut n_th)
            .expect("Failed to read line");

        let n_th: u32 = match n_th.trim().parse(){
            Ok(num) => num,
            Err(_) => {
                println!("Wrong input ({n_th}). Please enter a number");
                continue;
            }
        };

        println!("You entered: {n_th}");

        println!("The {n_th}th Fiboncacci number is: {}", fibo(n_th));

    }
}

fn fibo(n: u32) -> u32{
    if n == 0{
        return 0;
    } 
    if n == 1{
        return 1;
    }
    fibo(n-1) + fibo(n-2)
}
```

## Ownership - References - Borrowing - Slices
- Unique to Rust, enables Rust to make memory safety guarantees without needing a garbage collector
- Related features: Borrowing, Slices and how Rust lays data out in memory

### The Stack and the Heap
- Memory: component in a computer to store data and instructions for the processor to execute
- Random access memory (RAM) is volatile, when power turned off all contents are lost
- Two types of regions in RAM used by a program at runtime: Stack memory and heap memory

#### Stack Memory
- Last in, first out
- All data stored on the stack **must have a known, fixed size** (like integers, floats, char, bool, etc...). Data with unknown size at compile time or a size that might change must be stored on the heap instead.
- Pushing to the stack is faster than allocating on the heap, because the allocator never has to search for a place to store new data. That location is always at the top of the stack.
- Types of unknown size will get allocated to the heap and a pointer to the value is pushed to the stack, because a pointer is fixed size (usize)
- When we call a function, the values passed into the function (including, potentially, pointers to data on the heap) and the function's local variables get pushed onto the stack. When the function is over, those values get popped off the stack.


#### Heap memory
- Data of no known, fixed size belongs on the heap
- Allocating data on the heap will return a pointer (an address to location where data has been allocated)
- Allocating on the heap is slower than pushing to stack
- Accessing data on the heap is also slower because you have to follow a pointer to get there
- Example: String type
  - String is mutable
  - String size can change at runtime
  - String stored on the stack with a pointer to the heap
  - Value of String is stored on the heap
  - `let s1 = String::from("Hello");` size of s1 will be 24 bytes (3*8) which contains:
    - ptr: pointer to data stored on the heap.
    - len: data size in bytes
    - capacity: total amount of memory received from the allocator

### Ownership
- Set of rules that govern memory management, are enforced at compile time
- If any of the rules are violated, the program won't compile
- Three Rules of Ownership
  - Each value in Rust has an owner
  - There can only be one owner at a time
  - When the owner goes out of scope, the value will be dropped

### Variable scope
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
### The String type
- Previous session, we covered types of a known size. We will now cover String type on the part that related to ownership. More on depth will be covered in the session about `common collections`.
- String literals: hardcoded string, immutable
- Second String type: manages data allocated on the heap, can be mutated

```rust
let mut s = String::from("hello"); // string allocated on the heap
s.push_str(", world"); // push_str() appends a literal to a String
println!("{}", s); // This will print `hello, world`
```

#### Garbage collector (GC)
- In languages with a GC, the GC keeps track and cleans up memory that isn't being used anymore, and we don't need to think about it.
- In languages without a GC, it's our responsibility to identify when memory is no longer being used and call code to explicitly return it, just as we did to request it.
- In Rust, the memory is automatically returned once the variable that owns it goes out of scope.

#### Representation of String in Memory
![Representation of String in Memory](images/trpl04-01.svg)
- A `String` is made up of three parts, shown on the left: a pointer to the memory that holds the contents of the string, a length, and a capacity. This group of data is stored on the stack.
  - The length is how much memory, in bytes, the contents of the String is currently using.
  - The capacity is the total amount of memory, in bytes, that the String has received from the allocator.
#### Variables and Data Interacting with Move
- Rust will never automatically create "deep" copies of your data. Therefore, any automatic copying can be assumed to be inexpensive in terms of runtime performance.
- Scalar values with fixed sizes will automatically get copied in the stack, copying here is cheap
- Dynamically sized data won't get copied, but moved, copying would be too expensive
- Example

```rust
let x = 5;
let y = x; //here the value of x will get copied into y and both variable are usable because i32 is fixed size

let s1 = String::from("Hello"); //s1 is just a pointer to data on the heap.
let s2 = s1 // just the pointer will get copied into s2. However since there is only one owner, s1 will be dropped and can not be used
```

- Explain in picture:

![Representation of String in Memory](images/trpl04-04.svg)

#### Variable and Data Interacting with Clone
```rust
let s1 = String::from("hello");
let s2 = s1.clone();

println!("s1 = {}, s2 = {}", s1, s2);
```
- Explain in picture:
![Representation of String in Memory](images/trpl04-03.svg)

- When we see a clone, we know that some arbitrary code is being executed and that code may be expensive.

#### Stack-only data: Copy
```rust
let x = 5;
let y = x;

println!("x = {}, y = {}", x, y);
```
Here, all variables are stored on the stack. There are no difference between deep and shallow copying here. Calling `clone` wouldn't do anything different.
- `Copy` trait: Rust will not let us annotate a type with `Copy`. As a general rule, any group of simple scalar values can implement `Copy`. Some of that types are
  - All the integer types, such as `u32`.
  - The Boolean type, `bool`, with values `true` and `false`.
  - All the floating point types, such as `f64`.
  - The character type, `char`.
  - Tuple if they only contain types that also implement `Copy`. For example, `(i32, i32)` implements `Copy`, but `(i32, String)` does not.


### Ownership and Functions
- The mechanics of passing a value to a function are similar to those when assigning a value to a variable. Passing a variable to a function will move or copy, just as assignment does. (move if data is on the heap, copy if data is on the stack)
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
### Returning values and scope
```rust
fn main() {
    let s1 = String::from("hello");

    let (s2, len) = calculate_length(s1);

    println!("The length of '{}' is {}.", s2, len);
}

fn calculate_length(s: String) -> (String, usize) {
    let length = s.len(); // len() returns the length of a String

    (s, length)
}
```
### Ownership - Preventing issues
Ownership prevents memory safety issues:
- Dangling pointers
- Double-free
  - Trying to free memory that has already been freed
- Memory leaks
  - Not freeing memory that should have been freed

### Exercies
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

#### Examples of Borrowing rules
- Example reference

```rust
fn main() {
    let s1 = String::from("hello"); // s1 is the owner of string
    let len = calculate_length(&s1); //&s1 is a pointer reference to s1
    println!("The length of '{}' is {}.", s1, len);
}
fn calculate_length(s: &String) -> usize {
    s.len()
}
```

- Example Mutable reference

```rust
fn main(){
    let mut s = String::from("hello");
    change(&mut s); // mutable reference
}
fn change(some_string: &mut String){
    some_string.push_str(", world");
}
```

- Example of borrowing rules

```rust
//Violate rules
let mut s = String::from("hello");

let r1 = &mut s;
let r2 = &mut s; // Violate the rule of borrowing. We can only have one mutable reference at a time
```

```rust
//ok
let mut s = String::from("hello");
{
    let r1 = &mut s;
}
let r2 = &mut s; //this is ok since r1 is out of scope and dropped
```

```rust
//Violate rules
let mut s = String::from("hello");

let r1 = &s;
let r2 = &s; //no problem, we can have any number of immutable reference

let r3 = &mut s; // Big problem, can not have both immutable and mutable reference
```

```rust
//ok
let mut s = String::from("hello");

let r1 = &s;
let r2 = &s;
println!("{} and {}", r1, r2); //after this, r1 and r2 will be dropped
let r3 = &mut s; //no problem since r1, r2 are dropped
println!("{}", r3);
```

- Example Dangling reference

```rust
//Violate rules
fn main(){
    let reference_to_nothing = dangle(); // after dangle, s is dropped. hence we return a reference to nothing (&s)
    // Second rule: references must always be valid
}
fn dangle() -> &String {
    let s = String::from("hello");
    &s
}
```

```rust
//ok
fn no_dangle() -> String{
    let s = String::from("hello");
    s
}
```

#### ref
`ref` can be used to take references to a value, similar to `&`
```rust
fn main(){
    let c: char = 'a';

    let r1: &char = &c;
    let ref r2 = c;
    assert_eq!(*r1,*r2);
}
```

## Compound types
### String
#### Str and &str - need review




## Some small things
```rust
println!("{:p}", p)// print the memory address of pointer p
```

.push_str("some words")
.push("!");

- `print!()` and `println!()` (with newline)
