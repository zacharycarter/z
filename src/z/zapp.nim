when defined(windows):
  when not defined(WIN32_LEAN_AND_MEAN):
    const WIN32_LEAN_AND_MEAN = 1
  import winim/lean
  when defined(Z_D3D11):
    when not defined(D3D11_NO_HELPERS):
      const D3D11_NO_HELPERS = 1
    when not defined(CINTERFACE):
      const CINTERFACE = 1
    when not defined(COBJMACROS):
      const COBJMACROS = 1
    import d3d11, dxgi

const
  ZAPP_MAX_TOUCHPOINTS = 8
  ZAPP_MAX_MOUSEBUTTONS = 3
  ZAPP_MAX_KEYCODES = 512

type
  ProcessDpiAwareness = distinct int32

  MonitorDpiType = distinct int32
  
  ZappEventKind {.size: sizeof(uint32).} = enum
    ZAPP_EVENTKIND_INVALID,
    ZAPP_EVENTKIND_KEY_DOWN,
    ZAPP_EVENTKIND_KEY_UP,
    ZAPP_EVENTKIND_CHAR,
    ZAPP_EVENTKIND_MOUSE_DOWN,
    ZAPP_EVENTKIND_MOUSE_UP,
    ZAPP_EVENTKIND_MOUSE_SCROLL,
    ZAPP_EVENTKIND_MOUSE_MOVE,
    ZAPP_EVENTKIND_MOUSE_ENTER,
    ZAPP_EVENTKIND_MOUSE_LEAVE,
    ZAPP_EVENTKIND_TOUCHES_BEGAN,
    ZAPP_EVENTKIND_TOUCHES_MOVED,
    ZAPP_EVENTKIND_TOUCHES_ENDED,
    ZAPP_EVENTKIND_TOUCHES_CANCELLED,
    ZAPP_EVENTKIND_RESIZED,
    ZAPP_EVENTKIND_ICONIFIED,
    ZAPP_EVENTKIND_RESTORED,
    ZAPP_EVENTKIND_SUSPENDED,
    ZAPP_EVENTKIND_RESUMED,
    ZAPP_EVENTKIND_UPDATE_CURSOR,
    ZAPP_EVENTKIND_QUIT_REQUESTED,
    ZAPP_EVENTKIND_COUNT
    ZAPP_EVENTKIND_FORCE_U32 = 0x7FFFFFF

  # key codes have same name and values as GLFW key codes
  ZappKeyCode = enum
    ZAPP_KEYCODE_INVALID          = 0,
    ZAPP_KEYCODE_SPACE            = 32,
    ZAPP_KEYCODE_APOSTROPHE       = 39,  # ' #
    ZAPP_KEYCODE_COMMA            = 44,  # , #
    ZAPP_KEYCODE_MINUS            = 45,  # - #
    ZAPP_KEYCODE_PERIOD           = 46,  # . #
    ZAPP_KEYCODE_SLASH            = 47,  # / #
    ZAPP_KEYCODE_0                = 48,
    ZAPP_KEYCODE_1                = 49,
    ZAPP_KEYCODE_2                = 50,
    ZAPP_KEYCODE_3                = 51,
    ZAPP_KEYCODE_4                = 52,
    ZAPP_KEYCODE_5                = 53,
    ZAPP_KEYCODE_6                = 54,
    ZAPP_KEYCODE_7                = 55,
    ZAPP_KEYCODE_8                = 56,
    ZAPP_KEYCODE_9                = 57,
    ZAPP_KEYCODE_SEMICOLON        = 59,  # ; #
    ZAPP_KEYCODE_EQUAL            = 61,  # = #
    ZAPP_KEYCODE_A                = 65,
    ZAPP_KEYCODE_B                = 66,
    ZAPP_KEYCODE_C                = 67,
    ZAPP_KEYCODE_D                = 68,
    ZAPP_KEYCODE_E                = 69,
    ZAPP_KEYCODE_F                = 70,
    ZAPP_KEYCODE_G                = 71,
    ZAPP_KEYCODE_H                = 72,
    ZAPP_KEYCODE_I                = 73,
    ZAPP_KEYCODE_J                = 74,
    ZAPP_KEYCODE_K                = 75,
    ZAPP_KEYCODE_L                = 76,
    ZAPP_KEYCODE_M                = 77,
    ZAPP_KEYCODE_N                = 78,
    ZAPP_KEYCODE_O                = 79,
    ZAPP_KEYCODE_P                = 80,
    ZAPP_KEYCODE_Q                = 81,
    ZAPP_KEYCODE_R                = 82,
    ZAPP_KEYCODE_S                = 83,
    ZAPP_KEYCODE_T                = 84,
    ZAPP_KEYCODE_U                = 85,
    ZAPP_KEYCODE_V                = 86,
    ZAPP_KEYCODE_W                = 87,
    ZAPP_KEYCODE_X                = 88,
    ZAPP_KEYCODE_Y                = 89,
    ZAPP_KEYCODE_Z                = 90,
    ZAPP_KEYCODE_LEFT_BRACKET     = 91,  # [ #
    ZAPP_KEYCODE_BACKSLASH        = 92,  # \ #
    ZAPP_KEYCODE_RIGHT_BRACKET    = 93,  # ] #
    ZAPP_KEYCODE_GRAVE_ACCENT     = 96,  # ` #
    ZAPP_KEYCODE_WORLD_1          = 161, # non-US #1 #
    ZAPP_KEYCODE_WORLD_2          = 162, # non-US #2 #
    ZAPP_KEYCODE_ESCAPE           = 256,
    ZAPP_KEYCODE_ENTER            = 257,
    ZAPP_KEYCODE_TAB              = 258,
    ZAPP_KEYCODE_BACKSPACE        = 259,
    ZAPP_KEYCODE_INSERT           = 260,
    ZAPP_KEYCODE_DELETE           = 261,
    ZAPP_KEYCODE_RIGHT            = 262,
    ZAPP_KEYCODE_LEFT             = 263,
    ZAPP_KEYCODE_DOWN             = 264,
    ZAPP_KEYCODE_UP               = 265,
    ZAPP_KEYCODE_PAGE_UP          = 266,
    ZAPP_KEYCODE_PAGE_DOWN        = 267,
    ZAPP_KEYCODE_HOME             = 268,
    ZAPP_KEYCODE_END              = 269,
    ZAPP_KEYCODE_CAPS_LOCK        = 280,
    ZAPP_KEYCODE_SCROLL_LOCK      = 281,
    ZAPP_KEYCODE_NUM_LOCK         = 282,
    ZAPP_KEYCODE_PRINT_SCREEN     = 283,
    ZAPP_KEYCODE_PAUSE            = 284,
    ZAPP_KEYCODE_F1               = 290,
    ZAPP_KEYCODE_F2               = 291,
    ZAPP_KEYCODE_F3               = 292,
    ZAPP_KEYCODE_F4               = 293,
    ZAPP_KEYCODE_F5               = 294,
    ZAPP_KEYCODE_F6               = 295,
    ZAPP_KEYCODE_F7               = 296,
    ZAPP_KEYCODE_F8               = 297,
    ZAPP_KEYCODE_F9               = 298,
    ZAPP_KEYCODE_F10              = 299,
    ZAPP_KEYCODE_F11              = 300,
    ZAPP_KEYCODE_F12              = 301,
    ZAPP_KEYCODE_F13              = 302,
    ZAPP_KEYCODE_F14              = 303,
    ZAPP_KEYCODE_F15              = 304,
    ZAPP_KEYCODE_F16              = 305,
    ZAPP_KEYCODE_F17              = 306,
    ZAPP_KEYCODE_F18              = 307,
    ZAPP_KEYCODE_F19              = 308,
    ZAPP_KEYCODE_F20              = 309,
    ZAPP_KEYCODE_F21              = 310,
    ZAPP_KEYCODE_F22              = 311,
    ZAPP_KEYCODE_F23              = 312,
    ZAPP_KEYCODE_F24              = 313,
    ZAPP_KEYCODE_F25              = 314,
    ZAPP_KEYCODE_KP_0             = 320,
    ZAPP_KEYCODE_KP_1             = 321,
    ZAPP_KEYCODE_KP_2             = 322,
    ZAPP_KEYCODE_KP_3             = 323,
    ZAPP_KEYCODE_KP_4             = 324,
    ZAPP_KEYCODE_KP_5             = 325,
    ZAPP_KEYCODE_KP_6             = 326,
    ZAPP_KEYCODE_KP_7             = 327,
    ZAPP_KEYCODE_KP_8             = 328,
    ZAPP_KEYCODE_KP_9             = 329,
    ZAPP_KEYCODE_KP_DECIMAL       = 330,
    ZAPP_KEYCODE_KP_DIVIDE        = 331,
    ZAPP_KEYCODE_KP_MULTIPLY      = 332,
    ZAPP_KEYCODE_KP_SUBTRACT      = 333,
    ZAPP_KEYCODE_KP_ADD           = 334,
    ZAPP_KEYCODE_KP_ENTER         = 335,
    ZAPP_KEYCODE_KP_EQUAL         = 336,
    ZAPP_KEYCODE_LEFT_SHIFT       = 340,
    ZAPP_KEYCODE_LEFT_CONTROL     = 341,
    ZAPP_KEYCODE_LEFT_ALT         = 342,
    ZAPP_KEYCODE_LEFT_SUPER       = 343,
    ZAPP_KEYCODE_RIGHT_SHIFT      = 344,
    ZAPP_KEYCODE_RIGHT_CONTROL    = 345,
    ZAPP_KEYCODE_RIGHT_ALT        = 346,
    ZAPP_KEYCODE_RIGHT_SUPER      = 347,
    ZAPP_KEYCODE_MENU             = 348,

  ZappMouseButton = enum
    ZAPP_MOUSEBUTTON_INVALID = -1
    ZAPP_MOUSEBUTTON_LEFT = 0
    ZAPP_MOUSEBUTTON_RIGHT = 1
    ZAPP_MOUSEBUTTON_MIDDLE = 2

  ZappEvent = object
    frameCount: uint64
    kind: ZappEventKind
    keyCode: ZappKeyCode
    charCode: uint32
    keyRepeat: bool
    modifiers: uint32
    mouseButton: ZappMouseButton
    mouseX: float32
    mouseY: float32
    scrollX: float32
    scrollY: float32
    windowWidth: int
    windowHeight: int
    frameBufferWidth: int
    frameBufferHeight: int

  ZappDesc = object
    initCb: (proc())
    frameCb: (proc())
    cleanUpCb: (proc())
    eventCb: (proc(e: var ZappEvent))
    userData: pointer
    initUserDataCb: (proc(d: pointer))
    frameUserDataCb: (proc(d: pointer))
    cleanUpUserDataCb: (proc(d: pointer))
    eventUserDataCb: (proc(e: var ZappEvent, d: pointer))
    width: int
    height: int
    sampleCount: int
    swapInterval: int
    highDpi: bool
    fullscreen: bool
    alpha: bool
    windowTitle: string
    userCursor: bool

  Zapp = object
    valid: bool
    windowWidth: int
    windowHeight: int
    frameBufferWidth: int
    frameBufferHeight: int
    sampleCount: int
    swapInterval: int
    dpiScale: float32
    gles2Fallback: bool
    firstFrame: bool
    initCalled: bool
    cleanUpCalled: bool
    quitRequested: bool
    quitOrdered: bool
    windowTitle: string
    windowTitleWide: WideCString
    frameCount: uint64
    mouseX: float32
    mouseY: float32
    win32MouseTracked: bool
    event: ZappEvent
    desc: ZappDesc
    keyCodes: array[ZAPP_MAX_KEYCODES, ZappKeyCode]

