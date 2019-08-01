import options, sequtils

const 
  ZG_STRING_SIZE = 16
  ZG_SLOT_SHIFT = 16
  ZG_SLOT_MASK = (1 shl ZG_SLOT_SHIFT) - 1
  ZG_MAX_POOL_SIZE = (1 shl ZG_SLOT_SHIFT)
  ZG_DEFAULT_BUFFER_POOL_SIZE = 128
  ZG_DEFAULT_IMAGE_POOL_SIZE = 128
  ZG_DEFAULT_SHADER_POOL_SIZE = 32
  ZG_DEFAULT_PIPELINE_POOL_SIZE = 64
  ZG_DEFAULT_PASS_POOL_SIZE = 16
  ZG_DEFAULT_CONTEXT_POOL_SIZE = 16
  ZG_INVALID_ID = 0'u32
  ZG_NUM_SHADER_STAGES = 2
  ZG_NUM_INFLIGHT_FRAMES = 2
  ZG_MAX_COLOR_ATTACHMENTS = 4
  ZG_MAX_SHADERSTAGE_BUFFERS = 8
  ZG_MAX_SHADERSTAGE_IMAGES = 12
  ZG_MAX_SHADERSTAGE_UBS = 4
  ZG_MAX_UB_MEMBERS = 16
  ZG_MAX_VERTEX_ATTRIBUTES = 16
  ZG_MAX_MIPMAPS = 16
  ZG_MAX_TEXTUREARRAY_LAYERS = 128
  ZG_INVALID_SLOT_INDEX = 0

when not defined(ZG_DEFAULT_CLEAR_RED):
  const ZG_DEFAULT_CLEAR_RED = 0.5'f32
when not defined(ZG_DEFAULT_CLEAR_GREEN):
  const ZG_DEFAULT_CLEAR_GREEN = 0.5'f32
when not defined(ZG_DEFAULT_CLEAR_BLUE):
  const ZG_DEFAULT_CLEAR_BLUE = 0.5'f32
when not defined(ZG_DEFAULT_CLEAR_ALPHA):
  const ZG_DEFAULT_CLEAR_ALPHA = 1.0'f32
when not defined(ZG_DEFAULT_CLEAR_DEPTH):
  const ZG_DEFAULT_CLEAR_DEPTH = 1.0'f32
when not defined(ZG_DEFAULT_CLEAR_STENCIL):
  const ZG_DEFAULT_CLEAR_STENCIL = 0

template zgDef(val, def: untyped): untyped =
  (if ((val) == 0): (def) else: (val))

template Z_FREE(p: untyped) =
  dealloc(p)

