%% Open
% Establish the connection from MATLAB to INCA
IncaOpen;
% Connects to the currently opened experiment
IncaOpenExperiment;
%% Measure element
% Add measure element in current group
IncaAddMeasureElement('WorkbaseDevice1',[],'B_GREEN');
IncaAddMeasureElement('WorkbaseDevice1',[],'B_RED');
IncaAddMeasureElement('WorkbaseDevice1',[],'B_YELLOW');
% Start measure
data=[];
time=[];
IncaShowMessages(0);
IncaSetMeasureReadMode(0)
IncaStartMeasurement;
deltaT=0;
% Measure for 20 seconds
while(deltaT<20)
    pause(0.1)
    [t,d]=IncaGetRecords( 'WorkbaseDevice1','TimeC',500);
    data = [data; d];
    time = [time; t];
    if( length(time))
        % Calculate time measured
        deltaT = time( length(time)) - time(1);
    end
end
IncaStopMeasurement;
IncaShowMessages(1);
% Plot the results
plot(time, data);
%% Calibration element
% Add calibration element
IncaAddCalibrationElement('WorkbaseDevice1','DEMO_CONSTANT_1');
% Get calibration value
value=IncaGetCalibrationValue('WorkbaseDevice1','DEMO_CONSTANT_1');
% Set calibration value
DEMO_CONSTANT_1=10;
result=IncaSetCalibrationValue('WorkbaseDevice1','DEMO_CONSTANT_1',DEMO_CONSTANT_1);
%% Close
IncaClose;
