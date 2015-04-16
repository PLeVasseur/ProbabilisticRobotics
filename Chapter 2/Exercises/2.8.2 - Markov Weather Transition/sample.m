function [ sampled_index, sampled_state ] = sample( probd, states )
%SAMPLE Summary of this function goes here
%   Detailed explanation goes here
    cummd = probd;
    for i=2:length(cummd)
        cummd(i) = cummd(i) + cummd(i-1);
    end
    randnum = rand(1);
    for i=1:length(cummd)
       if randnum < cummd(i)
           sampled_index = i;
           sampled_state = states(i);
           break;
       end
    end
end

