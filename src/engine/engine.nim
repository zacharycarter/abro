import 
  logging

import
  sdl2 as sdl

import 
  config/config
  , ../graphics/graphics
  , ../log/log

type
  dEngine* = ref TEngine
  TEngine* = object
    graphics: Graphics

proc startdEngine*[App](engineConfig: EngineConfig) =
  echo "Starting dEngine..."

  var engine = dEngine()

  echo "Initializing logging subsystem..."
  initLogging()
  info "Logging subsystem initialized."

  info "Initializing graphics subsystem..."
  engine.graphics = Graphics()
  if not engine.graphics.init(
    engineConfig.title
    , engineConfig.windowPosX
    , engineConfig.windowPosY
    , engineConfig.width
    , engineConfig.height
    , uint32 engineConfig.windowFlags
  ):
    fatal "Failed to initialize graphics subsystem."
    quit(QUIT_FAILURE)
  info "Graphics subsystem initialized."

  info "dEngine started."

  var app : App = App()

  app.initApp()

  var
    event = sdl.defaultEvent
    runGame = true

  while runGame:
    while bool sdl.pollEvent(event):
      case event.kind
      of sdl.QuitEvent:
        runGame = false
        break
      else:
        discard
    
    app.renderApp()

    engine.graphics.swap()
  
  info "Shutting down dEngine..."
  engine.graphics.shutdown()
  info "Goodbye."