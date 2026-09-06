function dsc = dice(A, B)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function calculating Dice coefficient 
% for two logical 3D matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    A = logical(A);
    B = logical(B);
    
    intersection = sum(A(:) & B(:));
    volumA = sum(A(:));
    volumB = sum(B(:));
    
    dsc = 2 * intersection / (volumA + volumB);
end