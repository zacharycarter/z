import z / [zapp, zgfx]

var passAction: ZgPassAction

proc init() =
  var zgDesc = ZgDesc(
    d3d11Device: zappD3d11GetDevice(),
    d3d11DeviceContext: zappD3d11GetDeviceContext(),
    d3d11RenderTargetViewCb: zappD3d11GetRenderTargetView,
    d3d11DepthStencilViewCb: zappD3d11GetDepthStencilView
  )
  zgSetup(zgDesc)

proc frame() =
  discard

proc cleanUp() =
  discard

proc event(e: var ZappEvent) =
  discard

var appDesc = ZappDesc(
  initCb: init,
  frameCb: frame,
  cleanUpCb: cleanUp,
  eventCb: event,
  width: 400,
  height: 300,
  windowTitle: "Clear (zapp)"
)
zappRun(appDesc)