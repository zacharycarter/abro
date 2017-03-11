import
  sdl2 as sdl

type
  Window* = ref TWindow
  TWindow* = object
    handle*: sdl.WindowPtr

proc init*(window: Window, title: string, x, y = SDL_WINDOWPOS_UNDEFINED, width = 960, height = 540, flags = SDL_WINDOW_SHOWN or SDL_WINDOW_OPENGL) =
  window.handle = sdl.createWindow(
    title
    , x.cint, y.cint
    , width.cint, height.cint
    , flags
  )