### 1. Introduction to Python
- **High-level Language**: Python is an interpreted, high-level, general-purpose programming language.
- **Readability**: Python emphasizes readability and simplicity.
- **Interpreted Language**: Python code is executed line by line, making debugging easier.

### 2. Python Basics
- **Comments**: Use `#` for single-line comments and `'''` or `"""` for multi-line comments.
  ```python
  # This is a single-line comment
  """
  This is a
  multi-line comment
  """
  ```

- **Variables and Data Types**:
  - **Numbers**: `int`, `float`
  - **Strings**: Sequence of characters, enclosed in single or double quotes.
  - **Booleans**: `True` or `False`
  ```python
  x = 10          # int
  y = 3.14        # float
  name = "Alice"  # string
  is_active = True  # boolean
  ```

### 3. Basic Operations
- **Arithmetic Operators**: `+`, `-`, `*`, `/`, `%` (modulus), `**` (exponentiation), `//` (floor division)
  ```python
  a = 5
  b = 2
  print(a + b)  # 7
  print(a - b)  # 3
  print(a * b)  # 10
  print(a / b)  # 2.5
  print(a % b)  # 1
  print(a ** b) # 25
  print(a // b) # 2
  ```

### 4. Strings
- **Concatenation**: `+`
- **Repetition**: `*`
- **Indexing**: Starts from `0`
- **Slicing**: `[start:stop:step]`
  ```python
  str1 = "Hello"
  str2 = "World"
  print(str1 + " " + str2)  # Hello World
  print(str1 * 3)           # HelloHelloHello
  print(str1[1])            # e
  print(str1[1:4])          # ell
  print(str1[::-1])         # olleH
  ```

### 5. Lists
- **List Creation**: Ordered, mutable collection of items.
  ```python
  my_list = [1, 2, 3, 4, 5]
  print(my_list)
  ```

- **List Operations**:
  - Append: `my_list.append(item)`
  - Insert: `my_list.insert(index, item)`
  - Remove: `my_list.remove(item)`
  - Pop: `my_list.pop(index)`
  - Indexing and Slicing similar to strings.
  ```python
  my_list.append(6)
  print(my_list)  # [1, 2, 3, 4, 5, 6]
  my_list.insert(2, 2.5)
  print(my_list)  # [1, 2, 2.5, 3, 4, 5, 6]
  my_list.remove(2.5)
  print(my_list)  # [1, 2, 3, 4, 5, 6]
  print(my_list.pop(3))  # 4
  print(my_list)  # [1, 2, 3, 5, 6]
  ```

### 6. Tuples
- **Tuple Creation**: Ordered, immutable collection of items.
  ```python
  my_tuple = (1, 2, 3, 4, 5)
  print(my_tuple)
  ```
- **Tuple Operations**: Similar to lists but cannot modify.
  ```python
  print(my_tuple[1])  # 2
  print(my_tuple[1:4])  # (2, 3, 4)
  ```

### 7. Dictionaries
- **Dictionary Creation**: Unordered, mutable collection of key-value pairs.
  ```python
  my_dict = {"name": "Alice", "age": 25, "city": "New York"}
  print(my_dict)
  ```

- **Dictionary Operations**:
  - Access: `my_dict[key]`
  - Add/Update: `my_dict[key] = value`
  - Remove: `del my_dict[key]`
  ```python
  print(my_dict["name"])  # Alice
  my_dict["age"] = 26
  print(my_dict)  # {'name': 'Alice', 'age': 26, 'city': 'New York'}
  del my_dict["city"]
  print(my_dict)  # {'name': 'Alice', 'age': 26}
  ```

### 8. Control Structures
- **If-Else Statements**:
  ```python
  if condition:
      # code block
  elif condition:
      # code block
  else:
      # code block
  ```

- **For Loop**:
  ```python
  for item in iterable:
      # code block
  ```

- **While Loop**:
  ```python
  while condition:
      # code block
  ```

### 9. Functions
- **Function Definition**:
  ```python
  def function_name(parameters):
      # code block
      return value
  ```

- **Function Call**:
  ```python
  def greet(name):
      return f"Hello, {name}!"

  print(greet("Alice"))  # Hello, Alice!
  ```

### 10. Modules and Packages
- **Importing Modules**:
  ```python
  import module_name
  from module_name import function_name
  import module_name as alias
  ```

- **Example 1**:
  ```python
  import math
  print(math.sqrt(16))  # 4.0
  from math import pi
  print(pi)  # 3.141592653589793
  ```
  - **Example 2**:
``` bash
import boto3

# Create an S3 client
s3 = boto3.client('s3')

# List all buckets
response = s3.list_buckets()

# Print bucket names
print('Existing buckets:')
for bucket in response['Buckets']:
    print(f'  {bucket["Name"]}')

```

### 11. File Handling
- **Opening and Closing Files**:
  ```python
  file = open("filename.txt", "mode")
  file.close()
  ```

- **Reading and Writing**:
  ```python
  with open("filename.txt", "r") as file:
      content = file.read()

  with open("filename.txt", "w") as file:
      file.write("Hello, World!")
  ```

### 12. Error Handling
- **Try-Except Block**:
  ```python
  try:
      # code block
  except Exception as e:
      # code block
  ```

- **Example**:
  ```python
  try:
      result = 10 / 0
  except ZeroDivisionError as e:
      print("Error: Division by zero!")
  ```

### 13. Classes and Objects
- **Class Definition**:
  ```python
  class MyClass:
      def __init__(self, attribute):
          self.attribute = attribute

      def method(self):
          return self.attribute
  ```

- **Object Instantiation**:
  ```python
  obj = MyClass("value")
  print(obj.method())  # value
  ```

### Conclusion
These notes provide a foundational understanding of Python programming. For more in-depth learning, practice writing code and explore Python's extensive standard library and third-party modules. Happy coding!