const
  ZAPP_MODIFIER_SHIFT = (1 shl 0)
  ZAPP_MODIFIER_CTRL = (1 shl 1)
  ZAPP_MODIFIER_ALT = (1 shl 2)
  ZAPP_MODIFIER_SUPER = (1 shl 3)

  PROCESS_DPI_UNAWARE = 0.ProcessDpiAwareness
  PROCESS_SYSTEM_DPI_AWARE = 1.ProcessDpiAwareness
  PROCESS_PER_MONITOR_DPI_AWARE = 2.ProcessDpiAwareness

  MDT_EFFECTIVE_DPI = 0.MonitorDpiType
  MDT_ANGULAR_DPI = 1.MonitorDpiType
  MDT_RAW_DPI = 2.MonitorDpiType
  MDT_DEFAULT = MDT_EFFECTIVE_DPI

var zapp: Zapp

template zappDef(val, def: untyped): untyped =
  (if ((val) == 0): (def) else: (val))

proc zappInitState(desc: ZappDesc) =
  zapp.desc = desc
  zapp.firstFrame = true
  zapp.windowWidth = zappDef(zapp.desc.width, 640)
  zapp.windowHeight = zappDef(zapp.desc.height, 400)
  zapp.frameBufferWidth = zapp.windowWidth
  zapp.frameBufferHeight = zapp.windowHeight
  zapp.sampleCount = zappDef(zapp.desc.sampleCount, 1)
  zapp.swapInterval = zappDef(zapp.desc.swapInterval, 1)
  if len(zapp.desc.windowTitle) > 0:
    zapp.windowTitle = zapp.desc.windowTitle
  else:
    zapp.windowTitle = "zapp"
  zapp.dpiScale = 1.0

