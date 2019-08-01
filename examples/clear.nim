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
  passAction.colors[0].action = ZG_ACTION_CLEAR
  passAction.colors[0].val = [1.0'f32, 0.0, 0.0, 1.0]

proc frame() =
  let g = passAction.colors[0].val[1] + 0.1'f32
  passAction.colors[0].val[1] = if g > 1.0: 0.0'f32 else: g
  zgBeginDefaultPass(passAction, zappWidth(), zappHeight())

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