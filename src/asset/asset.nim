import
  opengl,
  sdl2 as sdl

type
  AssetType* = enum
    TEXTURE
  
  TAsset* = object
    case assetType*: AssetType
    of TEXTURE:
      handle*: GLuint
      filename*: string
      data*: sdl.SurfacePtr
      width*: int
      height*: int