proc zappEventsEnabled(): bool =
  result = (zapp.desc.eventCb != nil or zapp.desc.eventUserDataCb != nil) and
    zapp.initCalled

proc zappInitEvent(kind: ZappEventKind) =
  zapp.event.kind = kind
  zapp.event.frameCount = zapp.frameCount
  zapp.event.mouseButton = ZAPP_MOUSEBUTTON_INVALID
  zapp.event.windowWidth = zapp.windowWidth
  zapp.event.windowHeight = zapp.windowHeight
  zapp.event.frameBufferWidth = zapp.frameBufferWidth
  zapp.event.frameBufferHeight = zapp.frameBufferHeight

proc zappCallEvent(e: var ZappEvent) =
  if zapp.desc.eventCb != nil:
    zapp.desc.eventCb(e)
  elif zapp.desc.eventUserDataCb != nil:
    zapp.desc.eventUserDataCb(e, zapp.desc.userData)

proc zappCallInit() =
  if zapp.desc.initCb != nil:
    zapp.desc.initCb()
  elif zapp.desc.initUserDataCb != nil:
    zapp.desc.initUserDataCb(zapp.desc.userData)
  zapp.initCalled = true

proc zappCallFrame() =
  if zapp.initCalled and not zapp.cleanUpCalled:
    if zapp.desc.frameCb != nil:
      zapp.desc.frameCb()
    elif zapp.desc.frameUserDataCb != nil:
      zapp.desc.frameUserDataCb(zapp.desc.userData)

proc zappFrame() =
  if zapp.firstFrame:
    zapp.firstFrame = false
    zappCallInit()
  zappCallFrame()
  inc(zapp.frameCount)

proc zappCallCleanUp() =
  if zapp.desc.cleanUpCb != nil:
    zapp.desc.cleanUpCb()
  elif zapp.desc.cleanUpUserDataCb != nil:
    zapp.desc.cleanUpUserDataCb(zapp.desc.userData)
  zapp.cleanUpCalled = true

