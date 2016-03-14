function [h,q_list,partition_vectors,vi_matrix] = create_embedding(filename)

[q_list, partition_vectors] = parse_file(filename);
vi_matrix = calculate_vi_matrix(partition_vectors);
h = plotSpace2(cca(vi_matrix,2,5000),q_list,filename);
save([filename(1:end-4),'.mat'],'q_list','partition_vectors','vi_matrix','h','filename');