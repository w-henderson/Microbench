import 
    terminal,
    strutils,
    strformat,
    osproc,
    times,
    math,
    os

proc mean(arr: seq[float]): float =
    var total = 0f
    for f in arr:
        total += f
    return total / (float)len(arr)

proc max(arr: seq[float]): float =
    var max = arr[0]
    for f in arr:
        if f > max: max = f
    return max

proc min(arr: seq[float]): float =
    var min = arr[0]
    for f in arr:
        if f < min: min = f
    return min

proc standardDeviation(arr: seq[float]): float =
    var sumXsqr = 0f
    for f in arr:
        sumXsqr += f ^ 2
    let sxx = sumXsqr - ((float)(len(arr)) * pow(mean(arr), 2))
    return sqrt((1 / ((float)(len(arr)) - 1)) * sxx)

proc showBar(value: float) =
    stdout.write("Benchmarking... [")
    let reps: int = (int)value * 40
    stdout.write(repeat('#', reps))
    stdout.write(repeat(' ', 40 - reps))
    stdout.write("]  " & $((int)(value * 100)) & "%                               \r")

if paramCount() == 0:
    setForegroundColor(fgRed)
    setStyle({styleBright})
    echo "Please enter the command to benchmark as an argument."
    resetAttributes()
    quit(1)

var command: string
var iterations = 1;

if "-" in paramStr(1):
    if paramStr(1) in ["-i", "--iterations"]:
        try:
            iterations = parseInt(paramStr(2))
            var commandSeq = commandLineParams()
            commandSeq.delete(0)
            commandSeq.delete(0)
            command = commandSeq.join(" ")
        except:
            echo "An error occured, to specify iterations use \"microbench -i <iteration number> <command>\"."
            quit(1)
    else:
        echo &"Unknown flag \"{paramStr(1)}\"."
        quit(1)
else:
    command = commandLineParams().join(" ")

var benchmarkTimes: seq[float] = @[]

for i in 1..iterations:
    let startTime = cpuTime() * 1000
    discard execProcess(command) # Execute the actual command
    let endTime = cpuTime() * 1000
    benchmarkTimes.add(endTime - startTime)
    showBar((float)(i) / (float)(iterations))

stdout.write(repeat(' ', 80) & "\r")

setForegroundColor(fgGreen)
setStyle({styleBright})

if iterations == 1: # Simple mode
    echo "Process took " & $benchmarkTimes[0] & " ms to complete."
else: # Advanced mode
    echo &"\n  == MICROBENCH RESULTS FOR: \"{command}\" ==\n"
    resetAttributes()
    echo &"    Mean running time: {round(mean(benchmarkTimes), 3)} ms"
    echo &"    Minimum running time: {round(min(benchmarkTimes), 3)} ms"
    echo &"    Maximum running time: {round(max(benchmarkTimes), 3)} ms"
    echo &"    Standard deviation of running times: {round(standardDeviation(benchmarkTimes), 3)} ms"

resetAttributes()