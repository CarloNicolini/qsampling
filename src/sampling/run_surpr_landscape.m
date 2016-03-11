function run_surpr_landscape(n)
addpath('~/workspace/communityalg');
A=ring_of_custom_cliques(repmat(5,1,40));
parfor i=1:n
[memb,q] = paco_mx(A,'quality',0);
end
dlmwrite('../../data/ring_clique_n5_k40.adj',A,'delimiter',' ');
 exit;
