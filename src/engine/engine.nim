import 
  logging

import
  sdl2 as sdl

import 
  config/config
  , ../event/event_bus
  , ../graphics/graphics
  , ../log/log
  , ../util/framerate

type
  dEngine* = ref TEngine
  TEngine* = object
    eventBus: EventBus
    graphics: Graphics

var last = 0'u64
var deltaTime = 0'f64
var now = sdl.getPerformanceCounter()

proc startdEngine*[App](engineConfig: EngineConfig) =
  echo "Starting dEngine..."

  var engine = dEngine()

  echo "Initializing logging subsystem..."
  initLogging()
  info "Logging subsystem initialized."

  echo "Initializing event subsystem..."
  engine.eventBus = EventBus()
  engine.eventBus.init()
  info "Event subsystem initialized."

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
     # Calculate Delta Time
    last = now
    now = sdl.getPerformanceCounter()
    deltaTime = float64((now - last) * 1000 div sdl.getPerformanceFrequency())

    while bool sdl.pollEvent(event):
      case event.kind
      of sdl.QuitEvent:
        runGame = false
        break
      else:
        engine.eventBus.dispatch(event)
    
    app.renderApp()

    engine.graphics.swap()

     # Limit CPU hit
    limitFrameRate()
  
  info "Shutting down dEngine..."
  engine.graphics.shutdown()
  info "Goodbye."