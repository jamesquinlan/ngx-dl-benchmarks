using ArgParse
using Lux
using UniversalNumbers   # Posit{N,ES}, Takum{N}, BF16 all live here
using DataFrames
using CSV
using Plots
# using Microfloat # look this one up, I forgot

#=
  Command-line argument parser (read arguments)

  Example:
  > julia run_benchmark.jl --arithmetic=fp16,bf16,posit16 --model=resnet18 --dataset=cifar10
=#
function parse_cmdline_args()
    s = ArgParseSettings()
    @add_arg_table s begin
        "--arithmetic"
        default = "fp16" # Comma-separated list of arithmetic types (fp16, bf16, posit16, posit8, takum16, ...)

        "--model"
        default = "mlp" # Model architecture (e.g., resnet18, mlp)

        "--dataset"
        default = "mnist" # Dataset to train on (e.g., cifar10, mnist)

        "--epochs"
        help = "Number of epochs"
        arg_type = Int
        default = 10

        "--batch-size"
        help = "Batch size"
        arg_type = Int
        default = 64
    end
    return parse_args(s)
end

# Map CLI arithmetic labels to the actual Julia numeric types
const ARITH_TYPES = Dict(
    "fp16"     => Float16,
    "fp32"     => Float32,
    "bf16"     => BF16,
    "posit8"   => Posit{8,0},
    "posit16"  => Posit{16,1},
    "posit32"  => Posit{32,2},
    "takum16"  => Takum{16},
    "takum32"  => Takum{32},
)

#=
  Training function
=#
function benchmark_model(arith_label::String, model::String, dataset::String;
                          epochs::Int=10, batch_size::Int=64)
    T = get(ARITH_TYPES, arith_label) do
        error("Unknown arithmetic type: $arith_label. Valid options: $(join(keys(ARITH_TYPES), ", "))")
    end

    println("Running benchmark with:")
    println("Arithmetic: $arith_label -> $T")
    println("Model: $model")
    println("Dataset: $dataset")
    println("Epochs: $epochs, Batch size: $batch_size")

    # TODO: Load dataset
    # TODO: Initialize model using Lux
    # TODO: Convert model & data to T
    # TODO: Train model and collect metrics

    results = DataFrame(Arithmetic=arith_label, Model=model, Dataset=dataset,
                        Epochs=epochs, Accuracy=rand(), Loss=rand())

    CSV.write("results_$arith_label.csv", results)
    println("Results saved to results_$arith_label.csv")
end

function main()
    args = parse_cmdline_args()

    arith_list = split(args["arithmetic"], ",")
    for arith in arith_list
        benchmark_model(String(arith), args["model"], args["dataset"];
                        epochs=args["epochs"], batch_size=args["batch-size"])
    end
end

main()
