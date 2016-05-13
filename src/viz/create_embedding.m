function [h,q_list,partition_vectors,vi_matrix] = create_embedding(filename)

fprintf('Loading files...\n');
[q_list, partition_vectors] = parse_file(filename);
fprintf('Computing VI matrix...\n');
vi_matrix = calculate_vi_matrix(partition_vectors);
fprintf('Computing CCA on VI matrix...\n');
cca_vi_matrix = cca(vi_matrix,2,5000);

fprintf('Plotting CCA data\n');
h = plotSpace2(cca_vi_matrix,q_list,filename);
save([filename(1:end-4),'.mat'],'q_list','partition_vectors','vi_matrix','cca_vi_matrix','filename');
savefig(h,[filename(1:end-4),'.fig']);