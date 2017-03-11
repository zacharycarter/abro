import 
  hashes
  , logging
  , os
  , tables

import 
  asset
  , ../graphics/twod/texture

type
  AssetManager* = ref TAssetManager
  TAssetManager* = object
    assetSearchPath: string
    assets: Table[Hash, ref TAsset]

proc dispose(assetManager: AssetManager, id: Hash) =
  case assetManager.assets[id].assetType
    of AssetType.TEXTURE:
      texture.unload(assetManager.assets[id])
    else:
      warn "Unable to unload asset with unknown type."

proc unload*(assetManager: AssetManager, id: Hash) =
  if not assetManager.assets.contains(id):
    warn "Asset with filename : " & $id & " not loaded."
    return
    
  assetManager.dispose(id)

proc unload*(assetManager: AssetManager, filename: string) =
  let filepath = assetManager.assetSearchPath & filename
  let id = hash(filepath)
  if not assetManager.assets.contains(id):
    warn "Asset with filepath : " & filepath & " not loaded."
    return
    
  assetManager.dispose(id)
  

proc load*(assetManager: AssetManager, filename: string, assetType: AssetType) : Hash =
  let filepath = assetManager.assetSearchPath & filename
  if not fileExists(filepath):
    warn "File with filepath : " & filepath & " does not exist."
    return
  
  let id = hash(filepath)
  if assetManager.assets.contains(id):
    warn "Asset with filepath : " & filepath & " already loaded."
    return
    
  case assetType
    of AssetType.TEXTURE:
      var texture = texture.load(filepath)
    #  echo repr texture
      texture.assetType = AssetType.TEXTURE
      assetManager.assets.add(id, texture)
  return id

proc init*(assetManager: AssetManager, assetRoot: string) =
  assetManager.assets = initTable[Hash, ref TAsset]()
  assetManager.assetSearchPath = getAppDir() & DirSep & assetRoot & DirSep