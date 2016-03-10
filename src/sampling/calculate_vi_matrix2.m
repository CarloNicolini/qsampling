function VI = calculate_vi_matrix2(partition_vectors)

addpath('~/workspace/BCT/');
nnodes = size(partition_vectors,2);
VI = zeros(nnodes,nnodes);
for i=1:size(partition_vectors,1)
    for j=i:size(partition_vectors,1)
        if i==j
            continue
        end
        VI(i,j)=partition_distance(partition_vectors(i,:),partition_vectors(j,:));
    end
end

VI=triu(VI)+triu(VI)';