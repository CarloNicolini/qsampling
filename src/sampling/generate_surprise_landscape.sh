# Create the Matlab program to generate Surprise landscape files sampled{1,2,...n}.out
export n=7
export k=50
rm -f sampled*
export program_name="run_surpr_landscape.m"
rm -f $program_name
echo "[INFO] Starting MATLAB instance to generate samples of partition"
echo "function run_surpr_landscape(n)" >> ${program_name}
echo "addpath('~/workspace/communityalg');" >> ${program_name}
echo "addpath('~/workspace/paco/build');" >> ${program_name}
#echo "A=ring_of_custom_cliques(repmat(${n},1,${k}));" >> ${program_name}
echo "parpool;"
echo "A=load('~/workspace/BCT/GroupAverage_rsfMRI_matrix.mat'); A=double(A.GroupAverage_rsfMRI~=0);" >> ${program_name}
echo "parfor i=1:n" >> ${program_name}
echo	"[memb,q] = paco_mx(A,'quality',0,'nrep',5);">> ${program_name}
echo "end" >> ${program_name}
#echo "dlmwrite('../../data/ring_clique_n${n}_k${k}.adj',A,'delimiter',' ');" >> ${program_name}
echo " exit;" >> ${program_name}

# Run matlab on 100 instances
matlab -nodesktop -nosplash -r "run_surpr_landscape(2400);"

# Collect all the data in the sampled_final.out
rm -f sampled_final*
for f in `ls sampled*.out`
do
	cat $f >> sampled_final
	echo "-2.000000,[0.0]" >> sampled_final
	#rm -f $f
done

# Filter out the data
#python filter_samples.py -u -g -f filtered_sampled_rc_n${n}_k${k}_surprise.out sampled_final
python filter_samples.py -u -g -f filtered_groupaverage_rsfmri_bin_surprise.out sampled_final

##########################################
# Now do the same for modularity
#python anneal.py -f temp -n 100 "../../data/ring_clique_n${n}_k${k}.adj"
#python filter_samples.py -u -g -f filtered_sampled_rc_n${n}_k${k}_modularity.out temp
#rm temp

# Finally should run Matlab and call
#create_embedding('filtered_sampled_rc_n6_k20.out');