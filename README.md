![Microbench Banner](assets/banner.png)

# Microbench

Microbench is a lightweight and accurate benchmarking program for command-line utilities. Written in Nim, it's a great way to easily check how long your programs are taking to run.

## Quick Start
Install Microbench by visiting the [Releases page](https://github.com/w-henderson/Microbench/releases) and installing the latest binary. Make sure you add it to your PATH so it's accessible from anywhere.

To benchmark a program with Microbench, you can run `microbench <command to benchmark ...>`, and Microbench will tell you how long it took to run down to the millisecond. However, if you want additional information, you can specify how many iterations to use by running `microbench [-i, --iterations] <iteration count> <command to benchmark ...>`, and Microbench will give you a mean, minimum, maximum, and standard deviation.

For example, to benchmark my program [NimTrains](https://github.com/w-henderson/NimTrains), I could run `microbench -i 100 nimtrains EXD`, which would run the command `nimtrains EXD` one hundred times and time them. The output from that command would look something like this:

```
== MICROBENCH RESULTS FOR: "nimtrains EXD" ==

  Mean running time: 14.76 ms
  Minimum running time: 12.0 ms
  Maximum running time: 34.0 ms
  Standard deviation of running times: 3.9876 ms
```