when defined(windows):
  type
    SetProcessDPIAware = proc(): WINBOOL {.stdcall.}
    SetProcessDPIAwareness = proc(a1: ProcessDpiAwareness): HRESULT {.stdcall.}
    GetDPIForMonitor = proc(a1: HMONITOR, a2: MonitorDpiType, a3: ptr uint32, a4: ptr uint32): HRESULT {.stdcall.}

  var 
    zappWin32Hwnd: HWND
    zappWin32DC: HDC
    zappWin32InCreateWindow: bool
    zappWin32DpiAware: bool
    zappWin32ContentScale: float32
    zappWin32WindowScale: float32
    zappWin32MouseScale: float32
    zappWin32Iconified: bool
    zappWin32SetProcessDpiAware: SetProcessDPIAware
    zappWin32SetProcessDpiAwareness: SetProcessDPIAwareness
    zappWin32GetDpiForMonitor: GetDPIForMonitor
  when defined(Z_D3D11):
    var
      zappD3d11Device: ptr ID3D11Device
      zappD3d11DeviceContext: ptr ID3D11DeviceContext
      zappDxgiSwapChainDesc: DXGI_SWAP_CHAIN_DESC
      zappDxgiSwapChain: ptr IDXGISwapChain
      zappD3d11Rt: ptr ID3D11Texture2D
      zappD3d11Rtv: ptr ID3D11RenderTargetView
      zappD3d11Ds: ptr ID3D11Texture2D
      zappD3d11Dsv: ptr ID3D11DepthStencilView

    template zappSafeRelease(obj: untyped) =
      if obj != nil:
        discard `obj`.lpVtbl.Release(obj)
        obj = nil

    proc zappD3d11CreateDeviceAndSwapchain() =
      var scDesc = addr zappDxgiSwapChainDesc
      scDesc[].BufferDesc.Width = uint32(zapp.frameBufferWidth)
      scDesc[].BufferDesc.Height = uint32(zapp.frameBufferHeight)
      scDesc[].BufferDesc.Format = DXGI_FORMAT_R8G8B8A8_UNORM
      scDesc[].BufferDesc.RefreshRate.Numerator = 60
      scDesc[].BufferDesc.RefreshRate.Denominator = 1
      scDesc[].OutputWindow = zappWin32Hwnd
      scDesc[].Windowed = true
      scDesc[].SwapEffect = DXGI_SWAP_EFFECT_DISCARD
      scDesc[].BufferCount = 1
      scDesc[].SampleDesc.Count = uint32(zapp.sampleCount)
      scDesc[].SampleDesc.Quality = if zapp.sampleCount > 1: uint32(D3D11_STANDARD_MULTISAMPLE_PATTERN) else: 0'u32
      scDesc[].BufferUsage = DXGI_USAGE_RENDER_TARGET_OUTPUT
      var createFlags = D3D11_CREATE_DEVICE_SINGLETHREADED
      when defined(Z_DEBUG):
        createFlags = createFlags or D3D11_CREATE_DEVICE_DEBUG
      var featureLevel: D3D_FEATURE_LEVEL
      let hr = D3D11CreateDeviceAndSwapChain(
        nil,
        D3D_DRIVER_TYPE_HARDWARE,
        0,
        uint32(createFlags),
        nil,
        0,
        D3D11_SDK_VERSION,
        scDesc,
        addr zappDxgiSwapChain,
        addr zappD3d11Device,
        addr featureLevel,
        addr zappD3d11DeviceContext
      )
      assert(SUCCEEDED(hr) and zappDxgiSwapChain != nil and zappD3d11Device != nil and zappD3d11DeviceContext != nil)
    
    proc zappD3d11CreateDefaultRenderTarget() =
      var hr: HRESULT
      when defined(cpp):
        hr = zappDxgiSwapChain.lpVtbl.GetBuffer(zappDxgiSwapChain, 0 IID_ID3D11Texture2D, cast[ptr pointer](addr zappD3d11Rt))
      else:
        hr = zappDxgiSwapChain.lpVtbl.GetBuffer(zappDxgiSwapChain, 0, addr IID_ID3D11Texture2D, cast[ptr pointer](addr zappD3d11Rt))
      assert(SUCCEEDED(hr) and zappD3d11Rt != nil)
      hr = zappD3d11Device.lpVtbl.CreateRenderTargetView(zappD3d11Device, cast[ptr ID3D11Resource](zappD3d11Rt), nil, addr zappD3d11Rtv)
      assert(SUCCEEDED(hr) and zappD3d11Rtv != nil)
      var dsDesc: D3D11_TEXTURE2D_DESC
      dsDesc.Width = uint32(zapp.frameBufferWidth)
      dsDesc.Height = uint32(zapp.frameBufferHeight)
      dsDesc.MipLevels = 1
      dsDesc.ArraySize = 1
      dsDesc.Format = DXGI_FORMAT_D24_UNORM_S8_UINT
      dsDesc.SampleDesc = zappDxgiSwapChainDesc.SampleDesc
      dsDesc.Usage = D3D11_USAGE_DEFAULT
      dsDesc.BindFlags = uint32(D3D11_BIND_DEPTH_STENCIL)
      hr = zappD3d11Device.lpVtbl.CreateTexture2D(zappD3d11Device, addr dsDesc, nil, addr zappD3d11Ds)
      assert(SUCCEEDED(hr) and zappD3d11Ds != nil)
      var dsvDesc: D3D11_DEPTH_STENCIL_VIEW_DESC
      dsvDesc.Format = dsDesc.Format
      dsvDesc.ViewDimension = if zapp.sampleCount > 1: D3D11_DSV_DIMENSION_TEXTURE2DMS else: D3D11_DSV_DIMENSION_TEXTURE2D
      hr = zappD3d11Device.lpVtbl.CreateDepthStencilView(zappD3d11Device, cast[ptr ID3D11Resource](zappD3d11Ds), addr dsvDesc, addr zappD3d11Dsv)
      assert(SUCCEEDED(hr) and zappD3d11Dsv != nil)
    
    proc zappD3d11DestroyDefaultRenderTarget() =
      zappSafeRelease(zappD3d11Rt)
      zappSafeRelease(zappD3d11Rtv)
      zappSafeRelease(zappD3d11Ds)
      zappSafeRelease(zappD3d11Dsv)

    proc zappD3d11DestroyDeviceAndSwapchain() =
      zappSafeRelease(zappDxgiSwapChain)
      zappSafeRelease(zappD3d11DeviceContext)
      zappSafeRelease(zappD3d11Device)

    proc zappD3d11ResizeDefaultRenderTarget() =
      if zappDxgiSwapChain != nil:
        zappD3d11DestroyDefaultRenderTarget()
        discard zappDxgiSwapChain.lpVtbl.ResizeBuffers(
          zappDxgiSwapChain, 
          1, 
          uint32(zapp.frameBufferWidth), 
          uint32(zapp.frameBufferHeight), 
          DXGI_FORMAT_R8G8B8A8_UNORM, 
          0
        )
        zappD3d11CreateDefaultRenderTarget()

  proc zappWin32InitKeyTable() =
    # same as GLFW
    zapp.keyCodes[0x00B] = ZAPP_KEYCODE_0
    zapp.keyCodes[0x002] = ZAPP_KEYCODE_1
    zapp.keyCodes[0x003] = ZAPP_KEYCODE_2
    zapp.keyCodes[0x004] = ZAPP_KEYCODE_3
    zapp.keyCodes[0x005] = ZAPP_KEYCODE_4
    zapp.keyCodes[0x006] = ZAPP_KEYCODE_5
    zapp.keyCodes[0x007] = ZAPP_KEYCODE_6
    zapp.keyCodes[0x008] = ZAPP_KEYCODE_7
    zapp.keyCodes[0x009] = ZAPP_KEYCODE_8
    zapp.keyCodes[0x00A] = ZAPP_KEYCODE_9
    zapp.keyCodes[0x01E] = ZAPP_KEYCODE_A
    zapp.keyCodes[0x030] = ZAPP_KEYCODE_B
    zapp.keyCodes[0x02E] = ZAPP_KEYCODE_C
    zapp.keyCodes[0x020] = ZAPP_KEYCODE_D
    zapp.keyCodes[0x012] = ZAPP_KEYCODE_E
    zapp.keyCodes[0x021] = ZAPP_KEYCODE_F
    zapp.keyCodes[0x022] = ZAPP_KEYCODE_G
    zapp.keyCodes[0x023] = ZAPP_KEYCODE_H
    zapp.keyCodes[0x017] = ZAPP_KEYCODE_I
    zapp.keyCodes[0x024] = ZAPP_KEYCODE_J
    zapp.keyCodes[0x025] = ZAPP_KEYCODE_K
    zapp.keyCodes[0x026] = ZAPP_KEYCODE_L
    zapp.keyCodes[0x032] = ZAPP_KEYCODE_M
    zapp.keyCodes[0x031] = ZAPP_KEYCODE_N
    zapp.keyCodes[0x018] = ZAPP_KEYCODE_O
    zapp.keyCodes[0x019] = ZAPP_KEYCODE_P
    zapp.keyCodes[0x010] = ZAPP_KEYCODE_Q
    zapp.keyCodes[0x013] = ZAPP_KEYCODE_R
    zapp.keyCodes[0x01F] = ZAPP_KEYCODE_S
    zapp.keyCodes[0x014] = ZAPP_KEYCODE_T
    zapp.keyCodes[0x016] = ZAPP_KEYCODE_U
    zapp.keyCodes[0x02F] = ZAPP_KEYCODE_V
    zapp.keyCodes[0x011] = ZAPP_KEYCODE_W
    zapp.keyCodes[0x02D] = ZAPP_KEYCODE_X
    zapp.keyCodes[0x015] = ZAPP_KEYCODE_Y
    zapp.keyCodes[0x02C] = ZAPP_KEYCODE_Z
    zapp.keyCodes[0x028] = ZAPP_KEYCODE_APOSTROPHE
    zapp.keyCodes[0x02B] = ZAPP_KEYCODE_BACKSLASH
    zapp.keyCodes[0x033] = ZAPP_KEYCODE_COMMA
    zapp.keyCodes[0x00D] = ZAPP_KEYCODE_EQUAL
    zapp.keyCodes[0x029] = ZAPP_KEYCODE_GRAVE_ACCENT
    zapp.keyCodes[0x01A] = ZAPP_KEYCODE_LEFT_BRACKET
    zapp.keyCodes[0x00C] = ZAPP_KEYCODE_MINUS
    zapp.keyCodes[0x034] = ZAPP_KEYCODE_PERIOD
    zapp.keyCodes[0x01B] = ZAPP_KEYCODE_RIGHT_BRACKET
    zapp.keyCodes[0x027] = ZAPP_KEYCODE_SEMICOLON
    zapp.keyCodes[0x035] = ZAPP_KEYCODE_SLASH
    zapp.keyCodes[0x056] = ZAPP_KEYCODE_WORLD_2
    zapp.keyCodes[0x00E] = ZAPP_KEYCODE_BACKSPACE
    zapp.keyCodes[0x153] = ZAPP_KEYCODE_DELETE
    zapp.keyCodes[0x14F] = ZAPP_KEYCODE_END
    zapp.keyCodes[0x01C] = ZAPP_KEYCODE_ENTER
    zapp.keyCodes[0x001] = ZAPP_KEYCODE_ESCAPE
    zapp.keyCodes[0x147] = ZAPP_KEYCODE_HOME
    zapp.keyCodes[0x152] = ZAPP_KEYCODE_INSERT
    zapp.keyCodes[0x15D] = ZAPP_KEYCODE_MENU
    zapp.keyCodes[0x151] = ZAPP_KEYCODE_PAGE_DOWN
    zapp.keyCodes[0x149] = ZAPP_KEYCODE_PAGE_UP
    zapp.keyCodes[0x045] = ZAPP_KEYCODE_PAUSE
    zapp.keyCodes[0x146] = ZAPP_KEYCODE_PAUSE
    zapp.keyCodes[0x039] = ZAPP_KEYCODE_SPACE
    zapp.keyCodes[0x00F] = ZAPP_KEYCODE_TAB
    zapp.keyCodes[0x03A] = ZAPP_KEYCODE_CAPS_LOCK
    zapp.keyCodes[0x145] = ZAPP_KEYCODE_NUM_LOCK
    zapp.keyCodes[0x046] = ZAPP_KEYCODE_SCROLL_LOCK
    zapp.keyCodes[0x03B] = ZAPP_KEYCODE_F1
    zapp.keyCodes[0x03C] = ZAPP_KEYCODE_F2
    zapp.keyCodes[0x03D] = ZAPP_KEYCODE_F3
    zapp.keyCodes[0x03E] = ZAPP_KEYCODE_F4
    zapp.keyCodes[0x03F] = ZAPP_KEYCODE_F5
    zapp.keyCodes[0x040] = ZAPP_KEYCODE_F6
    zapp.keyCodes[0x041] = ZAPP_KEYCODE_F7
    zapp.keyCodes[0x042] = ZAPP_KEYCODE_F8
    zapp.keyCodes[0x043] = ZAPP_KEYCODE_F9
    zapp.keyCodes[0x044] = ZAPP_KEYCODE_F10
    zapp.keyCodes[0x057] = ZAPP_KEYCODE_F11
    zapp.keyCodes[0x058] = ZAPP_KEYCODE_F12
    zapp.keyCodes[0x064] = ZAPP_KEYCODE_F13
    zapp.keyCodes[0x065] = ZAPP_KEYCODE_F14
    zapp.keyCodes[0x066] = ZAPP_KEYCODE_F15
    zapp.keyCodes[0x067] = ZAPP_KEYCODE_F16
    zapp.keyCodes[0x068] = ZAPP_KEYCODE_F17
    zapp.keyCodes[0x069] = ZAPP_KEYCODE_F18
    zapp.keyCodes[0x06A] = ZAPP_KEYCODE_F19
    zapp.keyCodes[0x06B] = ZAPP_KEYCODE_F20
    zapp.keyCodes[0x06C] = ZAPP_KEYCODE_F21
    zapp.keyCodes[0x06D] = ZAPP_KEYCODE_F22
    zapp.keyCodes[0x06E] = ZAPP_KEYCODE_F23
    zapp.keyCodes[0x076] = ZAPP_KEYCODE_F24
    zapp.keyCodes[0x038] = ZAPP_KEYCODE_LEFT_ALT
    zapp.keyCodes[0x01D] = ZAPP_KEYCODE_LEFT_CONTROL
    zapp.keyCodes[0x02A] = ZAPP_KEYCODE_LEFT_SHIFT
    zapp.keyCodes[0x15B] = ZAPP_KEYCODE_LEFT_SUPER
    zapp.keyCodes[0x137] = ZAPP_KEYCODE_PRINT_SCREEN
    zapp.keyCodes[0x138] = ZAPP_KEYCODE_RIGHT_ALT
    zapp.keyCodes[0x11D] = ZAPP_KEYCODE_RIGHT_CONTROL
    zapp.keyCodes[0x036] = ZAPP_KEYCODE_RIGHT_SHIFT
    zapp.keyCodes[0x15C] = ZAPP_KEYCODE_RIGHT_SUPER
    zapp.keyCodes[0x150] = ZAPP_KEYCODE_DOWN
    zapp.keyCodes[0x14B] = ZAPP_KEYCODE_LEFT
    zapp.keyCodes[0x14D] = ZAPP_KEYCODE_RIGHT
    zapp.keyCodes[0x148] = ZAPP_KEYCODE_UP
    zapp.keyCodes[0x052] = ZAPP_KEYCODE_KP_0
    zapp.keyCodes[0x04F] = ZAPP_KEYCODE_KP_1
    zapp.keyCodes[0x050] = ZAPP_KEYCODE_KP_2
    zapp.keyCodes[0x051] = ZAPP_KEYCODE_KP_3
    zapp.keyCodes[0x04B] = ZAPP_KEYCODE_KP_4
    zapp.keyCodes[0x04C] = ZAPP_KEYCODE_KP_5
    zapp.keyCodes[0x04D] = ZAPP_KEYCODE_KP_6
    zapp.keyCodes[0x047] = ZAPP_KEYCODE_KP_7
    zapp.keyCodes[0x048] = ZAPP_KEYCODE_KP_8
    zapp.keyCodes[0x049] = ZAPP_KEYCODE_KP_9
    zapp.keyCodes[0x04E] = ZAPP_KEYCODE_KP_ADD
    zapp.keyCodes[0x053] = ZAPP_KEYCODE_KP_DECIMAL
    zapp.keyCodes[0x135] = ZAPP_KEYCODE_KP_DIVIDE
    zapp.keyCodes[0x11C] = ZAPP_KEYCODE_KP_ENTER
    zapp.keyCodes[0x037] = ZAPP_KEYCODE_KP_MULTIPLY
    zapp.keyCodes[0x04A] = ZAPP_KEYCODE_KP_SUBTRACT

  proc zappWin32InitDpi() =
    assert(nil == zappWin32SetProcessDpiAware)
    assert(nil == zappWin32SetProcessDpiAwareness)
    assert(nil == zappWin32GetDpiForMonitor)
    var user32 = LoadLibraryA("user32.dll")
    if user32 != 0:
      zappWin32SetProcessDpiAware = cast[SetProcessDPIAware](GetProcAddress(user32, "SetProcessDPIAware"))
    var shcore = LoadLibrary("shcore.dll")
    if shCore != 0:
      zappWin32SetProcessDpiAwareness = cast[SetProcessDPIAwareness](GetProcAddress(shcore, "SetProcessDpiAwareness"))
      zappWin32GetDpiForMonitor = cast[GetDPIForMonitor](GetProcAddress(shcore, "GetDpiForMonitor"))
    if zappWin32SetProcessDpiAwareness != nil:
      # if the app didn't request HighDPI rendering, let Windows do the upscaling
      var processDpiAwareness = PROCESS_SYSTEM_DPI_AWARE
      zappWin32DpiAware = true
      if not zapp.desc.highDpi:
        processDpiAwareness = PROCESS_DPI_UNAWARE
        zappWin32DpiAware = false
      discard zappWin32SetProcessDpiAwareness(processDpiAwareness)
    elif zappWin32SetProcessDpiAware != nil:
      discard zappWin32SetProcessDpiAware()
      zappWin32DpiAware = true
    # get dpi scale factor for main monitor
    if zappWin32GetDpiForMonitor != nil and zappWin32DpiAware:
      var pt = POINT(x: 1, y: 1)
      let hm = MonitorFromPoint(pt, MONITOR_DEFAULTTONEAREST)
      var dpix, dpiy: uint32
      let hr = zappWin32GetDpiForMonitor(hm, MDT_EFFECTIVE_DPI, addr dpix, addr dpiy)
      assert(SUCCEEDED(hr))
      # clamp window scale to an integer factor
      zappWin32WindowScale = float32(dpix) / 96.0
    else:
      zappWin32WindowScale = 1.0
    if zapp.desc.highDpi:
      zappWin32ContentScale = zappWin32WindowScale
    else:
      zappWin32ContentScale = 1.0
      zappWin32MouseScale = 1.0 / zappWin32WindowScale
    zapp.dpiScale = zappWin32ContentScale
    if user32 != 0:
      FreeLibrary(user32)
    if shcore != 0:
      FreeLibrary(shcore)

  proc zappWin32AppEvent(kind: ZappEventKind) =
    if zappEventsEnabled():
      zappInitEvent(kind)
      zappCallEvent(zapp.event)

  proc zappWin32UpdateDimensions(): bool =
    var rect: RECT

    if GetClientRect(zappWin32Hwnd, addr rect):
      zapp.windowWidth = int(float32((rect.right - rect.left)) / zappWin32WindowScale)
      zapp.windowHeight = int(float32((rect.bottom - rect.top)) / zappWin32WindowScale)
      let fbWidth = int(float32(zapp.windowWidth) * zappWin32ContentScale)
      let fbHeight = int(float32(zapp.windowHeight) * zappWin32ContentScale)
      if fbWidth != zapp.frameBufferWidth or fbHeight != zapp.frameBufferHeight:
        zapp.frameBufferWidth = int(float32(zapp.windowWidth) * zappWin32ContentScale)
        zapp.frameBufferHeight = int(float32(zapp.windowHeight) * zappWin32ContentScale)
        # prevent a framebuffer size of 0 when window is minimized
        if zapp.frameBufferWidth == 0:
          zapp.frameBufferWidth = 1
        if zapp.frameBufferHeight == 0:
          zapp.frameBufferHeight = 1
        return true
    else:
      zapp.windowWidth = (zapp.windowHeight = 1; zapp.windowHeight)
      zapp.frameBufferWidth = (zapp.frameBufferHeight = 1; zapp.frameBufferHeight)
    return false

  proc zappWin32Mods(): uint32 =
    if (GetKeyState(VK_SHIFT) and (1 shl 31)) != 0:
      result = result or ZAPP_MODIFIER_SHIFT
    if (GetKeyState(VK_CONTROL) and (1 shl 31)) != 0:
      result = result or ZAPP_MODIFIER_CTRL
    if (GetKeyState(VK_MENU) and (1 shl 31)) != 0:
      result = result or ZAPP_MODIFIER_ALT
    if ((GetKeyState(VK_LWIN) or GetKeyState(VK_RWIN)) and (1 shl 31)) != 0:
      result = result or ZAPP_MODIFIER_SUPER

  proc zappWin32MouseEvent(kind: ZappEventKind, btn: ZappMouseButton) =
    if zappEventsEnabled():
      zappInitEvent(kind)
      zapp.event.modifiers = zappWin32Mods()
      zapp.event.mouseButton = btn
      zapp.event.mouseX = zapp.mouseX
      zapp.event.mouseY = zapp.mouseY
      zappCallEvent(zapp.event)
  
  proc zappWin32ScrollEvent(x, y: float32) =
    if zappEventsEnabled():
      zappInitEvent(ZAPP_EVENTKIND_MOUSE_SCROLL)
      zapp.event.modifiers = zappWin32Mods()
      zapp.event.scrollX = -x / 30.0'f32
      zapp.event.scrollY = y / 30.0'f32
      zappCallEvent(zapp.event)
  
  proc zappWin32CharEvent(c: uint32, repeat: bool) =
    if zappEventsEnabled() and (c >= 32'u32):
      zappInitEvent(ZAPP_EVENTKIND_CHAR)
      zapp.event.modifiers = zappWin32Mods()
      zapp.event.charCode = c
      zapp.event.keyRepeat = repeat
      zappCallEvent(zapp.event)
  
  proc zappWin32KeyEvent(kind: ZappEventKind, vk: int32, repeat: bool) =
    if zappEventsEnabled() and (vk < ZAPP_MAX_KEYCODES):
      zappInitEvent(kind)
      zapp.event.modifiers = zappWin32Mods()
      zapp.event.keyCode = zapp.keyCodes[vk]
      zapp.event.keyRepeat = repeat
      zappCallEvent(zapp.event)

  proc zappWin32Wndproc(hWnd: HWND, uMsg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.stdcall.} =
    # FIXME: refresh rendering during resize with a WM_TIMER event
    if not zappWin32InCreateWindow:
      case uMsg
      of WM_CLOSE:
        # only give user a chance to intervene when zappQuit() wasn't already called
        if not zapp.quitOrdered:
          #[
            if window should be closed and event handling is enabled,
            give user code a chance to intervene via zappCancelQuit()
          ]#
          zapp.quitRequested = true
          zappWin32AppEvent(ZAPP_EVENTKIND_QUIT_REQUESTED)
          # if user code hasn't intervened, quit the app
          if zapp.quitRequested:
            zapp.quitOrdered = true
        if zapp.quitOrdered:
          PostQuitMessage(0)
        return 0
      of WM_SYSCOMMAND:
        case GET_SC_WPARAM(wParam)
        of SC_SCREENSAVE, SC_MONITORPOWER:
          if zapp.desc.fullscreen:
            # disable screen saver and blanking in fullscreen mode
            return 0
        of SC_KEYMENU:
          # user trying to access menu via ALT
          return 0
        else:
          discard
      of WM_ERASEBKGND:
        return 1
      of WM_SIZE:
        let iconified = wParam == SIZE_MINIMIZED
        if iconified != zappWin32Iconified:
          zappWin32Iconified = iconified
          if iconified:
            zappWin32AppEvent(ZAPP_EVENTKIND_ICONIFIED)
          else:
            zappWin32AppEvent(ZAPP_EVENTKIND_RESTORED)
        if zappWin32UpdateDimensions():
          when defined(Z_D3D11):
            zappD3d11ResizeDefaultRenderTarget()
          zappWin32AppEvent(ZAPP_EVENTKIND_RESIZED)
      of WM_SETCURSOR:
        if zapp.desc.userCursor:
          if LOWORD(lParam) == HTCLIENT:
            zappWin32AppEvent(ZAPP_EVENTKIND_UPDATE_CURSOR)
            return 1
      of WM_LBUTTONDOWN:
        zappWin32MouseEvent(ZAPP_EVENTKIND_MOUSE_DOWN, ZAPP_MOUSEBUTTON_LEFT)
      of WM_RBUTTONDOWN:
        zappWin32MouseEvent(ZAPP_EVENTKIND_MOUSE_DOWN, ZAPP_MOUSEBUTTON_RIGHT)
      of WM_MBUTTONDOWN:
        zappWin32MouseEvent(ZAPP_EVENTKIND_MOUSE_DOWN, ZAPP_MOUSEBUTTON_MIDDLE)
      of WM_LBUTTONUP:
        zappWin32MouseEvent(ZAPP_EVENTKIND_MOUSE_UP, ZAPP_MOUSEBUTTON_LEFT)
      of WM_RBUTTONUP:
        zappWin32MouseEvent(ZAPP_EVENTKIND_MOUSE_UP, ZAPP_MOUSEBUTTON_RIGHT)
      of WM_MBUTTONUP:
        zappWin32MouseEvent(ZAPP_EVENTKIND_MOUSE_UP, ZAPP_MOUSEBUTTON_MIDDLE)
      of WM_MOUSEMOVE:
        zapp.mouseX = float32(GET_X_LPARAM(lParam)) * zappWin32MouseScale
        zapp.mouseY = float32(GET_Y_LPARAM(lParam)) * zappWin32MouseScale
        if not zapp.win32MouseTracked:
          zapp.win32MouseTracked = true
          var tme: TTRACKMOUSEEVENT
          tme.cbSize = int32(sizeof(tme))
          tme.dwFlags = TME_LEAVE
          tme.hwndTrack = zappWin32Hwnd
          TrackMouseEvent(tme)
          zappWin32MouseEvent(ZAPP_EVENTKIND_MOUSE_ENTER, ZAPP_MOUSEBUTTON_INVALID)
        zappWin32MouseEvent(ZAPP_EVENTKIND_MOUSE_MOVE, ZAPP_MOUSEBUTTON_INVALID)
      of WM_MOUSELEAVE:
        zapp.win32MouseTracked = false
        zappWin32MouseEvent(ZAPP_EVENTKIND_MOUSE_LEAVE, ZAPP_MOUSEBUTTON_INVALID)
      of WM_MOUSEWHEEL:
        zappWin32ScrollEvent(0.0'f32, float32(SHORT(HIWORD(wParam))))
      of WM_MOUSEHWHEEL:
        zappWin32ScrollEvent(float32(SHORT(HIWORD(wParam))), 0.0'f32)
      of WM_CHAR:
        zappWin32CharEvent(uint32(wParam), not not((lParam and 0x40000000) != 0))
      of WM_KEYDOWN, WM_SYSKEYDOWN:
        zappWin32KeyEvent(ZAPP_EVENTKIND_KEY_DOWN, int32(HIWORD(lParam) and 0x1FF), not not((lParam and 0x40000000) != 0))
      of WM_KEYUP, WM_SYSKEYUP:
        zappWin32KeyEvent(ZAPP_EVENTKIND_KEY_UP, int32(HIWORD(lParam) and 0x1FF), false)
      else:
        discard
    return DefWindowProcW(hWnd, uMsg, wParam, lParam)

  proc zappWin32CreateWindow() =
    var wndclassw: WNDCLASSW
    wndclassw.style = CS_HREDRAW or CS_VREDRAW or CS_OWNDC
    wndclassw.lpfnWndProc = zappWin32Wndproc
    wndclassw.hInstance = GetModuleHandleW(nil)
    wndclassw.hCursor = LoadCursor(0, IDC_ARROW)
    wndclassw.hIcon = LoadIcon(0, IDI_WINLOGO)
    wndclassw.lpszClassName = L"ZAPP"
    RegisterClassW(addr wndclassw)

    var winStyle: DWORD
    let winExStyle: int32 = WS_EX_APPWINDOW or WS_EX_WINDOWEDGE
    var rect: RECT = RECT(left: 0, top: 0, bottom: 0, right: 0)
    if zapp.desc.fullscreen:
      winStyle = WS_POPUP or WS_SYSMENU or WS_VISIBLE
      rect.right = GetSystemMetrics(SM_CXSCREEN)
      rect.bottom = GetSystemMetrics(SM_CYSCREEN)
    else:
      winStyle = WS_CLIPSIBLINGS or WS_CLIPCHILDREN or 
        WS_CAPTION or WS_SYSMENU or 
        WS_MINIMIZEBOX or WS_MAXIMIZEBOX or 
        WS_SIZEBOX
      rect.right = int32(float32(zapp.windowWidth) * zappWin32WindowScale)
      rect.bottom = int32(float32(zapp.windowHeight) * zappWin32WindowScale)
    AdjustWindowRectEx(addr rect, winStyle, FALSE, winExStyle)
    let 
      winWidth = rect.right - rect.left
      winHeight = rect.bottom - rect.top
    zappWin32InCreateWindow = true
    zappWin32Hwnd = CreateWindowExW(
      winExStyle,           # dwExStyle #
      L"ZAPP",              # lpClassName #
      zapp.windowTitleWide, # lpWindowName #
      winStyle,             # dwStyle #
      CW_USEDEFAULT,        # X #
      CW_USEDEFAULT,        # Y #
      winWidth,             # nWidth #
      winHeight,            # nHeight #
      0,                    # hWndParent #
      0,                    # hMenu #
      GetModuleHandle(nil), # hInstance #
      nil                   # lParam #
    )
    ShowWindow(zappWin32Hwnd, SW_SHOW)
    zappWin32InCreateWindow = false
    zappWin32DC = GetDC(zappWin32Hwnd)
    assert(zappWin32DC != 0)
    discard zappWin32UpdateDimensions()
  
  proc zappWin32DestroyWindow() =
    DestroyWindow(zappWin32Hwnd)
    zappWin32Hwnd = 0
    UnregisterClassW("ZAPP", GetModuleHandle(nil))

  proc zappRun*(desc: var ZappDesc) =
    zappInitState(desc)
    zappWin32InitKeyTable()
    zapp.windowTitleWide = newWideCString(zapp.windowTitle)
    zappWin32InitDpi()
    zappWin32CreateWindow()
    when defined(Z_D3D11):
      zappD3d11CreateDeviceAndSwapchain()
      zappD3d11CreateDefaultRenderTarget()
    zapp.valid = true

    var done = false
    while not (done or zapp.quitOrdered):
      var msg: MSG
      while PeekMessageW(msg, 0, 0, 0, PM_REMOVE):
        if WM_QUIT == msg.message:
          done = true
          continue
        else:
          TranslateMessage(msg)
          DispatchMessage(msg)
      zappFrame()
      when defined(Z_D3D11):
        discard zappDxgiSwapChain.lpVtbl.Present(zappDxgiSwapChain, uint32(zapp.swapInterval), 0'u32)
        if IsIconic(zappWin32Hwnd):
          Sleep(int32(16 * zapp.swapInterval))
      if zapp.quitRequested:
        PostMessage(zappWin32Hwnd, WM_CLOSE, 0, 0)
    
    zappCallCleanUp()
    when defined(Z_D3D11):
      zappD3d11DestroyDefaultRenderTarget()
      zappD3d11DestroyDeviceAndSwapChain()
    zappWin32DestroyWindow()

proc zMain*(): ZappDesc =
  result