# RCSB mmCIF Dictionary Suite

![example workflow](https://github.com/rcsb/cpp-dbloader-pack/workflows/Testing/badge.svg)

## Introduction

The Db Loader application is a tool which converts CIF data into a form that is loadable into a variety of relational database engines (MySQL, Oracle, Sybase and DB2). The tool produces all of the necessary SQL and auxilary configuration files to create and load tables in the relational database. The mapping of information between mmCIF data files and the relational schema is controlled by a versatile configuration file. Many relational schemas can be supported for any particular mmCIF data representation. This tool will also produce XML equivalent to any mapped relational schema.


## Installation

### Download the source code

* As a distribution with a filename like dbloader-vX.XXX-prod-src.tar.gz
```bash
   gzip -d -c dbloader-vX.XXX-prod-src.tar.gz | tar xf -
```
   
* From github 

```bash
git clone  --recurse-submodules  https://github.com/rcsb/cpp-dbloader-pack.git

```

### Building
To build the dictionary suite, you need to have the following in your path or development environment

* CMake
* C++ compiler
* bash
* csh
* flex
* bison

Typically, one creates a build tree, uses cmake to configure, and then build.

```
mkdir build
cd build
cmake .. 
make
```

This will build the tools, and compile the `db-loader` executable in the `bin` directory.

## Application Usage Examples

[Usage documentation](Usage.md)



## Notes for developers
* To create a distribution, use `make dist`

