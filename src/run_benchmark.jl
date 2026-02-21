using ArgParse
using Lux
using Flux # maybe use 
using Posits
using Bfloat16
using Takums
# using Microfloat # look this one up, I forget
using DataFrames
using CSV
using Plots

'''
  Command-line argument parser (read arguments)

  Example: 
  > julia run_benchmark.jl --arithmetic=fp16,bfloat16,posit16 --model=resnet18 --dataset=cifar10
'''
function parse_args()
    s = ArgParseSettings()
    @add_arg_table s begin
        "--arithmetic"
        help = "Comma-separated list of arithmetic types (fp16, bfloat16, posit16, fp8, posit8)"
        default = "fp16"
        
        "--model"
        help = "Model architecture (e.g., resnet18, mlp)"
        default = "mlp"
        
        "--dataset"
        help = "Dataset to train on (e.g., cifar10, mnist)"
        default = "mnist"
        
        "--epochs"
        help = "Number of epochs"
        default = 10
        
        "--batch-size"
        help = "Batch size"
        default = 64
    end
    return parse_args(s)
end

'''
  Training function 
'''
function benchmark_model(arith::String, model::String, dataset::String; epochs::Int=10, batch_size::Int=64)
    println("Running benchmark with:")
    println("Arithmetic: $arith")
    println("Model: $model")
    println("Dataset: $dataset")
    println("Epochs: $epochs, Batch size: $batch_size")
    
    # TODO: Load dataset
    # TODO: Initialize model using Lux / Flux
    # TODO: Convert model & data to selected arithmetic type
    # TODO: Train model and collect metrics
    
    # Example placeholder results
    results = DataFrame(Arithmetic=arith, Model=model, Dataset=dataset,
                        Epochs=epochs, Accuracy=rand(), Loss=rand())
    
    # Save results
    CSV.write("results_$arith.csv", results)
    println("Results saved to results_$arith.csv")
end

'''
  main function 
'''
function main()
    args = parse_args()
    
    arith_list = split(args["arithmetic"], ",")
    for arith in arith_list
        benchmark_model(arith, args["model"], args["dataset"];
                        epochs=args["epochs"], batch_size=args["batch_size"])
    end
end


# --------------------------------
# Run when calling run_benchmarks
# --------------------------------
main()