type
  ZgBuffer = object
    id: uint32
  
  ZgImage = object
    id: uint32
  
  ZgShader = object
    id: uint32
  
  ZgPipeline = object
    id: uint32
  
  ZgPass = object
    id: uint32
  
  ZgContext = object
    id: uint32

  ZgStr = object
    buf: array[ZG_STRING_SIZE, char]

  ZgAction* {.size: sizeof(uint32).} = enum
    ZG_ACTION_DEFAULT
    ZG_ACTION_CLEAR
    ZG_ACTION_LOAD
    ZG_ACTION_DONTCARE
    ZG_ACTION_COUNT
    ZG_ACTION_FORCE_U32 = 0x7FFFFFFF

  ZgColorAttachmentAction* = object
    action*: ZgAction
    val*: array[4, float32]
  
  ZgDepthAttachmentAction = object
    action: ZgAction
    val: float
  
  ZgStencilAttachmentAction = object
    action: ZgAction
    val: uint8
  
  ZgPassAction* = object
    startCanary: uint32
    colors*: array[ZG_MAX_COLOR_ATTACHMENTS, ZgColorAttachmentAction]
    depth: ZgDepthAttachmentAction
    stencil: ZgStencilAttachmentAction
    endCanary: uint32

  ZgResourceState {.size: sizeof(uint32).} = enum
    ZG_RESOURCESTATE_INITIAL
    ZG_RESOURCESTATE_ALLOC
    ZG_RESOURCESTATE_VALID
    ZG_RESOURCESTATE_FAILED
    ZG_RESOURCESTATE_INVALID
    ZG_RESOURCESTATE_FORCE_U32 = 0x7FFFFFFF

  ZgBufferKind {.size: sizeof(uint32).} = enum
    ZG_BUFFERKIND_DEFAULT
    ZG_BUFFERKIND_VERTEXBUFFER
    ZG_BUFFERKIND_INDEXBUFFER
    ZG_BUFFERKIND_COUNT
    ZG_BUFFERKIND_FORCE_U32 = 0x7FFFFFFF

  ZgUsage {.size: sizeof(uint32).} = enum
    ZG_USAGE_DEFAULT
    ZG_USAGE_IMMUTABLE
    ZG_USAGE_DYNAMIC
    ZG_USAGE_STREAM
    ZG_USAGE_COUNT
    ZG_USAGE_FORCE_U32 = 0x7FFFFFFF

  ZgImageKind {.size: sizeof(uint32).} = enum
    ZG_IMAGEKIND_DEFAULT
    ZG_IMAGEKIND_2D
    ZG_IMAGEKIND_CUBE
    ZG_IMAGEKIND_3D
    ZG_IMAGEKIND_ARRAY
    ZG_IMAGEKIND_COUNT
    ZG_IMAGEKIND_FORCE_U32 = 0x7FFFFFFF
  
  ZgIndexKind {.size: sizeof(uint32).} = enum
    ZG_INDEXKIND_DEFAULT
    ZG_INDEXKIND_NONE
    ZG_INDEXKIND_UINT16
    ZG_INDEXKIND_UINT32
    ZG_INDEXKIND_COUNT
    ZG_INDEXKIND_FORCE_U32 = 0x7FFFFFFF
  
  ZgPixelFormat {.size: sizeof(uint32).} = enum
    ZG_PIXELFORMAT_DEFAULT
    ZG_PIXELFORMAT_NONE
    ZG_PIXELFORMAT_RGBA8
    ZG_PIXELFORMAT_RGB8
    ZG_PIXELFORMAT_RGBA4
    ZG_PIXELFORMAT_R5G6B5
    ZG_PIXELFORMAT_R5G5B5A1
    ZG_PIXELFORMAT_R10G10B10A2
    ZG_PIXELFORMAT_RGBA32F
    ZG_PIXELFORMAT_RGBA16F
    ZG_PIXELFORMAT_R32F
    ZG_PIXELFORMAT_R16F
    ZG_PIXELFORMAT_L8
    ZG_PIXELFORMAT_DXT1
    ZG_PIXELFORMAT_DXT3
    ZG_PIXELFORMAT_DXT5
    ZG_PIXELFORMAT_DEPTH
    ZG_PIXELFORMAT_DEPTHSTENCIL
    ZG_PIXELFORMAT_PVRTC2_RGB
    ZG_PIXELFORMAT_PVRTC4_RGB
    ZG_PIXELFORMAT_PVRTC2_RGBA
    ZG_PIXELFORMAT_PVRTC4_RGBA
    ZG_PIXELFORMAT_ETC2_RGB8
    ZG_PIXELFORMAT_ETC2_SRGB8
    ZG_PIXELFORMAT_COUNT
    ZG_PIXELFORMAT_FORCE_U32 = 0x7FFFFFFF

  ZgFilter {.size: sizeof(uint32).} = enum
    ZG_FILTER_DEFAULT
    ZG_FILTER_NEAREST
    ZG_FILTER_LINEAR
    ZG_FILTER_NEAREST_MIPMAP_NEAREST
    ZG_FILTER_NEAREST_MIPMAP_LINEAR
    ZG_FILTER_LINEAR_MIPMAP_NEAREST
    ZG_FILTER_LINEAR_MIPMAP_LINEAR
    ZG_FILTER_COUNT
    ZG_FILTER_FORCE_U32 = 0x7FFFFFFF

  ZgWrap {.size: sizeof(uint32).} = enum
    ZG_WRAP_DEFAULT
    ZG_WRAP_REPEAT
    ZG_WRAP_CLAMP_TO_EDGE
    ZG_WRAP_MIRRORED_REPEAT
    ZG_WRAP_COUNT
    ZG_WRAP_FORCE_U32 = 0x7FFFFFFF

  ZgSlot = object
    id: uint32
    ctxId: uint32
    state: ZgResourceState

  ZgDesc* = object
    startCanary: uint32
    bufferPoolSize: int
    imagePoolSize: int
    shaderPoolSize: int
    pipelinePoolSize: int
    passPoolSize: int
    contextPoolSize: int
    # GL Specific
    # TODO: GL
    # Metal Specific
    # TODO: Metal
    # D3D11 Specific
    d3d11Device*: pointer
    d3d11DeviceContext*: pointer
    d3d11RenderTargetViewCb*: proc(): pointer
    d3d11DepthStencilViewCb*: proc(): pointer
    endCanary: uint32

  ZgValidateError = enum
    # special case 'validation was successful'
    ZG_VALIDATE_SUCCESS
    
    # buffer creation
    ZG_VALIDATE_BUFFERDESC_CANARY
    ZG_VALIDATE_BUFFERDESC_SIZE
    ZG_VALIDATE_BUFFERDESC_CONTENT
    ZG_VALIDATE_BUFFERDESC_NO_CONTENT

    # image creation
    ZG_VALIDATE_IMAGEDESC_CANARY
    ZG_VALIDATE_IMAGEDESC_WIDTH
    ZG_VALIDATE_IMAGEDESC_HEIGHT
    ZG_VALIDATE_IMAGEDESC_RT_PIXELFORMAT
    ZG_VALIDATE_IMAGEDESC_NONRT_PIXELFORMAT
    ZG_VALIDATE_IMAGEDESC_MSAA_BUT_NO_RT
    ZG_VALIDATE_IMAGEDESC_NO_MSAA_RT_SUPPORT
    ZG_VALIDATE_IMAGEDESC_RT_IMMUTABLE
    ZG_VALIDATE_IMAGEDESC_RT_NO_CONTENT
    ZG_VALIDATE_IMAGEDESC_CONTENT
    ZG_VALIDATE_IMAGEDESC_NO_CONTENT

    # shader creation
    ZG_VALIDATE_SHADERDESC_CANARY
    ZG_VALIDATE_SHADERDESC_SOURCE
    ZG_VALIDATE_SHADERDESC_BYTECODE
    ZG_VALIDATE_SHADERDESC_SOURCE_OR_BYTECODE
    ZG_VALIDATE_SHADERDESC_NO_BYTECODE_SIZE
    ZG_VALIDATE_SHADERDESC_NO_CONT_UBS
    ZG_VALIDATE_SHADERDESC_NO_CONT_IMGS
    ZG_VALIDATE_SHADERDESC_NO_CONT_UB_MEMBERS
    ZG_VALIDATE_SHADERDESC_NO_UB_MEMBERS
    ZG_VALIDATE_SHADERDESC_UB_MEMBER_NAME
    ZG_VALIDATE_SHADERDESC_UB_SIZE_MISMATCH
    ZG_VALIDATE_SHADERDESC_IMG_NAME
    ZG_VALIDATE_SHADERDESC_ATTR_NAMES
    ZG_VALIDATE_SHADERDESC_ATTR_SEMANTICS
    ZG_VALIDATE_SHADERDESC_ATTR_STRING_TOO_LONG

    # pipeline creation
    ZG_VALIDATE_PIPELINEDESC_CANARY
    ZG_VALIDATE_PIPELINEDESC_SHADER
    ZG_VALIDATE_PIPELINEDESC_NO_ATTRS
    ZG_VALIDATE_PIPELINEDESC_LAYOUT_STRIDE4
    ZG_VALIDATE_PIPELINEDESC_ATTR_NAME
    ZG_VALIDATE_PIPELINEDESC_ATTR_SEMANTICS

    # pass creation
    ZG_VALIDATE_PASSDESC_CANARY
    ZG_VALIDATE_PASSDESC_NO_COLOR_ATTS
    ZG_VALIDATE_PASSDESC_NO_CONT_COLOR_ATTS
    ZG_VALIDATE_PASSDESC_IMAGE
    ZG_VALIDATE_PASSDESC_MIPLEVEL
    ZG_VALIDATE_PASSDESC_FACE
    ZG_VALIDATE_PASSDESC_LAYER
    ZG_VALIDATE_PASSDESC_SLICE
    ZG_VALIDATE_PASSDESC_IMAGE_NO_RT
    ZG_VALIDATE_PASSDESC_COLOR_PIXELFORMATS
    ZG_VALIDATE_PASSDESC_COLOR_INV_PIXELFORMAT
    ZG_VALIDATE_PASSDESC_DEPTH_INV_PIXELFORMAT
    ZG_VALIDATE_PASSDESC_IMAGE_SIZES
    ZG_VALIDATE_PASSDESC_IMAGE_SAMPLE_COUNTS

    # zgBeginPass validation
    ZG_VALIDATE_BEGINPASS_PASS
    ZG_VALIDATE_BEGINPASS_IMAGE

    # zgApplyPipeline validation
    ZG_VALIDATE_APIP_PIPELINE_VALID_ID
    ZG_VALIDATE_APIP_PIPELINE_EXISTS
    ZG_VALIDATE_APIP_PIPELINE_VALID
    ZG_VALIDATE_APIP_SHADER_EXISTS
    ZG_VALIDATE_APIP_SHADER_VALID
    ZG_VALIDATE_APIP_ATT_COUNT
    ZG_VALIDATE_APIP_COLOR_FORMAT
    ZG_VALIDATE_APIP_DEPTH_FORMAT
    ZG_VALIDATE_APIP_SAMPLE_COUNT

    # zgApplyBindings validation
    ZG_VALIDATE_ABND_PIPELINE
    ZG_VALIDATE_ABND_PIPELINE_EXISTS
    ZG_VALIDATE_ABND_PIPELINE_VALID
    ZG_VALIDATE_ABND_VBS
    ZG_VALIDATE_ABND_VB_EXISTS
    ZG_VALIDATE_ABND_VB_TYPE
    ZG_VALIDATE_ABND_VB_OVERFLOW
    ZG_VALIDATE_ABND_NO_IB
    ZG_VALIDATE_ABND_IB
    ZG_VALIDATE_ABND_IB_EXISTS
    ZG_VALIDATE_ABND_IB_TYPE
    ZG_VALIDATE_ABND_IB_OVERFLOW
    ZG_VALIDATE_ABND_VS_IMGS
    ZG_VALIDATE_ABND_VS_IMG_EXISTS
    ZG_VALIDATE_ABND_VS_IMG_TYPES
    ZG_VALIDATE_ABND_FS_IMGS
    ZG_VALIDATE_ABND_FS_IMG_EXISTS
    ZG_VALIDATE_ABND_FS_IMG_TYPES

    # zgApplyUniforms validation
    ZG_VALIDATE_AUB_NO_PIPELINE
    ZG_VALIDATE_AUB_NO_UB_AT_SLOT
    ZG_VALIDATE_AUB_SIZE

    # zgUpdateBuffer validation
    ZG_VALIDATE_UPDATEBUF_USAGE
    ZG_VALIDATE_UPDATEBUF_SIZE
    ZG_VALIDATE_UPDATEBUF_ONCE
    ZG_VALIDATE_UPDATEBUF_APPEND

    # zgAppendBuffer validation
    ZG_VALIDATE_APPENDBUF_USAGE
    ZG_VALIDATE_APPENDBUF_SIZE
    ZG_VALIDATE_APPENDBUF_UPDATE

    # zgUpdateImage validation
    ZG_VALIDATE_UPDIMG_USAGE
    ZG_VALIDATE_UPDIMG_NOTENOUGHDATA
    ZG_VALIDATE_UPDIMG_SIZE
    ZG_VALIDATE_UPDIMG_COMPRESSED
    ZG_VALIDATE_UPDIMG_ONCE

  ZgPool = object
    size: int
    queueTop: int
    genCtrs: seq[uint32]
    freeQueue: seq[int]

