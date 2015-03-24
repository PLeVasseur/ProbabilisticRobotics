function [ p ] = BayesRuleNotNormalized( p_y_given_x, p_x )
%BAYESRULE Implements Non-Normalized Bayes Rule
    p = p_y_given_x*p_x;
end

