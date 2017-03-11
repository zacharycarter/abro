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
  let id = hash(filename)
  if not assetManager.assets.contains(id):
    warn "Asset with filename : " & filename & " not loaded."
    return
    
  assetManager.dispose(id)
  

proc load*(assetManager: AssetManager, filename: string, assetType: AssetType) : Hash =
  if not fileExists(filename):
    warn "File with filename : " & filename & " does not exist."
    return
  
  let id = hash(filename)
  if assetManager.assets.contains(id):
    warn "Asset with filename : " & filename & " already loaded."
    return
    
  case assetType
    of AssetType.TEXTURE:
      var texture = texture.load(filename)
    #  echo repr texture
      texture.assetType = AssetType.TEXTURE
      assetManager.assets.add(id, texture)
  return id

proc init*(assetManager: AssetManager) =
  assetManager.assets = initTable[Hash, ref TAsset]()