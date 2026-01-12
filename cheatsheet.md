# Ruby and Ruby on Rails Cheatsheet to be dangerous
## Theorical
## Object Oriented Pillars
- **Inheritance**: From one parent class to a child one, capacity  transmit the same methods and attributes. 
    - Real-Life Example: 
        ```
        class User
            def name
                return name
            end
            def email
                return email
            end
        end
        class Employee < User
            def ssn
                return ssn
            end  
        end 
        emp_new = Employee.new
        puts emp_new.email <-- attributes inherited from User
        puts emp_new.ssn  <-- own attributes
        ```
- **Encapsulation**: Restrict the level access level of an object or class
- **Polymorphism**: Capability of the same method to respond differently through different objects, in ruby by duck typing and inheritance. Inherite method and overriding in the child class me
- **Abstraction**: Hide the attributes and methods of a Class and expose the ones need to its functionality 

## SOLID principles
- **Single Responsability**: Classes should not contain multiple responsability or purpose
- **Open for extension and close for modification**: 
- **Liskov subst principle**: Objects of a super class can be replaced for objects of its subclasses

*Example* 
```
user_new = User.new <-- superclass instance
puts user_new.name <-- works  
user_new = Employee.new <-- replaced by subclass instance
puts user_new.name <-- still works as inherate parent attr: name
```
- **Interface segregation**: Methods, objects should Not depend of interaces or expecting params not used 
- **Dependency Inversion**: Classes should depend on abstraction but not on concretion

## Ruby Naming Convention
- Class: CamelCaseClass 
- Localvariables/methods: snake_case 
- Constants: UPPER_CASE

## Access Modifiers
- Private: class    
- Protected: class, subclass
- Public: class, subclass, instance

## Variables
- local
- @instance
- @@class
- $global 

## Class constructor
- The class constructor initialize by 
```
class User
    attr_accessor :name, :email  
    def initialize(name, email)
        @name  = name 
        @email = email
    end
end
```
## Define an instance and class method 
```
Class User
    attr_accessor :name, :email, :day_of_birth 
    def initialize(name, email, day_of_birth)
        @name  = name 
        @email = email
        @day_of_birth = day_of_birth 
    end
#Instance method
    def age
        return (today()-day_of_birth).to_years
    end
#class method
    def self.dummy()
        new(Factory.Name,Factory.email,Factory.past_date.years_back(23))
    end
end

```
## Include and Require
- Require used to run another .rb file, often use it in module. include takes all methods from another module and include them this is used to extend things like  *mixings (see bellow)*
## Concerns

##  Caching
## Polymorphic Associations
## Modules
- Module is a set of methods and variables or attributes to be re-used across al the code, similar to a Class but can't be instantiated
- Can be used by required them => 'require ./my_module.rb' or including them => 'include MyModule'
```
module MyModule
    name = 'MyModule' 
    def what_is
        put "A set of methods and variables or attributes"
    end
end
MyModule::name 
MyModule.what_is
```
### Real life use case: mixings
- Sharing a centralized behavior:searchable across Rails Models 
```
# app/concerns/searchable.rb
module Searchable
    extend ActiveSupport::Concern
    def search(query)
        where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", "%#{query.downcase}%")
    end
end

# app/models/Event.rb
class Event < ApplicationRecord
    include Searchable
end

events = Event.search("music");  
```    

## Big-O N notation.
- N notation is to measure the worst-case scenario for an algorithm, normally the max time or space used. Searching in an array is O(n) n is the same element
- Rails Real-life example: **n+1 query** - **Big O: O(N)^2**
    - This happens when accessing to nested models like this, this will create a N additinal query each event  
    ```
        events = Event.All;
        evens.each |event| do
            puts event.attendants.count
        end
    ```
    - How to avoid them:
        - this will be in a single query 
    ```
    event = Event.include(:attendants).all

    ```            
        - This will raise an error on accesing associated resources 
    ```
    Event.strict_loading = true
    ```       


## Singleton Method, Class, pattern...
Singleton method declarated in a single instance, a singleton Class, a class made to instantiate a single object, that will be act a single point of access for the class code. this used normally in some configuration you can share across the project

- Real-Life Rails example 
```
c
def self.class_method

end
```


## Multi-inheritance
- In ruby you can't multi-inherit directly but you can create the same effect by using mixings


## Yield

## One-line Loops (:inject, :accumulate )


## Associations
- has_many:
- belongs_to:
- has_and_belongs_to

## Garbage collector
## Meta-programming
In  ruby everything 

## Practical
### Even and Numbers :D
### Fibonacci :) 
#### Newbie ways
```
# Big O: O(n)
# 0,1,1,2,3,5,8,13,21,34,55
limit = 10
arr = [0, 1] 
for i in 0..limit do
    if i>1 
        arr <<  arr[i-1] + arr[i-2] 
    end
end
puts arr
```
#### Recursive way :|
```
#### IN PROGRESS
$limit = 10
def fibo(i)
    if i < 2
        returns 0
    elsif < 2
        returns 1
    else 
        res = fibo(i-1) + fibo(i-2)
    end
end
fibo(10)
```
### Recursive :|
```
# Average recursion
arr = [10,9,8,9,7,10,9]
def avg(arr, sum=0, i=0)    
    return sum.to_f/arr.size if i == arr.size
    avg(arr,(sum + arr[i]),i+1);
end
puts avg(arr)

# Average Accumulator alternative
puts arr.inject { |sum, n|  sum + n }.to_f / arr.size
```

### QuickSort :(
### Binary search tree :C

