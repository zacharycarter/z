const 
  ZG_STRING_SIZE = 16
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
    
    