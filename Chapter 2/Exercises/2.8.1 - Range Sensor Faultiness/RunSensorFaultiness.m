S1 = SensorModel();                     % Default constructor
S2 = SensorModel(0, 5, 0.01, 1, 1);     % Try some different parameters
S3 = SensorModel(0, 3, 0.01, 1, 0.99);     % Try some different parameters

E1 = [ 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1 ].';
E2 = [ 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1 ].';
E3 = [ 0.1, 1.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1 ].';
E4 = [ 0.1, 1.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 1.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1 ].';

S1.DetermineSensorFaultinessProbability( E1 );
S1.plotProbSensorFaulty();
S2.DetermineSensorFaultinessProbability( E2 );
S2.plotProbSensorFaulty();
S1.DetermineSensorFaultinessProbability( E3 );
S1.plotProbSensorFaulty();
S3.DetermineSensorFaultinessProbability( E3 );
S3.plotProbSensorFaulty();
S3.DetermineSensorFaultinessProbability( E4 );
S3.plotProbSensorFaulty();