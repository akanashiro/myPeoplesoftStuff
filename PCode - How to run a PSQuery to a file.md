You can invoke PS Query using PeopleCode. To do that you can use query classes in PeopleCode.
Query classes in PeopleCode can be used to create a new query, or to modify or delete an existing query. You can also use methods in the Query class to execute the query and have the result set returned as either a rowset or have it format and write the result set to a file.
Query Classes (or API) are accessible using session class/object.
These are the typical set of steps you have to follow in run time with queries.

## 1. Invoke the GetQuery method on the PeopleSoft session object to get a query.

Before you can open an existing query, you have to get a session object. The session controls access to the query, provides error tracing, enables you to set the runtime environment, and so on. The following lines of code check to verify that the session object is valid.

```
/*create a query API object*/
Local ApiObject &aRunQry;
/*create a session API object*/
Local Session &MySession;

/*The current session*/
&MySession = %Session; 
If &MySession <> Null Then 
/*The GetQuery method returns an empty query object. After you have an empty query object, you can use it to open an existing query*/
    &aRunQry= &MySession.GetQuery();
End-If;
```

##  2. Open the specific query you want using Open method.
```
&aRunQry.Open("MY_TEST_QUERY", True, False);
```

the Open method have 3 parameters of the form: Open(QueryName, Public, Update)
QueryName is the name of the specific query and it takes a string value, Second parameter specifies if the query is public or private and last parameter is required and you can say either true of false.

## 3. Adding runtime prompt record to the query as an instance of a PeopleCode record object (Optional)

Assume that you have already created a query using PeopleSoft Query Manager and you have define prompts for the query. In order to populate these prompt values you can use PromptRecord property to access the record instance. Then you can use this as the first input parameter for RunToFile methods.

```
/* Obtain the PromptRecord for the query*/
Local Record &aQryPromptRec;
&aQryPromptRec = &aRunQry.PromptRecord;

This instance of the PromptRecord can be passed to the PeopleCode Prompt function to prompt the user for the runtime values, as follows:

&nResult = Prompt(&strQryName | " Prompts", "", &aQryPromptRec);

/* Populate the runtime parameters */
If &aQryPromptRec <> Null Then
&nResult = Prompt(&strQryName | " Prompts", "", &aQryPromptRec); 
End-If;
```


##  4. Run the query to a file
You can use the RunToFile method to execute the Query and return the result to the file specified with Destination.

```
/* Run the query output for txt in CSV format */ 
If (&aRunQry.RunToFile(&aQryPromptRec, "c:\temp\" | &aRunQry.Name, %Query_TXT, 0) = 0) Then
   MessageBox(0, "", 0, 0, "Resultset saved into file successfully.");
Else
   MessageBox(0, "", 0, 0, "Failed to save Resultset into file.");
End-If;
```

You add prompt record parameters when you schedule a query using Schedule Query page (Reporting Tools, Query, Schedule Query). You can programmatically populate prompt record (QUERY_RUN_PARM) in the schedule query page and use that in your PeopleCode. This is helpful if you want to run a query using an application engine.

To do that  
**Step 1: Populate PS\_QUERY\_RUN\_PARM record using app engine SQL action (say insert prompt record parameters to the PS\_QUERY\_RUN\_PARM record)**  
  
**Step 2: Then use following PeopleCode to assign prompt parameters from PS\_QUERY\_RUN\_PARM to &aQryPromptRec (local prompt record)**

```
&aQryPromptRec = &aRunQry.PromptRecord;
         If &aQryPromptRec <> Null Then        
            &rcdQryRunParms = CreateRecord(Record.QUERY_RUN_PARM);
            &sqlSelectQryParms = CreateSQL("%Selectall(:1) WHERE OPRID = :2 AND RUN_CNTL_ID = :3");
            
            &sqlSelectQryParms.Execute(&rcdQryRunParms, %OperatorId, MY_AET_RECORD.RUN_CNTL_ID);
            
            While &sqlSelectQryParms.Fetch(&rcdQryRunParms)
               For &i = 1 To &rcdQryPrompts.FieldCount
                  If &aQryPromptRec.GetField(&i).Name = &rcdQryRunParms.GetField(Field.FIELDNAME).Value Then
                     &aQryPromptRec.GetField(&i).Value = &rcdQryRunParms.GetField(Field.BNDVALUE).Value;
                     Break;
                  End-If;
               End-For;
            End-While;
            
         &sqlSelectQryParms.Close();
         End-If;
```

**Step 3: Now you can use RunToFile() as follows**

```
/* Run the query output for txt in CSV format */ 
If (&aRunQry.RunToFile(&aQryPromptRec, "c:\temp\" | &aRunQry.Name, %Query_TXT, 0) = 0) Then
   MessageBox(0, "", 0, 0, "Resultset saved into file successfully.");
Else
   MessageBox(0, "", 0, 0, "Failed to save Resultset into file.");
End-If;
```