# Script to sample the bounds file -

# Script to max product -
include("DataFile.jl")
include("Solve.jl")
include("Types.jl")

# Load the data file with the default bounds -
data_dictionary = DataFile(0,0,0);

# Set the max -
data_dictionary["MIN_FLAG"] = false;

# Get the flux model dictionary -
flux_model_dictionary = data_dictionary["FLUX_MODEL_DICTIONARY"]
flux_model_dictionary["PROTEIN_export"].flux_obj_coeff = 1.0;

# Reactions that we block ...
blocked_reaction_set = Set{AbstractString}()
push!(blocked_reaction_set,"R_PTS")
push!(blocked_reaction_set,"R_nuo")
push!(blocked_reaction_set,"R_ndh1")
push!(blocked_reaction_set,"R_ndh2")
push!(blocked_reaction_set,"M_lac_D_c_exchange_reverse")
push!(blocked_reaction_set,"M_etoh_c_exchange_reverse")
push!(blocked_reaction_set,"M_akg_c_exchange_reverse")
push!(blocked_reaction_set,"M_fum_c_exchange_reverse")
push!(blocked_reaction_set,"M_mal_L_c_exchange_reverse")
push!(blocked_reaction_set,"M_pyr_c_exchange_reverse")
push!(blocked_reaction_set,"M_ac_c_exchange_reverse")
push!(blocked_reaction_set,"M_succ_D_c_exchange_reverse")
data_dictionary["blocked_reaction_set"] = blocked_reaction_set


# set the bound -
# data_dictionary["M_o2_c_exchange_reverse"] = 100

# Set the plasmid concentration -
#gene_copy_number = (10e-6/1e9)*(6.02e23)*10.0;
#data_dictionary["deGFP_gene_copies"] = gene_copy_number;

# Load the bounds data -
bounds_array = readdlm("../sensitivity/Samples.txt")
(nr,nc) = size(bounds_array)

# Setup performance array -
performance_array = zeros(nr)

# Setup bounds dictionary -
bounds_dictionary = Dict()

# Ok, we need to enumerate through this list, and calculate the performance of the model for each value -
for index in collect(1:nr)

  # Set the bounds array -
  # The first 20 cols are AAs
  bounds_dictionary["M_ala_L_c_exchange_reverse"] = bounds_array[index,1]
  bounds_dictionary["M_arg_L_c_exchange_reverse"] = bounds_array[index,2]
  bounds_dictionary["M_asn_L_c_exchange_reverse"] = bounds_array[index,3]
  bounds_dictionary["M_asp_L_c_exchange_reverse"] = bounds_array[index,4]
  bounds_dictionary["M_cys_L_c_exchange_reverse"] = bounds_array[index,5]
  bounds_dictionary["M_glu_L_c_exchange_reverse"] = bounds_array[index,6]
  bounds_dictionary["M_gln_L_c_exchange_reverse"] = bounds_array[index,7]
  bounds_dictionary["M_gly_L_c_exchange_reverse"] = bounds_array[index,8]
  bounds_dictionary["M_ile_L_c_exchange_reverse"] = bounds_array[index,9]
  bounds_dictionary["M_leu_L_c_exchange_reverse"] = bounds_array[index,10]
  bounds_dictionary["M_his_L_c_exchange_reverse"] = bounds_array[index,11]
  bounds_dictionary["M_lys_L_c_exchange_reverse"] = bounds_array[index,12]
  bounds_dictionary["M_met_L_c_exchange_reverse"] = bounds_array[index,13]
  bounds_dictionary["M_phe_L_c_exchange_reverse"] = bounds_array[index,14]
  bounds_dictionary["M_pro_L_c_exchange_reverse"] = bounds_array[index,15]
  bounds_dictionary["M_ser_L_c_exchange_reverse"] = bounds_array[index,16]
  bounds_dictionary["M_thr_L_c_exchange_reverse"] = bounds_array[index,17]
  bounds_dictionary["M_trp_L_c_exchange_reverse"] = bounds_array[index,18]
  bounds_dictionary["M_tyr_L_c_exchange_reverse"] = bounds_array[index,19]
  bounds_dictionary["M_val_L_c_exchange_reverse"] = bounds_array[index,20]

  # The next few cols are other reequired resources -
  bounds_dictionary["M_glc_D_c_exchange_reverse"] = bounds_array[index,21]
  bounds_dictionary["M_o2_c_exchange_reverse"] = bounds_array[index,22]
  bounds_dictionary["translation_initiation"] = bounds_array[index,23]
  bounds_dictionary["transcriptional_initiation"] = bounds_array[index,24]

  # Load the sample bounds dictionary into the data dictionary -
  data_dictionary["sample_bounds_dictionary"] = bounds_dictionary;

  # Run the simulation -
  (OV,FA,DA,UA,EF) = Solve(data_dictionary);

  # calculate the protein concentration -
  # deGFP_concentration = (1e3)*OV*production_time;

  # capture -
  performance_array[index] = (1e3)*OV
  @show index
end

# Write the concentration file -
writedlm("../sensitivity/performance.txt.500",performance_array)
