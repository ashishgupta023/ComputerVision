function idx = KMeansClustering(X, k, centers)
% Run the k-means clustering algorithm.
%
% INPUTS
% X - An array of size m x n containing the points to cluster. Each row is
%     an n-dimensional point, so X(i, :) gives the coordinates of the ith
%     point.
% k - The number of clusters to compute.
% centers - OPTIONAL parameter giving initial centers for the clusters.
%           If provided, centers should be a k x n matrix where
%           centers(c, :) is the center of the cth cluster. If not provided
%           then cluster centers will be initialized by selecting random
%           rows of X. You don't need to use this parameter; it is mainly
%           here to make your code more easily testable.
%
% OUTPUTS
% idx     - The assignments of points to clusters. idx(i) = c means that the
%           point X(i, :) has been assigned to cluster c.

    if ~isa(X, 'double')
        X = double(X);
    end
    m = size(X, 1);
    n = size(X, 2);
    %display(size(X));
    
    % If initial cluster centers were not provided then initialize cluster
    % centers to random rows of X. Each row of the centers variable should
    % contain the center of a cluster, so that centers(c, :) is the center
    % of the cth cluster.
    if ~exist('centers', 'var')
        centers = zeros(k, n);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            YOUR CODE HERE                           %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        for i = 1:k
            r = randi([1,n],1);
            for j = 1:n
                centers(i,j) = X(r,j);
            end
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            END YOUR CODE                            %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    
    % The assignments of points to clusters. If idx(i) == c then the point
    % X(i, :) belongs to the cth cluster.
    idx = zeros(m, 1);

    % The number of iterations that we have performed.
    iter = 0;
    
    % If the assignments of points to clusters have not converged after
    % performing MAX_ITER iterations then we will break and just return the
    % current cluster assignments.
    MAX_ITER = 100;
    
    while true        
        % Store old cluster assignments
        old_idx = idx;
        
        % Compute distances from each point to the centers and assign each
        % point to the closest cluster.
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            YOUR CODE HERE                           %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            for i = 1:m % each n dimensional point in X
                min = 999999;
                dist = 0;
                cluster_assignment = 0;
                for z = 1:k % k centers
                    for j = 1:n % for each dimension of a point in X
                         dist = dist + (X(i,j) - centers(z,j))^2;
                    end
                    dist = sqrt(dist);
                    if(dist < min)
                        min = dist;
                        cluster_assignment = z;
                    end
                end
                if cluster_assignment ~= 0
                    idx(i,1) = cluster_assignment;
                end
            end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            END YOUR CODE                            %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Break if cluster assignments didn't change
        if idx == old_idx
            break;
        end

        % Update the cluster centers
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            YOUR CODE HERE                           %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        total_points_in_the_cluster = zeros(k,1);
        centers = zeros(k, n);
        for i = 1:m
            for z = 1:k
                if idx(i,1) == z
                    for j = 1:n
                        centers(z,j) =  centers(z,j) + X(i,j);
                    end
                        total_points_in_the_cluster(z,1) =  total_points_in_the_cluster(z,1) + 1;
                end
            end
        end
        %calculating the mean
        for z=1:k
             for j = 1:n
                 centers(z,j) = centers(z,j)/ total_points_in_the_cluster(z,1);
             end
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            END YOUR CODE                            %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Stop early if we have performed more than MAX_ITER iterations
        iter = iter + 1;
        %display(iter);
        if iter > MAX_ITER
            break;
        end
    end
end
