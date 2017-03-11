import
  logging

import
  opengl
  , sdl2 as sdl

import
  color
  , window

type
  Graphics* = ref TGraphics
  TGraphics* = object
    rootWindow: Window
    rootContext: sdl.GlContextPtr
    initialized: bool

proc init*(graphics: Graphics, title: string, windowPosX, windowPosY: int, width, height: int, windowFlags: uint32) : bool =
  if graphics.initialized:
    warn "Graphics subsystem already initialized."
  
  if not sdl.init(INIT_EVERYTHING):
    return false
  
  discard glSetAttribute(SDL_GL_RED_SIZE, 8)
  discard glSetAttribute(SDL_GL_GREEN_SIZE, 8)
  discard glSetAttribute(SDL_GL_BLUE_SIZE, 8)
  discard glSetAttribute(SDL_GL_ALPHA_SIZE, 8)
  discard glSetAttribute(SDL_GL_STENCIL_SIZE, 8)


  discard glSetAttribute(SDL_GL_DEPTH_SIZE, 24)
  discard glSetAttribute(SDL_GL_DOUBLEBUFFER, 1)

  discard glSetAttribute(SDL_GL_MULTISAMPLEBUFFERS, 1)
  discard glSetAttribute(SDL_GL_MULTISAMPLESAMPLES, 4)

  discard glSetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3)
  discard glSetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 3)
  discard glSetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE)
  discard glSetAttribute(SDL_GL_CONTEXT_FLAGS        , SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG or SDL_GL_CONTEXT_DEBUG_FLAG)

  graphics.rootWindow = Window()
  graphics.rootWindow.init(title, windowPosX, windowPosY, width, height, windowFlags)
  if graphics.rootWindow.handle.isNil:
    fatal "Error creating root window."
    return false

  graphics.rootContext = graphics.rootWindow.handle.glCreateContext()
  if graphics.rootContext.isNil:
    fatal "Error creating root OpenGL context."
    return false

  if glMakeCurrent(graphics.rootWindow.handle, graphics.rootContext) != 0:
    fatal "Error setting opengl context."
    return false

  loadExtensions()

  return true

proc clear*(clearFlags: GLbitfield) =
  glClear(clearFlags)

proc clearColor*(color: color.Color) =
  glClearColor(color.r, color.g, color.b, color.a)

proc swap*(graphics: Graphics) =
  glSwapWindow(graphics.rootWindow.handle)

proc shutdown*(graphics: Graphics) =
  sdl.destroyWindow(graphics.rootWindow.handle)
  sdl.quit()