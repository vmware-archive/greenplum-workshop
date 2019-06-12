First run a simple Python program that executes the OS command `whoami`.
Then try to create a user defined function in python as gpuser.  It fails.  Why?
Then create it as gpadmin and GRANT EXECUTE to gpuser.
The function takes as its argument the text of a Linux OS command.
Run the function with the argument `whoami`.  Who are you?  Why?

Then create a similar function in PL/Container.  This can be done as gpuser.  Why?
Run the function with the argument `whoami`.  Who are you?  Why?
Run the PLPython function with the argument `cat /etc/system-release`. What is the OS release?
Run the PL/Container function with the argument `cat /etc/system-release`.
Are the releases the same?  Why?

When you ran the PLPythonU version of the function, `whoami` said you were gpadmin.
Try it with the containerized version.  Who are you now?

Now for some analytic work in Python and its open source mathematical libraries.  
Let's compute 3 measures of centrality in data: arithmetic mean, geometric mean, and harmonic mean.
They have some interesting properties you can explore on your own.

First, let's create some data with numpy_setup.sql
Then create the functions in PL/Container with numpy_define_means.sql
Then execute the functions with numpy_calculate_means.
