import 
  events
  , logging

import 
  sdl2

import
  event

type
  EventBus* = ref TEventBus
  TEventBus* = object
    eventEmitter: EventEmitter

proc registerEventHandler*(
  eventBus: EventBus
  , eventHandler: event.EventHandler
  , eventType: event.EventType
) =
  events.on(eventBus.eventEmitter, $eventType, eventHandler)

proc dispatch*(eventBus: EventBus, e: sdl2.Event) =
  case e.kind
  of sdl2.WindowEvent:
    let eventMessage  = event.EventMessage(event: e)
    eventBus.eventEmitter.emit($e.window.event, eventMessage)
  else:
    warn "Unable to dispatch event with unknown type : " & $e.kind

proc init*(eventBus: EventBus) =
  eventBus.eventEmitter = initEventEmitter()