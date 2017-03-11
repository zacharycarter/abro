import 
  logging

var initialized {.global.} : bool = false
var fileLogger {.global.} : FileLogger
var consoleLogger {.global.} : ConsoleLogger

proc initLogging*(logFile: string = nil) =
  if initialized:
    warn "Logging subsystem already initialized."
    return

  consoleLogger = newConsoleLogger()

  if not logFile.isNil:
    fileLogger = newFileLogger(logFile)
  else:
    fileLogger = newFileLogger("dEngine.log")
  
  addHandler(consoleLogger)
  addHandler(fileLogger)

  initialized = true
