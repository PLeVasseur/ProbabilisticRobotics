% Probabilistic Robotics - Exercise 2.8.1
% Peter LeVasseur
% 3/21/2015
%
% Exercise Statement:
% A robot uses a range sensor that can measure ranges from 0m and 3m. For
% simplicity, assume that the actual ranges are distributed uniformly in
% this interval. Unfortunately, the sensor can be faulty. When the sensor is
% faulty, it constantly outputs a range below 1m, regardless of the actual
% range in the sensor's measurement cone. We know tha the prior
% probability for a sensor to be faulty is p = 0.01.
% 
% Suppose the robot queried its sensor N times, and every single time the
% measurement value is below 1m. What is the posterior probability of a
% sensor fault, for N = 1, 2, ..., 10. Formulate the corresponding
% probabilistic model.
%
% Solution:
% We can use Bayes' theorum for multiple observations
% http://en.wikipedia.org/wiki/Bayesian_inference#Multiple_observations 
%
% Hypotheses:
% H = {h_1, h_2, ..., h_m}
% Observations:
% E = {e_1, e_2, ..., e_n}
%
% Bayes' theorum for multiple observations:
%
% p(h_k | E) = PRODUCT_j[ p(e_j | h_k) ]
%              ------------------------------------------ * p(h_k)
%              SUM_i{ p(h_j) PRODUCT_j[ p(e_j | h_i) ] }
%
% In the case of this exercise, observations are ranges measured by the
% sensor and all happen to be less than one meter (X < 1) and hypotheses are 
% whether the sensor is faulty or not (F or W).
%
% H = { F, W }
% E = {X < 1, X < 1, ..., X < 1}
%     |<--n observations ---->|
% h_k = F
% p(F) = 0.01
% p(W) = 0.99
% 
% Here, we need to find out the following probabilities to complete
% the computation:
% p(e_j | h_k) = p(X < 1 | F) = 1, this follows from the text of the
% exercise, stating that if faulty the sensor will constantly output a
% range below one, i.e. probability that it will output a range below one
% if faulty is 1.
% 
% p(e_j | h_1) = p(X < 1 | F) = 1, same reasoning as p(e_j | h_k).
%
% p(e_j | h_2) = p(X < 1 | W) = 1/3, given that the range reported by the
% sensor lies in the range [0, 3] and the probability is distributed
% uniformly. I.e. (reported range - minimum sensor range) / (maximum sensor
% range - minimum sensor range).
%
% p(F | X) = PRODUCT_j[ p(X < 1 | F) ]
%            ----------------------------------------- * p(F)
%            p(F)*p(X < 1 | F)^n + p(W)*p(X < 1 | W)^n
%
% Substituting these known values into the above equation, we can now solve
% for p(F | E):
% p(F | X) = PRODUCT_j[ 1 ]
%            ----------------------- * 0.01
%            0.1*1^n + 0.99*(1/3)^n
%
% Because PRODUCT_j[ p(X < 1 | F) ] = 1*1*1*...*1,
% p(F | X) = 0.01
%            -----------------------
%            0.1*1^n + 0.99*(1/3)^n

prob_F = zeros(1,10);
for i = 1:10
    prob_F(1,i) = 0.01 / (0.01*1^i + 0.99*(1/3)^i);
end