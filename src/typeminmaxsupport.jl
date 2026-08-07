using UniversalNumbers

import Base: Base.typemin, Base.typemax

# 8 bit min patterns
Base.typemin(::Type{Posit{8, 0, UInt8}}) = reinterpret(Posit{8, 0, UInt8}, 0x81)
Base.typemin(::Type{Posit{8, 1, UInt8}}) = reinterpret(Posit{8, 1, UInt8}, 0x81)
Base.typemin(::Type{Posit{8, 2, UInt8}}) = reinterpret(Posit{8, 2, UInt8}, 0x81)
Base.typemin(::Type{CFloat{8, 2, UInt8}}) = reinterpret(CFloat{8, 2, UInt8}, 0xdf)
Base.typemin(::Type{E3M4{UInt8}}) = reinterpret(E3M4{UInt8}, 0xef)
Base.typemin(::Type{E4M3{UInt8}}) = reinterpret(E4M3{UInt8}, 0xf7)
Base.typemin(::Type{E5M2{UInt8}}) = reinterpret(E5M2{UInt8}, 0xfb)
Base.typemin(::Type{Takum{8, UInt8}}) = reinterpret(Takum{8, UInt8}, 0x81)
Base.typemin(::Type{Fixed{8, 4, UInt8}}) = reinterpret(Fixed{8, 4, UInt8}, 0x80)

# 16 bit min patterns
Base.typemin(::Type{Posit{12, 1, UInt16}}) = reinterpret(Posit{12, 1, UInt16}, 0x0801)
Base.typemin(::Type{Posit{16, 1, UInt16}}) = reinterpret(Posit{16, 1, UInt16}, 0x8001)
Base.typemin(::Type{Posit{16, 2, UInt16}}) = reinterpret(Posit{16, 2, UInt16}, 0x8001)
Base.typemin(::Type{LNS{16, 5, UInt16}}) = reinterpret(LNS{16, 5, UInt16}, 0xbfff)
Base.typemin(::Type{Takum{16, UInt16}}) = reinterpret(Takum{16, UInt16}, 0x8001)
Base.typemin(::Type{Fixed{16, 8, UInt16}}) = reinterpret(Fixed{16, 8, UInt16}, 0x4000)
Base.typemin(::Type{BF16}) = reinterpret(BF16, 0xff80)

# 32 bit min patterns
Base.typemin(::Type{Posit{19, 2, UInt32}}) = reinterpret(Posit{19, 2, UInt32}, 0x00040001)
Base.typemin(::Type{Posit{19, 3, UInt32}}) = reinterpret(Posit{19, 3, UInt32}, 0x00040001)
Base.typemin(::Type{Posit{32, 2, UInt32}}) = reinterpret(Posit{32, 2, UInt32}, 0x80000001)
Base.typemin(::Type{CFloat{24, 5, UInt32}}) = reinterpret(CFloat{24, 5, UInt32}, 0x00fbffff)
# Base.typemin(::Type{LNS{32, 16, UInt32}}) = ? Failed to identify min value here
Base.typemin(::Type{Takum{32, UInt32}}) = reinterpret(Takum{32, UInt32}, 0x80000001)
Base.typemin(::Type{Fixed{32, 16, UInt32}}) = reinterpret(Fixed{32, 16, UInt32}, 0x80000000)
Base.typemin(::Type{HFloat{6, 7, UInt32}}) = reinterpret(HFloat{6, 7, UInt32}, 0xc7100000)
# Base.typemin(::Type{DFloat{7, 6, UInt32}}) = ? Failed to identify min value here

# 64 bit min patterns
Base.typemin(::Type{Posit{64, 2, UInt64}}) = reinterpret(Posit{64, 2, UInt64}, 0x8000000000000001)
Base.typemin(::Type{Posit{64, 3, UInt64}}) = reinterpret(Posit{64, 3, UInt64}, 0x8000000000000001)
Base.typemin(::Type{Takum{64, UInt64}}) = reinterpret(Takum{64, UInt64}, 0x8000000000000001)
Base.typemin(::Type{HFloat{14, 7, UInt64}}) = reinterpret(HFloat{14, 7, UInt64}, 0xffffffffffffffff)

