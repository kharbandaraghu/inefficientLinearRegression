% INEFFICIENT Linear regression by hit and trial
%
% This function produces a best fil line of regression by hit and trial
% method i.e. by calculating all kinds of lines that are possible
%
% The idea is just to simply get all possible lines and test for best fit
% by creating a square over all possible values and then creating every
% possible combination of line segments 
%
%
% ARGUEMENTS
% ===========
% X   x values
% Y   y values
% n   number of subsegments ( greater n = more accuracy)
% avoid n>5000, it takes too long! thats because this is Inefficient
% ===========
%
%
% RETURN VALUES
% =============
% mySlope        slope of linear regression line
% yIntercept     y-intercept of linear regression line
%
%
%
%
%                 segment2
%              ___________
%             |    .     .|
%             |       .   |
%  segment1   | .  . .    |  segment3
%             |  .    .   |
%             |.  .       |
%             |___________|
%                  segment4
%
%
       
function [mySlope yIntercept] = linReg(X, Y, n)
 
    % if size of X and Y is not same, error is raised
    if size(X) ~= size(Y)
        throw(MException('MATLAB:invalid_argument', 'size of x and y values mus be same'));
    end
    % X and Y must be row vectors
    if ~ isrow(X) && ~ isrow(Y)
        throw(MException('MATLAB:invalid_argument', 'at least one of the vectors is not a row vector'));
    end
 
    % getting length of X
    len = length(X);
 
    % setting up the square over which all calculations are made
    Xs = min(X);
    Xl = max(X);
    Ys = min(Y);
    Yl = max(Y);
 
    vals1 = linspace(Ys, Yl, n);
    vals2 = linspace(Xs, Xl, n);
    vals3 = vals1;
    vals4 = vals2;
    sum = 0;
    mySum = inf;
    myVals = [0 0 0 0];
 
    % do for segment 1
    for i = 1:n
        % subloop for segment 2
        for j = 1:n
         
            ptx1 = Xs;
            pty1 = vals1(i);
            ptx2 = vals2(j);
            pty2 = Yl;
         
            m = (pty2 - pty1) / (ptx2 - ptx1);
            if m == inf || isnan(m)
                continue;
            end
         
            for k = 1:len
                myY = m * (X(k) - ptx2) + pty2;
                dist = (Y(k) - myY) ^ 2;
                sum = sum + dist;
            end
         
            if sum < mySum
                mySum = sum;
                myVals = [ptx1 pty1 ptx2 pty2];
            end
            sum = 0;
         
        end
     
        % subloop for segment 3
        for j = 1:n
         
            ptx1 = Xs;
            pty1 = vals1(i);
            ptx2 = Xl;
            pty2 = vals3(j);
         
            m = (pty2 - pty1) / (ptx2 - ptx1);
            if m == inf || isnan(m)
                continue;
            end
         
            for k = 1:len
                myY = m * (X(k) - ptx2) + pty2;
                dist = (Y(k) - myY) ^ 2;
                sum = sum + dist;
            end
         
            if sum < mySum
                mySum = sum;
                myVals = [ptx1 pty1 ptx2 pty2];
            end
            sum = 0;
         
        end
     
    end
    
    % do for segment 4
    for i = 1:n
        % subloop for segment 1
        for j = 1:n
         
            ptx1 = vals4(i);
            pty1 = Ys;
            ptx2 = Xs;
            pty2 = vals1(j);
         
            m = (pty2 - pty1) / (ptx2 - ptx1);
            if m == inf || isnan(m)
                continue;
            end
         
            for k = 1:len
                myY = m * (X(k) - ptx2) + pty2;
                dist = (Y(k) - myY) ^ 2;
                sum = sum + dist;
            end
         
            if sum < mySum
                mySum = sum;
                myVals = [ptx1 pty1 ptx2 pty2];
            end
            sum = 0;
         
        end
     
        % subloop for segment 2
        for j = 1:n
         
            ptx1 = vals4(i);
            pty1 = Ys;
            ptx2 = vals2(j);
            pty2 = Yl;
         
            m = (pty2 - pty1) / (ptx2 - ptx1);
            if m == inf || isnan(m)
                continue;
            end
         
            for k = 1:len
                myY = m * (X(k) - ptx2) + pty2;
                dist = (Y(k) - myY) ^ 2;
                sum = sum + dist;
            end
         
            if sum < mySum
                mySum = sum;
                myVals = [ptx1 pty1 ptx2 pty2];
            end
            sum = 0;
         
        end
     
    end
    
    % plotting graph
    plot(X, Y, 'bo');
    hold on;
    xx = linspace(Xs, Xl, 100);
    mySlope = ((myVals(4) - myVals(2)) / (myVals(3) - myVals(1)));
    yy = (mySlope * (xx(1, :) - myVals(1))) + myVals(2);
    plot(xx, yy, 'r');
    
    % calculating and displaying the equation of line
    yIntercept = yy(4)-mySlope*xx(4);
    
 
end