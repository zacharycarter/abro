import
  logging

import
  opengl

import
  ../../src/engine/config/config
  , ../../src/engine/engine
  , ../../src/graphics/color
  , ../../src/graphics/graphics

type
  App = ref object

proc initApp(app: App) =
  info "Initializing application..."
  info "Application initialized."

proc updateApp(app: App) =
  discard

proc renderApp(app: App) =
  graphics.clearColor((0.18, 0.18, 0.18, 1.0))
  graphics.clear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)

proc disposeApp(app: App) =
  discard

startdEngine[App](
  (
    windowPosX: WindowPosUndefined
    , windowPosY: WindowPosUndefined
    , width: 960
    , height: 540
    , title: "dEngine Example 01-HelloWorld"
    , assetRoot: ""
    , windowFlags: Default
  )
)