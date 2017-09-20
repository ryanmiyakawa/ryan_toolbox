% Can launch: '1: zpgen, 2: AIS_analyze, 3:uiprobegen'

function launch(name)

if nargin == 0
    name = input('Launch\n\n1:zpgen\n2:AIS_analyze\n3:uiprobegen\n\n');
end


switch name
    case {'zpgen', 1}
        cd('/Users/rhmiyakawa/Documents/MATLAB/zpgen/localzpgen/');
        launch_ZPGEN
        
        
    case {'AIS_analyze', 2}
        cd('/Users/rhmiyakawa/Documents/MATLAB/AIS')
        launchAISGUI
        
    case {'uiprobegen', 3}
        cd('/Users/rhmiyakawa/Documents/MATLAB/AIS')
        uip = uiProbeGen();
        
    case {'LSI_analyze', 4}
        cd('/Users/rhmiyakawa/Documents/MATLAB/LSI/LSI_analysis')
        launch_LSI();
         
end