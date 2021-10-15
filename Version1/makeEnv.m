ObservationInfo = rlNumericSpec([1 1]);
ObservationInfo.Name = 'Agent Actions';
ObservationInfo.Description = 'Distance to Apple';
% ObservationInfo.Description = 'N, NE, E, SE, S, SW, W, NW';

ActionInfo = rlFiniteSetSpec([1 2 3 4]);
ActionInfo.Name = 'Direction';

Paul = rlPPOAgent(ObservationInfo, ActionInfo);
Tony = rlPPOAgent(ObservationInfo, ActionInfo);
% 
% stepFunctionHandle  = @(Action,LoggedSignals) myStepFunction(Action1,Action2, LoggedSignals);
% resetFunctionHandle = 
% 
% env = rlFunctionEnv(ObservationInfo, ActionInfo, stepFunctionHandle, resetFunctionHandle);
% 
% 


