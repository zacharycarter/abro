import
  logging

import
  opengl

import
  ../../src/asset/asset
  , ../../src/asset/asset_manager
  , ../../src/engine/config/config
  , ../../src/engine/engine
  , ../../src/graphics/color
  , ../../src/graphics/graphics

type
  App = ref object
    engine: dEngine

proc initApp(app: App) =
  info "Initializing application..."
  discard app.engine.assetManager.load("test01.png", AssetType.TEXTURE)
  info "Application initialized."

proc updateApp(app: App) =
  discard

proc renderApp(app: App) =
  app.engine.graphics.clearColor((0.18, 0.18, 0.18, 1.0))
  app.engine.graphics.clear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)

proc disposeApp(app: App) =
  discard

startdEngine[App](
  (
    windowPosX: WindowPosUndefined
    , windowPosY: WindowPosUndefined
    , width: 960
    , height: 540
    , title: "dEngine Example 01-HelloWorld"
    , assetRoot: "../assets"
    , windowFlags: Default
  )
)