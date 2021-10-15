function [net] = makeCriticNet(numObservation, Name)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

layers = [
    sequenceInputLayer(numObservation, "Name", Name)
    lstmLayer(128,"Name","lstm_1")
    lstmLayer(128,"Name","lstm_2")
    fullyConnectedLayer(1,"Name","CriticFC")];

net = layers;


end

