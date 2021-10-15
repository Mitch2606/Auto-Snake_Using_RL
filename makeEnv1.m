numObs = 20;
numAct = 2;

ObservationInfo = rlNumericSpec([1 numObs]);
ObservationInfo.Name = 'Agent_Actions';
ObservationInfo.Description = 'Player1 Action, Player2 Action';

ActionInfo = rlFiniteSetSpec([1 numAct]);
ActionInfo.Name = 'Decision';

actorNet = makeActorNet(numObs, numAct, ObservationInfo.Name);
criticNet = makeCriticNet(numObs, ObservationInfo.Name);

repOpts = rlRepresentationOptions('LearnRate',5e-2,'GradientThreshold',1);

discActor = rlStochasticActorRepresentation(actorNet,ObservationInfo,ActionInfo,'Observation',ObservationInfo.Name);
critic = rlValueRepresentation(criticNet,ObservationInfo,'Observation',ObservationInfo.Name,repOpts);

agent1 = rlACAgent(discActor, critic);
agent2 = rlPPOAgent(discActor, critic);

mdlName = "multiAgentTest";

env = rlSimulinkEnv(mdlName, [mdlName + "/Paul", mdlName + "/Tony"]);

