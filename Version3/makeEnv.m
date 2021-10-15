numObsSnake = 17;
numObsReward = numObsSnake + 1;

numActSnake = 3;
numActReward = 11;

numTimeSteps = 5;

%Snake Model
ObservationInfo = rlNumericSpec([1 (numObsSnake * numTimeSteps)]);
ObservationInfo.Name = 'Agent Actions';

ActionInfo = rlFiniteSetSpec([1 2 3]);
ActionInfo.Name = 'Direction';

actorNet = makeActorNet(numObsSnake  * numTimeSteps, numActSnake, ObservationInfo.Name);
criticNet = makeCriticNet(numObsSnake  * numTimeSteps, ObservationInfo.Name);

repOpts = rlRepresentationOptions('LearnRate',5e-2,'GradientThreshold',1);

discActor = rlStochasticActorRepresentation(actorNet,ObservationInfo,ActionInfo,'Observation',ObservationInfo.Name);
critic = rlValueRepresentation(criticNet,ObservationInfo,'Observation',ObservationInfo.Name,repOpts);

Paul = rlACAgent(discActor, critic);

%Reward Model
ObservationInfoReward = rlNumericSpec([1 (numObsReward * numTimeSteps)]);
ObservationInfoReward.Name = 'Agent Actions';

ActionInfo = rlFiniteSetSpec([-5 -4 -3 -2 -1 0 1 2 3 4 5]);
ActionInfo.Name = 'Agent Reward';

actorNet = makeActorNet(numObsReward * numTimeSteps, numActReward, ObservationInfoReward.Name);
criticNet = makeCriticNet(numObsReward * numTimeSteps, ObservationInfoReward.Name);

repOpts = rlRepresentationOptions('LearnRate',5e-2,'GradientThreshold',1);

discActor = rlStochasticActorRepresentation(actorNet,ObservationInfoReward,ActionInfo,'Observation',ObservationInfoReward.Name);
critic = rlValueRepresentation(criticNet,ObservationInfoReward,'Observation',ObservationInfoReward.Name, repOpts);

Tony = rlACAgent(discActor, critic);

%Initialize Environment
env = rlSimulinkEnv("rlPlaysSnakeV3", ["rlPlaysSnakeV3/Paul", "rlPlaysSnakeV3/Tony"]);

