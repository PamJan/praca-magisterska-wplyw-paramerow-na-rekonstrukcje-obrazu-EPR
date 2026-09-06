function [HD, HD95] = hausdorff_distance_3D(A, B)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function calculating Hausdorff distance
% and 95th percentile of Hausdorff distance
%
% Inputs
% A = reference 3D binary matrix
% B = test 3D binary matrix
%
% Outputs:
% HD - Hausdorff distance
% HD95 - 95th percentile Hausdorff distance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if isempty(A) || isempty(B)
        HD = NaN;
        HD95 = NaN;
        return
    end

    % extract surface voxels

    surfaceA = A & ~imerode(A,true(3,3,3));
    surfaceB = B & ~imerode(B,true(3,3,3));

    % get coordinates
    [xA,yA,zA] = ind2sub(size(A), find(surfaceA));
    [xB,yB,zB] = ind2sub(size(B), find(surfaceB));

    if isempty(xA) || isempty(xB)
        HD = NaN;
        HD95 = NaN;
        return
    end
    
    ptsA = [xA yA zA] * 0.25;
    ptsB = [xB yB zB] * 0.25;

    % Nearest-neighbour distances
    [~,distA] = knnsearch(ptsB,ptsA);
    [~,distB] = knnsearch(ptsA,ptsB);

    allDist = [distA; distB];

    % Hausdorff distance
    HD = max(allDist);

    % 95th percentile Hausdorff distance
    HD95 = prctile(allDist,95);

end
