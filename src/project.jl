using DataFrames, DataFramesMeta, CSV
using FASTX
using Distributions, Turing, FillArrays

using Plots, StatsPlots, Measures

include("datasets.jl")

using ProgressMeter, Optim, Suppressor

function getprojectdir()
    d = pwd()
    if basename(d) == "notebooks"
        return dirname(d)
    else
        return d
    end
end


function showwl(rows=200, cols=10000)
    function showwl(table)
        if !haskey(ENV, "DATAFRAMES_COLUMNS")
            ENV["DATAFRAMES_COLUMNS"] = "100"
        end
        if !haskey(ENV, "DATAFRAMES_ROWS")
            ENV["DATAFRAMES_ROWS"] = "25"
        end
        c = ENV["DATAFRAMES_COLUMNS"]
        r = ENV["DATAFRAMES_ROWS"]
        ENV["DATAFRAMES_COLUMNS"] = string(cols)
        ENV["DATAFRAMES_ROWS"] = string(rows)
        # display(table[1:min(rows, size(table, 1)), :])
        display(table)
        ENV["DATAFRAMES_COLUMNS"] = c;
        ENV["DATAFRAMES_ROWS"] = r;
        nothing;
    end
    
end