using Random, Optimisers
import NNlib

# Fixes for Posits and Takums to prevent softmax failure
NNlib.fast_maximum(x::AbstractArray{T}; dims) where {T<:Posit} = @fastmath reduce(max, x; dims, init = -floatmax(T))
NNlib.fast_maximum(x::AbstractArray{T}; dims) where {T<:Takum} = @fastmath reduce(max, x; dims, init = -floatmax(T))
# These were for Posits.jl and Takums.jl (now replaced with UniversalNumbers)
#NNlib.fast_maximum(x::AbstractArray{T}; dims) where {T<:AnyPosit} = @fastmath reduce(max, x; dims, init = -floatmax(T))
#NNlib.fast_maximum(x::AbstractArray{T}; dims) where {T<:AnyTakum} = @fastmath reduce(max, x; dims, init = -floatmax(T))

"""
    data_subset(dataset, fraction; rng = Xoshiro(0), subfield = :none)

Reads a dataset from MLDatasets.jl, then produces a random subset of that data matching the per-class proportions.
Data is not shuffled by this function, and must be shuffled with the training dataloader.
Partially produced by Claude.

# Parameters
- 'dataset': the dataset, as loaded from MLDatasets (e.g. CIFAR10(split = :train)).
- 'fraction': the ratio of entries per class to keep.
- 'rng': A random-number generator to be fed in if you want a different subset each epoch.
- 'subfield': Used to delve a specific subsection of the targets, if one is present (e.g. CIFAR100 has :coarse vs :fine).
"""
function data_subset(dataset, fraction::Real; rng::AbstractRNG = Xoshiro(0), subfield::Symbol = :none)
    y = dataset.targets
    if !(subfield == :none)
        y = getproperty(y, subfield)
    end
    keep = Int[]
    for c in unique(y)
        idx = findall(==(c), y)
        n = round(Int, length(idx) * fraction)
        shuffled = idx[randperm(rng, length(idx))]
        append!(keep, shuffled[1:n])
    end
    return dataset[keep]
end

"""
    YunAdam(η = 0.001, β = (0.9, 0.999), ϵ = 1e-8)
    YunAdam(; [eta, beta, epsilon])

Created using the Adam implementation in Optimisers.jl.  
Modified to match the method in the paper: https://arxiv.org/pdf/2307.16189  
"Stabilizing Backpropagation in 16-bit Neural Training with Modified Adam Optimizer"  
Rather than an added epsilon term, the epsilon here caps the minimum value directly.
Note that in practice, the actual epsilon is sqrt(epsilon), not epsilon.
Further modified with anti-rounding safeguards.
Likely has room for optimization.

# Parameters
- Learning rate (`η == eta`): Amount by which gradients are discounted before updating
                       the weights.
- Decay of momentums (`β::Tuple == beta`): Exponential decay for the first (β1) and the
                                   second (β2) momentum estimate.
- Machine epsilon (`ϵ == epsilon`): Constant to prevent division by zero
                         (tune for testing)
"""
Optimisers.@def struct YunAdam <: Optimisers.AbstractRule
  eta = 0.001
  beta = (0.9, 0.999)
  epsilon = 1e-8
end



Optimisers.init(o::YunAdam, x::AbstractArray{T}) where T = (zero(x), zero(x), beta_clamp(o, T))

function beta_clamp(o::YunAdam, T::Type)
    return (
        T.(o.beta[1]) == one(T) ? prevfloat(prevfloat(one(T))) : T.(o.beta[1]),
        T.(o.beta[2]) == one(T) ? prevfloat(one(T)) : T.(o.beta[2])
    )
end

function Optimisers.apply!(o::YunAdam, state, x::AbstractArray{T}, dx) where T
  η, β, ϵ = T.(o.eta) == zero(T) ? floatmin(T) : T.(o.eta),
            beta_clamp(o, T),
            T.(o.epsilon) == zero(T) ? floatmin(T) : T.(o.epsilon)
  mt, vt, βt = state

  Optimisers.@.. mt = β[1] * mt + (1 - β[1]) * dx
  Optimisers.@.. vt = β[2] * vt + (1 - β[2]) * abs2(dx)
  dx′ = Optimisers.@lazy mt / (1 - βt[1]) / (sqrt(max(vt / (1 - βt[2]), ϵ))) * η

  return (mt, vt, βt .* β), dx′
end



# Used to ensure no NaN/NaRs pop up
finite_test(x::AbstractFloat) = isfinite(x)
finite_test(x::AbstractArray{<:AbstractFloat}) = all(isfinite, x)
finite_test(x::Union{Tuple, NamedTuple, AbstractArray}) = all(finite_test, x)
finite_test(::Any) = true

# Used to ensure the model hasn't type promoted
type_test(x::AbstractFloat, T) = typeof(x) === T
type_test(x::AbstractArray{<:AbstractFloat}, T) = eltype(x) === T
type_test(x::Union{Tuple, NamedTuple, AbstractArray}, T) = all(y -> type_test(y, T), x)
type_test(::Any, T) = true