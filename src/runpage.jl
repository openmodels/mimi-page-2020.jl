#########################
# options to choose from:
###
# - "PAGE-ICE"
# - "PAGE-ICE with Growth Effects"
#########################
function Input(texttodisplay)
    # function that allows for user input in the CLI
    println(texttodisplay)
    readline()
end

function runpage()
    options = "
    Choose model version to run:
    - 1 PAGE-ICE (10 timestep)
    - 2 PAGE-ICE with Growth Effects (10 timestep)
    - 3 PAGE-ICE (annual)
    - 4 PAGE-ICE with Interannual Temperature Variability (annual)

    Input number:
    "

    version = Input(options)


    if isequal(version, "1") || isequal(version, "PAGE-ICE (10 timestep)")
        include("runmodel.jl")
    elseif isequal(version, "2") || isequal(version, "PAGE-ICE with Growth Effects (10 timestep)")
        include("runmodel_growth.jl")
    elseif isequal(version, "3") || isequal(version, "PAGE-ICE (annual)")
        include("runmodel_annual.jl")
    elseif isequal(version, "4") || isequal(version, "PAGE-ICE with Interannual Temperature Variability (annual)")
        include("runmodel_variability")
    # elseif isequal(version, "5") || isequal(version, "PAGE-ICE with Interannual Temperature Variability with Autoregression (annual)")
    #     include("runmodel_ARvariability")
    else
        println("WARNING: No valid model input provided. Please provide a valid model choice")
        runpage()
    end
end

runpage()