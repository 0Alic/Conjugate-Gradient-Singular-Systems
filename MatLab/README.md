## Overview

* **CG.m:** our Conjugate Gradient algorithm;
* **diagOfA.m:** get the diagonal of A = ED^-1E' without forming it;
* **loadB.m:** load vector b;
* **loadD.m:** load matrix D;
* **preconditioning.m:** get the precoditioner of our matrix according to a parameter;
* **runAll.m:** a script running CG on all matrices D and with our preconditioners;
* **runExp.m:** a script called several times by runAll.m, which runs CG on all data in Data/ and writes results in .xls files; it performs also Matlab's pcg() in order to get a comparison;
* **runInstance.m:** a script running CG on a single data instance, given in input;
* **util_preface.m:** a script writing a little preface in the .xls files;
* **util_results.m:** a script writing the final result of an experiment in .xls files;

