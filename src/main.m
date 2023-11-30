function main = main()

%process behaviour data
fprintf("Processing behaviour data...");
T = load("./data/raw/quaddata_bdata_big.mat");
bdata_out_dir = "./data/processed/behaviour";
preprocess_data(T.bdata_big, "behaviour", bdata_out_dir)
fprintf("...done");

%process neural data
fprintf("Processing neural data...");
T = load('data/raw/quaddata_sdata_big.mat');
ndata_out_dir = "./data/processed/neural";
preprocess_data(T.sdata_big, "neural", ndata_out_dir)
fprintf("...done");

end