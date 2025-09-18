# Brainfuck Interpreter (x86-64 Assembly)

This project implements a simple **Brainfuck interpreter** in **x86-64 assembly** (AT&T syntax).  
It reads a Brainfuck source file, interprets the code, and executes it.

---

## 📂 Project Structure
- **`main.s`**  
  Entry point. Handles command-line arguments, reads a file, and passes its contents to the interpreter.

- **`read_file.s`**  
  Subroutine to read the entire contents of a file into memory.

- **`brainfuck.s`**  
  Core of the interpreter. Implements the Brainfuck instruction set (`<>+-.,[]`).

- **`Makefile`**  
  Build script for assembling and linking the program.

- **Example Brainfuck Programs (`.b` files):**  
  - `hello.b`, `hello1.b`, … `hello5.b` → Variants of “Hello World”  
  - `reverse.b` → Reverses input  
  - `cat.b` → Simple echo program  
  - `hanoi.b` → Towers of Hanoi  
  - `mandelbrot.b` → Mandelbrot set renderer

---

## ⚙️ Building

This project uses a `Makefile` so you don’t need to type long `gcc` commands yourself.  
To build the interpreter:

1. Open a terminal and go to the folder containing the project files:

   ```bash
   cd brainfuck-folder   # (replace with the actual folder name)

2. Run make:

   ```bash
   make
   ```
   - This assembles all the `.s` files (`main.s`, `read_file.s`, `brainfuck.s`)
   - Then it links them together into an executable called `brainfuck`.

3. After building, you should see a new file named `brainfuck` in the folder. You can check with:

   ```bash
   ls
   ```
   - It should list your source files plus the `brainfuck` executable.

- If you ever want to clean up (delete the compiled executable), run:

```bash
make clean
```
- Then you can rebuild again with `make`.

## ▶️ Usage
Run the interpreter with a Brainfuck program file:

```bash
./brainfuck <filename>
```

Examples:

```bash
./brainfuck hello.b
./brainfuck reverse.b
```

Expected output for `hello.b`:

```bash
Hello World!
```