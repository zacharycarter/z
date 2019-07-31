const 
  ZG_STRING_SIZE = 16
  ZG_DEFAULT_BUFFER_POOL_SIZE = 128
  ZG_DEFAULT_IMAGE_POOL_SIZE = 128
  ZG_DEFAULT_SHADER_POOL_SIZE = 32
  ZG_DEFAULT_PIPELINE_POOL_SIZE = 64
  ZG_DEFAULT_PASS_POOL_SIZE = 16
  ZG_DEFAULT_CONTEXT_POOL_SIZE = 16
  ZG_INVALID_ID = 0
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

template zgDef(val, def: untyped): untyped =
  (if ((val) == 0): (def) else: (val))

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

  ZgAction {.size: sizeof(uint32).} = enum
    ZG_ACTION_DEFAULT
    ZG_ACTION_CLEAR
    ZG_ACTION_LOAD
    ZG_ACTION_DONTCARE
    ZG_ACTION_COUNT
    ZG_ACTION_FORCE_U32 = 0x7FFFFFFF

  ZgColorAttachmentAction = object
    action: ZgAction
    val: array[4, float32]
  
  ZgDepthAttachmentAction = object
    action: ZgAction
    val: float
  
  ZgStencilAttachmentAction = object
    action: ZgAction
    val: uint8
  
  ZgPassAction* = object
    startCanary: uint32
    colors: array[ZG_MAX_COLOR_ATTACHMENTS, ZgColorAttachmentAction]
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
    ZgBufferP = object
      slot: ZgSlot
      size: int
      appendPos: int
      appendOverflow: bool
      kind: ZgBufferKind
      usage: ZgUsage
      updateFrameIndex: uint32
      appendFrameIndex: uint32
      d3d11Buf: ptr ID3D11Buffer
    
    ZgImageP = object
      slot: ZgSlot
      kind: ZgImageKind
      renderTarget: bool
      width: int
      height: int
      depth: int
      numMipMaps: int
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
    
    ZgShaderP = object
      slot: ZgSlot
      attrs: array[ZG_MAX_VERTEX_ATTRIBUTES, ZgShaderAttr]
      stage: array[ZG_NUM_SHADER_STAGES, ZgShaderStage]
      d3d11Vs: ptr ID3D11VertexShader
      d3d11Fs: ptr ID3D11PixelShader
      d3d11VsBlob: pointer
      d3d11VsBlobLength: int
    
    ZgPipelineP = object
      slot: ZgSlot
      shader: ptr ZgShaderP
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
      image: ptr ZgImageP
      imageId: ZgImage
      mipLevel: int
      slice: int
    
    ZgPassP = object
      slot: ZgSlot
      numColorAtts: int
      colorAtts: array[ZG_MAX_COLOR_ATTACHMENTS, ZgAttachment]
      dsAtt: ZgAttachment
      d3d11Rtvs: array[ZG_MAX_COLOR_ATTACHMENTS, ptr ID3D11RenderTargetView]
      d3d11Dsv: ptr ID3D11DepthStencilView
    
    ZgContextP = object
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
      curPass: ptr ZgPassP
      curPassId: ZgPass
      curPipeline: ptr ZgPipelineP
      curPipelineId: ZgPipeline
      crRtvs: array[ZG_MAX_COLOR_ATTACHMENTS, ptr ID3D11RenderTargetView]
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
      subResData: array[ZG_MAX_MIPMAPS * ZG_MAX_TEXTUREARRAY_LAYERS, D3D11_SUBRESOURCE_DATA]

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

proc zgSetupPools(p: var ZgPools, desc: ZgDesc) =
  discard

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