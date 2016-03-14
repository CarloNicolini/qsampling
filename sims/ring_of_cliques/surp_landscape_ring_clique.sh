#!/bin/sh

usage()
{
	echo "Usage: surp_landscape_ring_clique.sh n k path"
	echo "\t n is the number of nodes in every clique"
	echo "\t k is the number of connected cliques"
	echo "\t trials number of partitions to run"
	echo "\t path is the path of the output clique file, sample partitions and final file to analyze with Matlab to create an embedding"
	exit
}


if [ "$#" -ne 4 ]
	then
	usage
	exit;
fi

export n=${1}
export k=${2}
export trials=${3}
export datapath=`echo ${4}/RC_n${n}_k${k}_trials${trials}`
echo "[INFO] Generating Surprise landscape file for ring of cliques n=$n k=$k trials=$trials datapath=$datapath"
# Create the Matlab program to generate Surprise landscape files sampled{1,2,...n}.out
# First of all create a folder 
mkdir -p $datapath
cd $datapath
# Clear all the previous sampled* files
rm -f sampled*

# Create the Matlab program
export program_name="run_surpr_landscape.m"
# clear the previous one if existing
rm -f $program_name

echo "function run_surpr_landscape(n)" >> ${program_name}
echo "addpath('~/workspace/communityalg');" >> ${program_name}
echo "addpath('~/workspace/paco/build');" >> ${program_name}
echo "A=ring_of_custom_cliques(repmat(${n},1,${k}));" >> ${program_name}
echo "parpool;" >> ${program_name}
echo "parfor i=1:n" >> ${program_name}
echo	"[memb,q] = paco_mx(A,'quality',0,'nrep',5);">> ${program_name}
echo "end" >> ${program_name}
echo "dlmwrite('ring_clique_n${n}_k${k}.adj',A,'delimiter',' ');" >> ${program_name}

# Run matlab on 100 instances
export trialstring=`echo "run_surpr_landscape(${trials});exit;"`
matlab -nodesktop -nosplash -r `echo ${trialstring}`

# # Collect all the data in the sampled_final.out
echo "[INFO] Merging all temporary solutions "
for f in `ls sampled*.out`
do
	cat $f >> sampled_final_ring_cliques_${n}_${k}_${trials}.out
	echo "-2.000000,[0.0]" >> sampled_final_ring_cliques_${n}_${k}_${trials}.out
done

# Filter out the data
export filtered_file=filtered_surp_ring_cliques_${n}_${k}_${trials}.out
python ~/workspace/qsampling/src/sampling/filter_samples.py -u -g -f ${filtered_file} sampled_final_ring_cliques_${n}_${k}_${trials}.out

export run_embedding_string=`echo "addpath('~/workspace/qsampling/src/viz');create_embedding('${filtered_file}')"`
matlab -r `echo ${run_embedding_string}`