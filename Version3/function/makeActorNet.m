function [net] = makeActorNet(numObs, numActions, Name)
%MAKENET Summary of this function goes here
%   Detailed explanation goes here

layers = [
    sequenceInputLayer(numObs,"Name",Name)
    lstmLayer(128,"Name","lstm_1")
    lstmLayer(128,"Name","lstm_2","OutputMode","sequence")
    fullyConnectedLayer(numActions,"Name","Action")];

net = layers;

end

