import
  sdl2 as sdl

type
  WindowFlags* = enum
    OpenGL = SDL_WINDOW_OPENGL
    Shown = SDL_WINDOW_SHOWN
    Resizable = SDL_WINDOW_RESIZABLE
    Default = OpenGL.ord or Shown.ord or Resizable.ord
  
  EngineConfig* = tuple [
    windowPosX, windowPosY: int
    , width, height: int
    , title: string
    , assetRoot: string
    , windowFlags: WindowFlags
  ]

const WindowPosUndefined* = SDL_WINDOWPOS_UNDEFINED