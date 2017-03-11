import 
  events

import 
  sdl2

type
  EventType* = enum
    WINDOW_RESIZE = "WindowEvent_Resized"

  EventMessage* = object of EventArgs
    event*: sdl2.Event

  EventHandler* = proc(e: EventArgs)