# Max patterns
Base.typemax(::Type{Posit{8, 0, UInt8}}) = reinterpret(Posit{8, 0, UInt8}, 0x7f)
Base.typemax(::Type{Posit{8, 1, UInt8}}) = reinterpret(Posit{8, 1, UInt8}, 0x7f)
Base.typemax(::Type{Posit{8, 2, UInt8}}) = reinterpret(Posit{8, 2, UInt8}, 0x7f)
Base.typemax(::Type{CFloat{8, 2, UInt8}}) = reinterpret(CFloat{8, 2, UInt8}, 0x5f)
Base.typemax(::Type{E3M4{UInt8}}) = reinterpret(E3M4{UInt8}, 0x6f)
Base.typemax(::Type{E4M3{UInt8}}) = reinterpret(E4M3{UInt8}, 0x77)
Base.typemax(::Type{E5M2{UInt8}}) = reinterpret(E5M2{UInt8}, 0x7b)
Base.typemax(::Type{Takum{8, UInt8}}) = reinterpret(Takum{8, UInt8}, 0x7f)
Base.typemax(::Type{Fixed{8, 4, UInt8}}) = reinterpret(Fixed{8, 4, UInt8}, 0x7f)
Base.typemax(::Type{Posit{12, 1, UInt16}}) = reinterpret(Posit{12, 1, UInt16}, 0x07ff)
Base.typemax(::Type{Posit{16, 1, UInt16}}) = reinterpret(Posit{16, 1, UInt16}, 0x7fff)
Base.typemax(::Type{Posit{16, 2, UInt16}}) = reinterpret(Posit{16, 2, UInt16}, 0x7fff)
Base.typemax(::Type{LNS{16, 5, UInt16}}) = reinterpret(LNS{16, 5, UInt16}, 0x3fff)
Base.typemax(::Type{Takum{16, UInt16}}) = reinterpret(Takum{16, UInt16}, 0x7fff)
Base.typemax(::Type{Fixed{16, 8, UInt16}}) = reinterpret(Fixed{16, 8, UInt16}, 0x7fff)
Base.typemax(::Type{BF16}) = reinterpret(BF16, 0x7f7f)
Base.typemax(::Type{Posit{19, 2, UInt32}}) = reinterpret(Posit{19, 2, UInt32}, 0x0003ffff)
Base.typemax(::Type{Posit{19, 3, UInt32}}) = reinterpret(Posit{19, 3, UInt32}, 0x0003ffff)
Base.typemax(::Type{Posit{32, 2, UInt32}}) = reinterpret(Posit{32, 2, UInt32}, 0x7fffffff)
Base.typemax(::Type{CFloat{24, 5, UInt32}}) = reinterpret(CFloat{24, 5, UInt32}, 0x007bffff)
Base.typemax(::Type{LNS{32, 16, UInt32}}) = reinterpret(LNS{32, 16, UInt32}, 0x3fffffff)
Base.typemax(::Type{Takum{32, UInt32}}) = reinterpret(Takum{32, UInt32}, 0x7fffffff)
Base.typemax(::Type{Fixed{32, 16, UInt32}}) = reinterpret(Fixed{32, 16, UInt32}, 0x7fffffff)
Base.typemax(::Type{HFloat{6, 7, UInt32}}) = reinterpret(HFloat{6, 7, UInt32}, 0x7fffffff)
Base.typemax(::Type{DFloat{7, 6, UInt32}}) = reinterpret(DFloat{7, 6, UInt32}, 0x77ff423f)
Base.typemax(::Type{Posit{64, 2, UInt64}}) = reinterpret(Posit{64, 2, UInt64}, 0x7fffffffffffffff)
Base.typemax(::Type{Posit{64, 3, UInt64}}) = reinterpret(Posit{64, 3, UInt64}, 0x7fffffffffffffff)
Base.typemax(::Type{Takum{64, UInt64}}) = reinterpret(Takum{64, UInt64}, 0x7fffffffffffffff)
Base.typemax(::Type{HFloat{14, 7, UInt64}}) = reinterpret(HFloat{14, 7, UInt64}, 0x7fffffffffffffff)
Base.typemax(::Type{DFloat{16, 8, UInt64}}) = reinterpret(DFloat{16, 8, UInt64}, 0x77ff8d7ea4c67fff)
Base.typemax(::Type{DD}) = reinterpret(DD, 0x7c9fffffffffffff7fefffffffffffff)