% Create a new fuzzy inference system
fis = mamfis('Name','PolymerInjectionFIS');

% Add input variables
fis = addInput(fis,[0 100],'Name','PolymerConcentration');
fis = addInput(fis,[0 500],'Name','InjectionRate');

% Add output variable
fis = addOutput(fis,[0 1],'Name','InjectionEfficiency');

% Define membership functions for PolymerConcentration
fis = addMF(fis,'PolymerConcentration','trapmf',[-10 0 20 40],'Name','Low');
fis = addMF(fis,'PolymerConcentration','trimf',[30 50 70],'Name','Medium');
fis = addMF(fis,'PolymerConcentration','trapmf',[60 80 100 110],'Name','High');

% Define membership functions for InjectionRate
fis = addMF(fis,'InjectionRate','trapmf',[-50 0 100 200],'Name','Low');
fis = addMF(fis,'InjectionRate','trimf',[150 250 350],'Name','Medium');
fis = addMF(fis,'InjectionRate','trapmf',[300 400 500 600],'Name','High');

% Define membership functions for InjectionEfficiency
fis = addMF(fis,'InjectionEfficiency','trapmf',[-0.1 0 0.2 0.4],'Name','Poor');
fis = addMF(fis,'InjectionEfficiency','trimf',[0.3 0.5 0.7],'Name','Average');
fis = addMF(fis,'InjectionEfficiency','trapmf',[0.6 0.8 1 1.1],'Name','Good');

% Add rules
ruleList = [...
    1 1 1 1 1; % If PolymerConcentration is Low and InjectionRate is Low then InjectionEfficiency is Poor
    2 2 2 1 1; % If PolymerConcentration is Medium and InjectionRate is Medium then InjectionEfficiency is Average
    3 3 3 1 1; % If PolymerConcentration is High and InjectionRate is High then InjectionEfficiency is Good
];

fis = addRule(fis,ruleList);

% Evaluate the FIS
polymerConcentration = 90;
injectionRate = 320;
output = evalfis(fis,[polymerConcentration injectionRate]);

% Display the result
fprintf('Injection Efficiency for Polymer Concentration %.1f and Injection Rate %.1f is %.2f\n', polymerConcentration, injectionRate, output);
