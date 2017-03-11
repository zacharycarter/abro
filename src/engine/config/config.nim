import
  sdl2 as sdl

type
  WindowFlags* = enum
    OpenGL = uint32 SDL_WINDOW_OPENGL
    Shown = uint32 SDL_WINDOW_SHOWN
    Resizable = uint32 SDL_WINDOW_RESIZABLE
    Default = uint32 OpenGL.ord or Shown.ord or Resizable.ord
  
  EngineConfig* = tuple [
    windowPosX, windowPosY: int
    , width, height: int
    , title: string
    , assetRoot: string
    , windowFlags: WindowFlags
  ]

const WindowPosUndefined* = SDL_WINDOWPOS_UNDEFINED