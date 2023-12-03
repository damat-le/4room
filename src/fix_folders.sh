
# parse input arg
in_dir=$1

# remove backslash at end of in_dir if present
if [[ "${in_dir}" == */ ]]; then
    in_dir="${in_dir::-1}"
fi

# move to in_dir
cd "${in_dir}"

# list of rat names
rat_names=("r35" "r37" "r38" "r39" "r44")


# create new folder structure: rat->session->neural/behaviour
new_datadir_name="newstruct_processed"

for rat_name in "${rat_names[@]}"
do
    # loop over subfolder names (session names)
    for session_dir in behaviour/"$rat_name"/*
    do
        # get only the session name
        session_name=$(basename $session_dir)
        # echo $session_name

        mkdir -p ../$new_datadir_name/$rat_name/$session_name/neural/
        mkdir -p ../$new_datadir_name/$rat_name/$session_name/behaviour/
    done
done


cd ../

# copy files to new folder structure
for rat_name in "${rat_names[@]}"
do
    # loop over subfolder names (session names)
    for session_dir in $new_datadir_name/$rat_name/*
    do
        session_name=$(basename $session_dir)
        echo "Copying $rat_name/$session_name"

        cp -r processed/behaviour/$rat_name/$session_name/* $new_datadir_name/$rat_name/$session_name/behaviour/
        cp -r processed/neural/$rat_name/$session_name/* $new_datadir_name/$rat_name/$session_name/neural/
    done
done