when defined(Z_D3D11):
  when not defined(WIN32_LEAN_AND_MEAN):
    const WIN32_LEAN_AND_MEAN = 1
  when not defined(D3D11_NO_HELPERS):
    const D3D11_NO_HELPERS = 1
  when not defined(CINTERFACE):
    const CINTERFACE = 1
  when not defined(COBJMACROS):
    const COBJMACROS = 1
  import winim/lean, d3d11, d3dcompiler, dxgi
  
  #== D3D11 BACKEND DECLARATIONS ==#
  type
    ZgBufferP = ref object
      slot: ZgSlot
      size: int
      appendPos: int
      appendOverflow: bool
      kind: ZgBufferKind
      usage: ZgUsage
      updateFrameIndex: uint32
      appendFrameIndex: uint32
      d3d11Buf: ptr ID3D11Buffer
    
    ZgImageP = ref object
      slot: ZgSlot
      kind: ZgImageKind
      renderTarget: bool
      width: int
      height: int
      depth: int
      numMipMaps: uint32
      usage: ZgUsage
      pixelFormat: ZgPixelFormat
      sampleCount: int
      minFilter: ZgFilter
      magFilter: ZgFilter
      wrapU: ZgWrap
      wrapV: ZgWrap
      wrapW: ZgWrap
      maxAnistropy: uint32
      updFrameIndex: uint32
      d3d11Format: DXGI_FORMAT
      d3d11Tex2d: ptr ID3D11Texture2D
      d3d11Tex3d: ptr ID3D11Texture3D
      d3d11TexDs: ptr ID3D11Texture2D
      d3d11TexMsaa: ptr ID3D11Texture2D
      d3d11Srv: ptr ID3D11ShaderResourceView
      d3d11Smp: ptr ID3D11SamplerState
    
    ZgUniformBlock = object
      size: int
    
    ZgShaderImage = object
      kind: ZgImageKind
    
    ZgShaderAttr = object
      semName: ZgStr
      semIndex: int
    
    ZgShaderStage = object
      numUniformBlocks: int
      numImages: int
      attrs: array[ZG_MAX_VERTEX_ATTRIBUTES, ZgShaderAttr]
      uniformBlocks: array[ZG_MAX_SHADERSTAGE_UBS, ZgUniformBlock]
      images: array[ZG_MAX_SHADERSTAGE_IMAGES, ZgShaderImage]
      d3d11Cbs: array[ZG_MAX_SHADERSTAGE_UBS, ptr ID3D11Buffer]
    
    ZgShaderP = ref object
      slot: ZgSlot
      attrs: array[ZG_MAX_VERTEX_ATTRIBUTES, ZgShaderAttr]
      stage: array[ZG_NUM_SHADER_STAGES, ZgShaderStage]
      d3d11Vs: ptr ID3D11VertexShader
      d3d11Fs: ptr ID3D11PixelShader
      d3d11VsBlob: pointer
      d3d11VsBlobLength: int
    
    ZgPipelineP = ref object
      slot: ZgSlot
      shader: ZgShaderP
      shaderId: ZgShader
      indexKind: ZgIndexKind
      vertexLayoutValid: array[ZG_MAX_SHADERSTAGE_BUFFERS, bool]
      colorAttachmentCount: int
      colorFormat: ZgPixelFormat
      depthFormat: ZgPixelFormat
      sampleCount: int
      blendColor: array[4, float32]
      d3d11StencilRef: uint32
      d3d11VbStrides: array[ZG_MAX_SHADERSTAGE_BUFFERS, uint32]
      d3d11Topology: D3D_PRIMITIVE_TOPOLOGY
      d3d11IndexFormat: DXGI_FORMAT
      d3d11Il: ptr ID3D11InputLayout
      d3d11Rs: ptr ID3D11RasterizerState
      d3d11Dss: ptr ID3D11DepthStencilState
      d3d11Bs: ptr ID3D11BlendState

    ZgAttachment = object
      image: ZgImageP
      imageId: ZgImage
      mipLevel: uint32
      slice: uint32
    
    ZgPassP = ref object
      slot: ZgSlot
      numColorAtts: int
      colorAtts: array[ZG_MAX_COLOR_ATTACHMENTS, ZgAttachment]
      dsAtt: ZgAttachment
      d3d11Rtvs: array[ZG_MAX_COLOR_ATTACHMENTS, ptr ID3D11RenderTargetView]
      d3d11Dsv: ptr ID3D11DepthStencilView
    
    ZgContextP = ref object
      slot: ZgSlot
    
    ZgD3d11Backend = object
      valid: bool
      dev: ptr ID3D11Device
      ctx: ptr ID3D11DeviceContext
      rtvCb: proc(): pointer
      dsvCb: proc(): pointer
      inPass: bool
      useIndexedDraw: bool
      curWidth: int
      curHeight: int
      numRtvs: int
      curPass: ZgPassP
      curPassId: ZgPass
      curPipeline: ZgPipelineP
      curPipelineId: ZgPipeline
      curRtvs: array[ZG_MAX_COLOR_ATTACHMENTS, ptr ID3D11RenderTargetView]
      curDsv: ptr ID3D11DepthStencilView
      # on-demand loaded d3dcompiler_47.dll handles
      d3dCompilerDll: HINSTANCE
      d3dCompilerDllLoadFailed: bool
      d3dCompileFunc: pD3DCompile
      # the following arrays are used for unbinding resources
      # they will always contain zeroes
      zeroRtvs: array[ZG_MAX_COLOR_ATTACHMENTS, ptr ID3D11RenderTargetView]
      zeroVbs: array[ZG_MAX_SHADERSTAGE_BUFFERS, ptr ID3D11Buffer]
      zeroVbOffsets: array[ZG_MAX_SHADERSTAGE_BUFFERS, uint32]
      zeroVbStrides: array[ZG_MAX_SHADERSTAGE_BUFFERS, uint32]
      zeroCbs: array[ZG_MAX_SHADERSTAGE_UBS, ptr ID3D11Buffer]
      zeroSrvs: array[ZG_MAX_SHADERSTAGE_IMAGES, ptr ID3D11ShaderResourceView]
      zeroSmps: array[ZG_MAX_SHADERSTAGE_IMAGES, ptr ID3D11SamplerState]
      # global subresourcedata array for texture updates
      subResDaa: array[ZG_MAX_MIPMAPS * ZG_MAX_TEXTUREARRAY_LAYERS, D3D11_SUBRESOURCE_DATA]

