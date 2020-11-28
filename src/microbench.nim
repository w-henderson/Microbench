import 
    terminal,
    strutils,
    times,
    os

if paramCount() == 0:
    setForegroundColor(fgRed)
    setStyle({styleBright})
    echo "Please enter the command to benchmark as an argument."
    resetAttributes()
    quit(1)

let command = commandLineParams().join(" ")
let startTime = cpuTime()

discard execShellCmd(command) # Execute the actual command

let endTime = cpuTime()
let totalTime = endTime - startTime

setForegroundColor(fgGreen)
setStyle({styleBright})
echo "\nProcess took " & $totalTime & " seconds to complete."
resetAttributes()