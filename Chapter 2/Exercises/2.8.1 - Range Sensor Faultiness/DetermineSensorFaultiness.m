function [ P ] = DetermineSensorFaultinessProbability( E, SM )
%DETERMINESENSORFAULTINESS Summary of this function goes here
%   Detailed explanation goes here
    
    % PRODUCT_j[ p(e_j | h_k) ]
    accumProb_e_j_given_h_k=zeros(size(E(:,1),1),1);
    accumProb_e_j_given_F=zeros(size(E(:,1),1),1);
    accumProb_e_j_given_W=zeros(size(E(:,1),1),1);
    for j=1:size(E(:,1))
        if E(j,1) < SM.faultyMaximumRange
            e_j_given_h_k = SM.probBelowFaultyMaximumRangeIfFaulty;
            e_j_given_F = SM.probBelowFaultyMaximumRangeIfFaulty;
            e_j_given_W = SM.probBelowFaultyMaximumRangeIfWorking;
        else
            e_j_given_h_k = SM.probAboveFaultyMaximumRangeIfFaulty;
            e_j_given_F = SM.probAboveFaultyMaximumRangeIfFaulty;
            e_j_given_W = SM.probAboveFaultyMaximumRangeIfWorking;
        end
        accumProb_e_j_given_h_k(j,1) = e_j_given_h_k;
        accumProb_e_j_given_F(j,1) = e_j_given_F;
        accumProb_e_j_given_W(j,1) = e_j_given_W;
        
        P(j,1) = SM.priorProbabilitySensorFaulty * ...
            prod(accumProb_e_j_given_h_k(1:j,1)) / ...
            ( SM.priorProbabilitySensorFaulty*prod(accumProb_e_j_given_F(1:j,1)) +  ...
            SM.priorProbabilitySensorWorking*prod(accumProb_e_j_given_W(1:j,1)) );
    end

end

