
CrystalScript
=============

CrystalScript is project built around providing a simple scripting language for the flash platform. It
is written in AS3, and is aimed at being easy to incorporate into other projects (games, IDEs, interactive
apps, as a plugin system, etc).

Project Overview
----------------

There are many different sections to the CrystalScript project, the are detailed below. These are general
descriptions of what the completed project _should_ look like, not necessarily how the current implementation
functions. More information and details in the docs directory.

### Parser ###

The parser includes the Tokenizer (Lexer), the AST tree generator (or 'parser'), and the AST
tree optimizer. It also is responsible for performing syntax checking and reporting. Overall,
the parser deals with all aspects relating to the scipt text and grammar.

### Virtual Machine ###

This portion of the project includes a code generator that will emit optimized bytecode for
a simple register based CrystalScript VM. While much slower than generating pure AVM2
bytecode, this option is easier to implement, test, and integrate into existing projects

### AVM2 ###

The AVM2 section aims to compile CrystalScript code directly into optimized AVM2 bytecode. It will
include a dynamic loader (e.g. through loadBytes()) that will be responsible for executing generated AVM2
bytecode.

### Editor ###

Eventually we would like to provide an AS3 editor component that provides a syntax highlighting text editor
that will make it easier to write CrystalScript code.

### Standard Library ###

It is a major goal to provide a feature-rich, easy to use standard library that contains all of the functions and
other functionality expected in a modern scripting language. The python programming language is the main influence
for this.

Project Status
--------------

Currently, the progress as far as what is described above is minimal. The basic parser works and generates an AST
for a subset of what will eventually be the full language, and some avm2 progress has been made (though none
on the actual bytecode generator)
