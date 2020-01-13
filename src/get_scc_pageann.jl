using Mimi
using CSV
using DataFrames

# get main_model file
include("main_model_annual.jl")
include("mcs_annual.jl")
include("compute_scc_annual.jl")

function set_globalbools()
    global use_variability = false

    # set random seed to have similar variability development in the base and the marginal model.
    # set variability seed.
    if use_variability
        global varseed = rand(1:1000000000000)
    end

    global use_linear = false
    global use_logburke = false
    global use_logpopulation = false
    global use_logwherepossible = true
end

# set global values for technical configuration options
set_globalbools()

for scenario in ["1.5 degC Target", "RCP2.6 & SSP1", "RCP4.5 & SSP2", "RCP8.5 & SSP5"]
    model = "PAGE-ANN"
    # define model, default settings: getpage(NDCs scenario, permafrost, no sea-ice, no page09damages)
    m = getpage(scenario, true, true)
    # run model
    run(m)

    # get the social cost of carbon for the Monte Carlo simulations, for selected quantiles.
    samplesize = 50000
    sccs = compute_scc_mcs(m, samplesize, year=2020)
    # store results in DataFrame
    df = DataFrame(Any[fill(model, samplesize), fill(scenario, samplesize), sccs], [:ModelName, :ScenarioName, :SCC])
    # write out to csv
    DIR = joinpath(@__DIR__, "..", "output")
    CSV.write(joinpath(DIR, string(model, "_", scenario, "_", "scc.csv")), df)
end
