%% Load Data from ComponentDatabase %%

global path_base

%% Database connection via JDBC driver

jdbc = 'jdbc:sqlite:';
db_string = strcat(jdbc,path_base,'04_Database\ComponentDatabase.db');
conn = database('ComponentDatabase.db','','','org.sqlite.JDBC',db_string);

% conn = database('ComponentDatabase.db','','','org.sqlite.JDBC','jdbc:sqlite:T:\04_Cluster_C\500_SRT\033_SRT Package\Parametric Model\Phi Tran\05 AEV Tool\ComponentDatabase.db');



%% Get data

% AirSpring
sqlquery = 'SELECT * FROM AirSpring';
curs = exec(conn,sqlquery);
curs = fetch(curs);
columnlist = columns(conn);

% convert to struct array
AirSpring = cell2struct(curs.Data,columnlist{1, 2},2);
load ForceTable;

% Merge ForceTable Struct with Data from DB

i=1; % counter AirSpring
j = 1; % counter ForceTable

while i <= length(AirSpring)
    
    while j <= length(ForceTable)
        
        if AirSpring(i).spring_id == ForceTable(j).spring_id
            
            [AirSpring(i).ForceTable] = ForceTable(j).ForceTable;
        end
        
        j = j+1;
        
    end
    j = 1;
    i = i+1;
end

% Brake
sqlquery = 'SELECT * FROM Brake';
curs = exec(conn,sqlquery);
curs = fetch(curs);
columnlist = columns(conn);

% convert to struct array
Brakes = cell2struct(curs.Data,columnlist{2, 2},2);

% Tyre
sqlquery = 'SELECT * FROM Tyre';
curs = exec(conn,sqlquery);
curs = fetch(curs);
columnlist = columns(conn);

% convert to struct array
Tyre = cell2struct(curs.Data,columnlist{3, 2},2);
%%
close(conn);