type
  ZgPools = object
    bufferPool: ZgPool
    imagePool: ZgPool
    shaderPool: ZgPool
    pipelinePool: ZgPool
    passPool: ZgPool
    contextPool: ZgPool
    buffers: seq[ZgBufferP]
    images: seq[ZgImageP]
    shaders: seq[ZgShaderP]
    pipelines: seq[ZgPipelineP]
    passes: seq[ZgPassP]
    contexts: seq[ZgContextP]


  ZgState = object
    valid: bool
    desc: ZgDesc
    frameIndex: uint32
    activeContext: ZgContext
    curPass: ZgPass
    curPipeline: ZgPipeline
    passValid: bool
    bindingsValid: bool
    nextDrawValid: bool
    when defined(Z_DEBUG):
      validateError: ZgValidateError
    pools: ZgPools
    when defined(Z_GLCORE33):
      #TODO: GL backend
      discard
    elif defined(Z_METAL):
      #TODO: Metal backend
      discard
    elif defined(Z_D3D11):
      d3d11: ZgD3d11Backend
    when defined(Z_TRACE_HOOKS):
      #TODO: Trace hooks
      discard

var zg: ZgState

when defined(Z_D3D11):
  proc zgSetupBackend(desc: ZgDesc) =
    assert(desc.d3d11Device != nil)
    assert(desc.d3d11DeviceContext != nil)
    assert(desc.d3d11RenderTargetViewCb != nil)
    assert(desc.d3d11DepthStencilViewCb != nil)
    assert(desc.d3d11RenderTargetViewCb != desc.d3d11DepthStencilViewCb)
    zg.d3d11.valid = true
    zg.d3d11.dev = cast[ptr ID3D11Device](desc.d3d11Device)
    zg.d3d11.ctx = cast[ptr ID3D11DeviceContext](desc.d3d11DeviceContext)
    zg.d3d11.rtvCb = desc.d3d11RenderTargetViewCb
    zg.d3d11.dsvCb = desc.d3d11DepthStencilViewCb

  proc zgD3d11ClearState() =
    # clear all the device context state, so that resource refs don't
    # stay stuck in the d3d device context
    zg.d3d11.ctx.lpVtbl.OMSetRenderTargets(zg.d3d11.ctx, ZG_MAX_COLOR_ATTACHMENTS, addr zg.d3d11.zeroRtvs[0], nil)
    zg.d3d11.ctx.lpVtbl.RSSetState(zg.d3d11.ctx, nil)
    zg.d3d11.ctx.lpVtbl.OMSetDepthStencilState(zg.d3d11.ctx, nil, 0)
    zg.d3d11.ctx.lpVtbl.OMSetBlendState(zg.d3d11.ctx, nil, [0.0'f32, 0.0, 0.0, 0.0], 0xFFFFFFFF'u32)
    zg.d3d11.ctx.lpVtbl.IASetVertexBuffers(zg.d3d11.ctx, 0, ZG_MAX_SHADERSTAGE_BUFFERS, addr zg.d3d11.zeroVbs[0], addr zg.d3d11.zeroVbStrides[0], addr zg.d3d11.zeroVbOffsets[0])
    zg.d3d11.ctx.lpVtbl.IASetIndexBuffer(zg.d3d11.ctx, nil, DXGI_FORMAT_UNKNOWN, 0)
    zg.d3d11.ctx.lpVtbl.IASetInputLayout(zg.d3d11.ctx, nil)
    zg.d3d11.ctx.lpVtbl.VSSetShader(zg.d3d11.ctx, nil, nil, 0)
    zg.d3d11.ctx.lpVtbl.PSSetShader(zg.d3d11.ctx, nil, nil, 0)
    zg.d3d11.ctx.lpVtbl.VSSetConstantBuffers(zg.d3d11.ctx, 0, ZG_MAX_SHADERSTAGE_UBS, addr zg.d3d11.zeroCbs[0])
    zg.d3d11.ctx.lpVtbl.PSSetConstantBuffers(zg.d3d11.ctx, 0, ZG_MAX_SHADERSTAGE_UBS, addr zg.d3d11.zeroCbs[0])
    zg.d3d11.ctx.lpVtbl.VSSetShaderResources(zg.d3d11.ctx, 0, ZG_MAX_SHADERSTAGE_IMAGES, addr zg.d3d11.zeroSrvs[0])
    zg.d3d11.ctx.lpVtbl.PSSetShaderResources(zg.d3d11.ctx, 0, ZG_MAX_SHADERSTAGE_IMAGES, addr zg.d3d11.zeroSrvs[0])
    zg.d3d11.ctx.lpVtbl.VSSetSamplers(zg.d3d11.ctx, 0, ZG_MAX_SHADERSTAGE_IMAGES, addr zg.d3d11.zeroSmps[0])
    zg.d3d11.ctx.lpVtbl.PSSetSamplers(zg.d3d11.ctx, 0, ZG_MAX_SHADERSTAGE_IMAGES, addr zg.d3d11.zeroSmps[0])
  
  proc zgCreateContext(ctx: ZgContextP): ZgResourceState =
    result = ZG_RESOURCESTATE_VALID

  proc zgResetStateCache() =
    zgD3d11ClearState()

  proc zgActivateContext(ctx: ZgContextP) =
    zgResetStateCache()
  
  proc zgBeginPass(pass: Option[ZgPassP]; action: ZgPassAction; w, h: int32) =
    assert(not zg.d3d11.inPass)
    zg.d3d11.inPass = true
    zg.d3d11.curWidth = w
    zg.d3d11.curHeight = h
    if pass.isSome():
      var pass = get(pass)
      zg.d3d11.curPass = pass
      zg.d3d11.curPassId.id = pass.slot.id
      zg.d3d11.numRtvs = 0
      for i in 0 ..< ZG_MAX_COLOR_ATTACHMENTS:
        zg.d3d11.curRtvs[i] = pass.d3d11Rtvs[i]
        if zg.d3d11.curRtvs[i] != nil:
          inc(zg.d3d11.numRtvs)
      zg.d3d11.curDsv = pass.d3d11Dsv
    else:
      # render to default frame buffer
      zg.d3d11.curPass = nil
      zg.d3d11.curPassId.id = ZG_INVALID_ID
      zg.d3d11.numRtvs = 1
      zg.d3d11.curRtvs[0] = cast[ptr ID3D11RenderTargetView](zg.d3d11.rtvCb())
      for i in 1 ..< ZG_MAX_COLOR_ATTACHMENTS:
        zg.d3d11.curRtvs[i] = nil
      zg.d3d11.curDsv = cast[ptr ID3D11DepthStencilView](zg.d3d11.dsvCb())
      assert((zg.d3d11.curRtvs[0] != nil) and (zg.d3d11.curDsv != nil))
    # apply the render-target- and depth-stencil-views
    zg.d3d11.ctx.lpVtbl.OMSetRenderTargets(zg.d3d11.ctx, ZG_MAX_COLOR_ATTACHMENTS, addr zg.d3d11.curRtvs[0], zg.d3d11.curDsv)

    # set viewport and scissor rect to cover the whole screen
    var vp: D3D11_VIEWPORT
    vp.Width = float32(w)
    vp.Height = float32(h)
    vp.MaxDepth = 1.0'f32
    zg.d3d11.ctx.lpVtbl.RSSetViewports(zg.d3d11.ctx, 1, addr vp)
    var rect: D3D11_RECT
    rect.left = 0
    rect.top = 0
    rect.right = w
    rect.bottom = h
    zg.d3d11.ctx.lpVtbl.RSSetScissorRects(zg.d3d11.ctx, 1, addr rect)

    # perform clear action
    for i in 0 ..< zg.d3d11.numRtvs:
      if action.colors[i].action == ZG_ACTION_CLEAR:
        zg.d3d11.ctx.lpVtbl.ClearRenderTargetView(zg.d3d11.ctx, zg.d3d11.curRtvs[i], action.colors[i].val)
    var dsFlags: uint32
    if action.depth.action == ZG_ACTION_CLEAR:
      dsFlags = dsFlags or D3D11_CLEAR_DEPTH.ord()
    if action.stencil.action == ZG_ACTION_CLEAR:
      dsFlags = dsFlags or D3D11_CLEAR_STENCIL.ord()
    if (0'u32 != dsFlags) and (zg.d3d11.curDsv != nil):
      zg.d3d11.ctx.lpVtbl.ClearDepthStencilView(zg.d3d11.ctx, zg.d3d11.curDsv, dsFlags, action.depth.val, action.stencil.val)
  
  proc zgD3d11CalcSubResource(mipSlice, arraySlice, mipLevels: uint32): uint32 =
    result = mipSlice + arraySlice * mipLevels

  proc zgEndPassP() =
    assert(zg.d3d11.inPass and zg.d3d11.ctx != nil)
    zg.d3d11.inPass = false

    # need to resolve MSAA render target into texture?
    if zg.d3d11.curPass != nil:
      assert(zg.d3d11.curPass[].slot.id == zg.d3d11.curPassId.id)
      for i in 0 ..< zg.d3d11.numRtvs:
        var att = zg.d3d11.curPass[].colorAtts[i]
        assert(att.image[].slot.id == att.imageId.id)
        if att.image[].sampleCount > 1:
          assert((att.image[].d3d11Tex2d != nil) and (att.image[].d3d11TexMsaa != nil) and (att.image[].d3d11Tex3d != nil))
          assert(DXGI_FORMAT_UNKNOWN != att.image[].d3d11Format)
          let 
            img = att.image
            dstSubres = zgd3d11CalcSubResource(att.mipLevel, att.slice, img.numMipMaps)
          zg.d3d11.ctx.lpVtbl.ResolveSubresource(
            zg.d3d11.ctx,
            cast[ptr ID3D11Resource](img[].d3d11Tex2d),
            dstSubres,
            cast[ptr ID3D11Resource](img[].d3d11TexMsaa),
            0,
            img[].d3d11Format
          )
    zg.d3d11.curPass = nil
    zg.d3d11.curPassId.id = ZG_INVALID_ID
    zg.d3d11.curPipeline = nil
    zg.d3d11.curPipelineId.id = ZG_INVALID_ID
    for i in 0 ..< ZG_MAX_COLOR_ATTACHMENTS:
      zg.d3d11.curRtvs[i] = nil
    zg.d3d11.curDsv = nil
    zgD3d11ClearState()
  
  proc zgDestroyBuffer(buf: ZgBufferP) =
    assert(buf != nil)
    if buf.d3d11Buf != nil:
      discard buf.d3d11Buf.lpVtbl.Release(buf.d3d11Buf)
  
  proc zgDestroyImage(img: ZgImageP) =
    assert(img != nil)
    if img.d3d11Tex2d != nil:
      discard img.d3d11Tex2d.lpVtbl.Release(img.d3d11Tex2d)
    if img.d3d11Tex3d != nil:
      discard img.d3d11Tex3d.lpVtbl.Release(img.d3d11Tex3d)
    if img.d3d11TexDs != nil:
      discard img.d3d11TexDs.lpVtbl.Release(img.d3d11TexDs)
    if img.d3d11TexMsaa != nil:
      discard img.d3d11TexMsaa.lpVtbl.Release(img.d3d11TexMsaa)
    if img.d3d11Srv != nil:
      discard img.d3d11Srv.lpVtbl.Release(img.d3d11Srv)
    if img.d3d11Smp != nil:
      discard img.d3d11Smp.lpVtbl.Release(img.d3d11Smp)

  proc zgDestroyContext(ctx: ZgContextP) =
    assert(ctx != nil)
    discard
    # empty

  proc zgDestroyShader(shd: ZgShaderP) =
    assert(shd != nil)
    if shd.d3d11Vs != nil:
      discard shd.d3d11Vs.lpVtbl.Release(shd.d3d11Vs)
    if shd.d3d11Fs != nil:
      discard shd.d3d11Fs.lpVtbl.Release(shd.d3d11Fs)
    if shd.d3d11VsBlob != nil:
      Z_FREE(shd.d3d11VsBlob)
    for stageIndex in 0 ..< ZG_NUM_SHADER_STAGES:
      let stage = shd.stage[stageIndex]
      for ubIndex in 0 ..< stage.numUniformBlocks:
        if stage.d3d11Cbs[ubIndex] != nil:
          discard stage.d3d11Cbs[ubIndex].lpVtbl.Release(stage.d3d11Cbs[ubIndex])
  
  proc zgDestroyPipeline(pip: ZgPipelineP) =
    assert(pip != nil)
    if pip.d3d11Il != nil:
      discard pip.d3d11Il.lpVtbl.Release(pip.d3d11Il)
    if pip.d3d11Rs != nil:
      discard pip.d3d11Rs.lpVtbl.Release(pip.d3d11Rs)
    if pip.d3d11Dss != nil:
      discard pip.d3d11Dss.lpVtbl.Release(pip.d3d11Dss)
    if pip.d3d11Bs != nil:
      discard pip.d3d11Bs.lpVtbl.Release(pip.d3d11Bs)
  
  proc zgDestroyPass(pass: ZgPassP) =
    assert(pass != nil)
    for i in 0 ..< ZG_MAX_COLOR_ATTACHMENTS:
      if pass.d3d11Rtvs[i] != nil:
        discard pass.d3d11Rtvs[i].lpVtbl.Release(pass.d3d11Rtvs[i])
    if pass.d3d11Dsv != nil:
      discard pass.d3d11Dsv.lpVtbl.Release(pass.d3d11Dsv)
  
  proc zgDiscardBackend() =
    assert(zg.d3d11.valid)
    zg.d3d11.valid = false

proc zgInitPool(pool: var ZgPool; num: int) =
  assert(num >= 1)
  # slot 0 is reserved for the 'invalid id', so bump the pool size by 1
  pool.size = num + 1
  pool.queueTop = 0
  # generation counters idexable by pool slot index, slot 0 is reserved
  pool.genCtrs.setLen(pool.size)
  zeroMem(addr pool.genCtrs[0], sizeof(uint32) * pool.size)
  # not a bug to only reserve 'num' here
  pool.freeQueue.setLen(num)
  # never allocate zero-th pool item since the invalid id is 0
  for i in countdown(pool.size - 1, 1):
    pool.freeQueue[pool.queueTop] = i
    inc(pool.queueTop)

proc zgSetupPools(p: var ZgPools; desc: ZgDesc) =
  # note: the pools here will have an additional item, since slot 0 is reserved
  assert((desc.bufferPoolSize > 0) and (desc.bufferPoolSize < ZG_MAX_POOL_SIZE))
  zgInitPool(p.bufferPool, desc.bufferPoolSize)
  p.buffers = newSeqWith(p.bufferPool.size, new ZgBufferP)
  
  assert((desc.imagePoolSize > 0) and (desc.imagePoolSize < ZG_MAX_POOL_SIZE))
  zgInitPool(p.imagePool, desc.imagePoolSize)
  p.images = newSeqWith(p.imagePool.size, new ZgImageP)

  assert((desc.shaderPoolSize > 0) and (desc.shaderPoolSize < ZG_MAX_POOL_SIZE))
  zgInitPool(p.shaderPool, desc.shaderPoolSize)
  p.shaders = newSeqWith(p.shaderPool.size, new ZgShaderP)

  assert((desc.pipelinePoolSize > 0) and (desc.pipelinePoolSize < ZG_MAX_POOL_SIZE))
  zgInitPool(p.pipelinePool, desc.pipelinePoolSize)
  p.pipelines = newSeqWith(p.pipelinePool.size, new ZgPipelineP)

  assert((desc.passPoolSize > 0) and (desc.passPoolSize < ZG_MAX_POOL_SIZE))
  zgInitPool(p.passPool, desc.passPoolSize)
  p.passes = newSeqWith(p.passPool.size, new ZgPassP)

  assert((desc.contextPoolSize > 0) and (desc.contextPoolSize < ZG_MAX_POOL_SIZE))
  zgInitPool(p.contextPool, desc.contextPoolSize)
  p.contexts = newSeqWith(p.contextPool.size, new ZgContextP)

proc zgPoolAllocIndex(pool: var ZgPool): int =
  if pool.queueTop > 0:
    dec(pool.queueTop)
    let slotIndex = pool.freeQueue[pool.queueTop]
    assert((slotIndex > 0) and (slotIndex < pool.size))
    result = slotIndex
  else:
    # pool exhausted
    result = ZG_INVALID_SLOT_INDEX

proc zgSlotAlloc(pool: var ZgPool; slot: var ZgSlot; slotIndex: int): uint32 =
  # FIXME: add handling for an overflowing generation counter
  # for now, just overflow (another option is to disabled the slot)
  assert((slotIndex > ZG_INVALID_SLOT_INDEX) and (slotIndex < pool.size))
  assert((slot.state == ZG_RESOURCESTATE_INITIAL) and (slot.id == ZG_INVALID_ID))
  inc(pool.genCtrs[slotIndex])
  let ctr = pool.genCtrs[slotIndex]
  slot.id = (ctr shl ZG_SLOT_SHIFT) or uint32(slotIndex and ZG_SLOT_MASK)
  slot.state = ZG_RESOURCESTATE_ALLOC
  result = slot.id

proc zgSlotIndex(id: uint32): int =
  result = int(id and ZG_SLOT_MASK)
  assert(ZG_INVALID_SLOT_INDEX != result)

proc zgContextAt(p: var ZgPools; contextId: uint32): ZgContextP =
  assert(ZG_INVALID_ID != contextId)
  let slotIndex = zgSlotIndex(contextId)
  assert((slotIndex > ZG_INVALID_SLOT_INDEX) and (slotIndex < p.contextPool.size))
  result = p.contexts[slotIndex]

proc zgSetupContext(): ZgContext =
  let slotIndex = zgPoolAllocIndex(zg.pools.contextPool)
  if ZG_INVALID_SLOT_INDEX != slotIndex:
    echo zg.pools.contextPool
    echo repr zg.pools.contexts
    result.id = zgSlotAlloc(zg.pools.contextPool, zg.pools.contexts[slotIndex].slot, slotIndex)
    var ctx = zgContextAt(zg.pools, result.id)
    ctx.slot.state = zgCreateContext(ctx)
    assert(ctx.slot.state == ZG_RESOURCESTATE_VALID)
    zgActivateContext(ctx)
  else:
    # pool is exhausted
    result.id = ZG_INVALID_ID
  zg.activeContext = result

proc zgSetup*(desc: var ZgDesc) =
  assert((desc.startCanary == 0) and (desc.endCanary == 0))
  zg.desc = desc

  # replace zero-init items with their default values
  zg.desc.bufferPoolSize = zgDef(zg.desc.bufferPoolSize, ZG_DEFAULT_BUFFER_POOL_SIZE)
  zg.desc.imagePoolSize = zgDef(zg.desc.imagePoolSize, ZG_DEFAULT_IMAGE_POOL_SIZE)
  zg.desc.shaderPoolSize = zgDef(zg.desc.shaderPoolSize, ZG_DEFAULT_SHADER_POOL_SIZE)
  zg.desc.pipelinePoolSize = zgDef(zg.desc.pipelinePoolSize, ZG_DEFAULT_PIPELINE_POOL_SIZE)
  zg.desc.passPoolSize = zgDef(zg.desc.passPoolSize, ZG_DEFAULT_PASS_POOL_SIZE)
  zg.desc.contextPoolSize = zgDef(zg.desc.contextPoolSize, ZG_DEFAULT_CONTEXT_POOL_SIZE)
  #TODO: Metal specific defaults

  zgSetupPools(zg.pools, zg.desc)
  zg.frameIndex = 1
  zgSetupBackend(zg.desc)
  discard zgSetupContext()
  zg.valid = true

proc zgResolveDefaultPassAction(`from`: ZgPassAction; to: var ZgPassAction) =
  to = `from`
  for i in 0 ..< ZG_MAX_COLOR_ATTACHMENTS:
    if to.colors[i].action == ZG_ACTION_DEFAULT:
      to.colors[i].action = ZG_ACTION_CLEAR
      to.colors[i].val[0] = ZG_DEFAULT_CLEAR_RED
      to.colors[i].val[1] = ZG_DEFAULT_CLEAR_GREEN
      to.colors[i].val[2] = ZG_DEFAULT_CLEAR_BLUE
      to.colors[i].val[3] = ZG_DEFAULT_CLEAR_ALPHA
  if to.depth.action == ZG_ACTION_DEFAULT:
    to.depth.action = ZG_ACTION_CLEAR
    to.depth.val = ZG_DEFAULT_CLEAR_DEPTH
  if to.stencil.action == ZG_ACTION_DEFAULT:
    to.stencil.action = ZG_ACTION_CLEAR
    to.stencil.val = ZG_DEFAULT_CLEAR_STENCIL
  
proc zgLookupContext(p: var ZgPools, ctxId: uint32): ZgContextP =
  if ZG_INVALID_ID != ctxId:
    result = zgContextAt(p, ctxId)
    if result.slot.id == ctxId:
      return result

proc zgDestroyAllResources(p: ZgPools, ctxId: uint32) =
  #[ this is a bit dumb since it loops over all pool slots to
     find the occupied slots. it is only executed at shutdown
     NOTE: ONLY EXECUTE AT SHUTDOWN
      ...because the free queues will not be reset and the
      resource slots will not be cleared!
  ]#
  for i in 1 ..< p.bufferPool.size:
    if p.buffers[i].slot.ctxId == ctxId:
      let state = p.buffers[i].slot.state
      if (state == ZG_RESOURCESTATE_VALID) or (state == ZG_RESOURCESTATE_FAILED):
        zgDestroyBuffer(p.buffers[i])
  for i in 1 ..< p.imagePool.size:
    if p.images[i].slot.ctxId == ctxId:
      let state = p.images[i].slot.state
      if (state == ZG_RESOURCESTATE_VALID) or (state == ZG_RESOURCESTATE_FAILED):
        zgDestroyImage(p.images[i])
  for i in 1 ..< p.shaderPool.size:
    if p.shaders[i].slot.ctxId == ctxId:
      let state = p.shaders[i].slot.state
      if (state == ZG_RESOURCESTATE_VALID) or (state == ZG_RESOURCESTATE_FAILED):
        zgDestroyShader(p.shaders[i])
  for i in 1 ..< p.pipelinePool.size:
    if p.pipelines[i].slot.ctxId == ctxId:
      let state = p.pipelines[i].slot.state
      if (state == ZG_RESOURCESTATE_VALID) or (state == ZG_RESOURCESTATE_FAILED):
        zgDestroyPipeline(p.pipelines[i])
  for i in 1 ..< p.passPool.size:
    if p.passes[i].slot.ctxId == ctxId:
      let state = p.passes[i].slot.state
      if (state == ZG_RESOURCESTATE_VALID) or (state == ZG_RESOURCESTATE_FAILED):
        zgDestroyPass(p.passes[i])

proc zgBeginDefaultPass*(passAction: ZgPassAction; width, height: int32) =
  assert((passAction.startCanary == 0) and (passAction.endCanary == 0))
  var pa: ZgPassAction
  zgResolveDefaultPassAction(passAction, pa)
  zg.curPass.id = ZG_INVALID_ID
  zg.passValid = true
  zgBeginPass(none(ZgPassP), pa, width, height)

proc zgEndPass*() =
  if not zg.passValid:
    return
  zgEndPassP()
  zg.curPass.id = ZG_INVALID_ID
  zg.curPipeline.id = ZG_INVALID_ID
  zg.passValid = false

proc zgCommit*() =
  assert(not zg.d3d11.inPass)

proc zgDiscardPool(pool: var ZgPool) =
  pool.freeQueue.setLen(0)
  pool.genCtrs.setLen(0)
  pool.size = 0
  pool.queueTop = 0

proc zgDiscardPools(p: var ZgPools) =
  p.contexts.setLen(0)
  p.passes.setLen(0)
  p.pipelines.setLen(0)
  p.shaders.setLen(0)
  p.images.setLen(0)
  p.buffers.setLen(0)
  zgDiscardPool(p.contextPool)

proc zgShutdown*() =
  # can only delete resources for the currently set context here
  # if multiple contexts are used, the app code must take care of
  # properly releasing them (since only the app code can switch
  # between 3D-API contexts)
  if zg.activeContext.id != ZG_INVALID_ID:
    var ctx = zgLookupContext(zg.pools, zg.activeContext.id)
    if ctx != nil:
      zgDestroyAllResources(zg.pools, zg.activeContext.id)
      zgDestroyContext(ctx)
  zgDiscardBackend()
  zgDiscardPools(zg.pools)