classdef SensorModel < handle
    %SENSORMODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        minRange=0;
        maxRange=3;
        
        priorProbabilitySensorFaulty=0.01;
        priorProbabilitySensorWorking=0.99;
        
        faultyMaximumRange=1;
        probBelowFaultyMaximumRangeIfFaulty=1;
        probAboveFaultyMaximumRangeIfFaulty=0;
        probBelowFaultyMaximumRangeIfWorking;
        probAboveFaultyMaximumRangeIfWorking;
        
        probSensorFaultyCalculated;
    end
    
    methods
        function SM = SensorModel( n_minRange, n_maxRange, n_priorProbabilitySensorFaulty, n_faultyMaximumRange, n_probBelowFaultyMaximumRangeIfFaulty)
            if nargin >= 5
                SM.minRange=n_minRange;
                SM.maxRange=n_maxRange;

                SM.priorProbabilitySensorFaulty=n_priorProbabilitySensorFaulty;
                SM.priorProbabilitySensorWorking=(1 - n_priorProbabilitySensorFaulty);

                SM.faultyMaximumRange=n_faultyMaximumRange;
                SM.probBelowFaultyMaximumRangeIfFaulty=n_probBelowFaultyMaximumRangeIfFaulty;
                SM.probAboveFaultyMaximumRangeIfFaulty=(1 - n_probBelowFaultyMaximumRangeIfFaulty);
            end
            SM.probBelowFaultyMaximumRangeIfWorking=(SM.faultyMaximumRange - SM.minRange) ...
                / (SM.maxRange - SM.minRange);
            SM.probAboveFaultyMaximumRangeIfWorking=(SM.maxRange - SM.faultyMaximumRange) ...
                / (SM.maxRange - SM.minRange);
        end
        
        function [ P ] = DetermineSensorFaultinessProbability( SM, E )
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
            SM.probSensorFaultyCalculated = P;    
        end
        
        function [] = plotProbSensorFaulty( SM )
            figure;
            plot( linspace(1,size(SM.probSensorFaultyCalculated(:,1),1),size(SM.probSensorFaultyCalculated(:,1),1)), SM.probSensorFaultyCalculated );
        end
        
    end
    
end