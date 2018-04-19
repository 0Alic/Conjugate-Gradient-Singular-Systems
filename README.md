# Conjugate Gradient for Singular Systems

Project of the course "Computational Mathematics for Learning and Data Analysis" at the Master Course in Computer Science, at the University of Pisa, Academic year: 2017 / 2018.

## Authors

* **Andrea Lisi** - *Member* - [0Alic](https://github.com/0Alic)
* **Francesca Sbolgi** - *Member* - [fsbolgi](https://github.com/fsbolgi)

### Text

Solve a sparse linear system of the form **ED^−1E'x=b** where **D** is a diagonal matrix, and **E** is the edge-node adjacency matrix of a graph. These problems arise from solving the KKT system of certain quadratic flow optimization problems on graphs.
Use the following method for the task:

Conjugate Gradient for linear systems. Your implementation should not require forming the matrix **ED^−1E'** explicitly, but rely on a callback function which computes the product **ED^−1E'v** for a given vector **v**.

## Overview

The repository is structured with these folders:

* **Charts**: an overview of the resuls of our original dataset;
* **Data**: a subset of our dataset;
* **GraphGenerators:** the generators to create graphs with different properties;
* **MatLab:** the matlab scripts;
* **PyLimbo:** python scripts to create data file readable by matlab;
* **Spreadsheets:** more informations on our results. 

## Prerequisites 

* **Matlab** for Conjugate Gradient;
* **Python >=2.7** for creating matrix D and vector b;
* **gcc** to compile and use matrix E generators.
 
## Getting Started

Since the dataset we used originally was very big we divided the data in different paths and folders. We provide a subset in order to keep the repository small.

This is an academic project so some the Matlab test scripts are written according to our needs, such as runAll.m and runExp.m.

### Generate more data

The 3 generators used are: 

* **Netgen** generates simple graphs;
* **Complete** generates complete graphs, with the possibilities to have parallel edges;
* **Grid On TOrus (goto)** generates torus grid graphs.

These generators build node-edge adjacency graphs and store them in .dmx files. To generate files directly readable by Matlab use GeneratorE.py: the resulting file is stored so that it exploits sparsity.
To generate matrix D and vector b use GeneratorD.py and GeneratorB.py.

### Run Conjugate Gradient

We provide a script runInstance.m in order to run CG procedure on a single data instance.

```
[] = runInstance(gen_name, edge_name, idExp, i, yesplot, compare)
```

- gen_name (: string) is the name of the generator, in our case 'netgen', 'complete' or 'goto', since we use these three;
- edge_name (: string) is the cardinality of the edges of the graphs, with the dataset in the repo the possibilities are '1000', '2000', '3000', '8000';
- idExp (: int) identifies the matrix D to use: 1 to use D = I; 2 to use "uniform" D; 3 to use "bad scaled" D;
- i (: int) the instance of the graph to use (ex: the 1st, the 6th etc..);
- yesplot (: string) "yep" to plot the decrease of the residual both for CG and preconditioned CG; plot nothing if any other string is inserted;
- compare (: bool) true to perform also Matlab's pcg().

The Conjugate Gradient is performed twice: once using the given system, and once performing a simple preconditioning with the goal to improve performances.
The preconditioning used is a little modification of the Jacobian one: instead of using the diagonal of A = ED^−1E', we use the (element wise) square root of the diagonal.
The motivation is explained in the report.