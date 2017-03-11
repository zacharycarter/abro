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

proc initApp(app: App, ctx: Context) =
  info "Initializing application..."
  discard ctx.assetManager.load("textures/unpacked/test01.png", AssetType.TEXTURE)
  info "Application initialized."

proc updateApp(app: App, ctx: Context) =
  discard

proc renderApp(app: App, ctx: Context) =
  ctx.graphics.clearColor((0.18, 0.18, 0.18, 1.0))
  ctx.graphics.clear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)

proc disposeApp(app: App, ctx: Context) =
  ctx.assetManager.unload("textures/unpacked/test01.png")

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