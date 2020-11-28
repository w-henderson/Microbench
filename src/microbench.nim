import times, os, strutils

if paramCount() != 1:
    echo "Please enter the command to benchmark as an argument."
    quit(1)

let command = paramStr(1)
let startTime = cpuTime()
discard execShellCmd(command)
let endTime = cpuTime()

let totalTime = endTime - startTime

echo "Process took " & $totalTime & " seconds to complete."