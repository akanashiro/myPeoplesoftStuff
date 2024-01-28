# Trace de Cobol

Steps to enable COBOL trace in PeopleSoft 

1. Navigate to PeopleTools -> Process Scheduler -> Process Types and open the appropriate COBOL SQL process type for the Operating Syster and Database Type.

copy the Parameter List from the process type. 

%%PRCSNAME%% %%DBTYPE%%/%%DBNAME%%/%%OPRID%%/%%OPRPSWD%%/%%RUNCNTLID%%/%%INSTANCE%%//%%DBFLAG%%

2.  Override the Process definition parameter list by navigating to PeopleTools -> Process Scheduler -> Processes and open the COBOL process definition. In the override options change the Parameter List to Override and paste the parameter list copied from the previous step by adding the trace value 135 or 255 between the two slashes as below. 

%%PRCSNAME%% %%DBTYPE%%/%%DBNAME%%/%%OPRID%%/%%OPRPSWD%%/%%RUNCNTLID%%/%%INSTANCE%%/__255__/%%DBFLAG%%

%%PRCSNAME%% %%DBTYPE%%/%%DBNAME%%/%%OPRID%%/%%OPRPSWD%%/%%RUNCNTLID%%/%%INSTANCE%%/__131__/%%DBFLAG%%

se puede cambiar 131 por 255
