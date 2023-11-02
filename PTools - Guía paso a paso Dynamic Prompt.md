[https://docs.google.com/document/pub?id=1JoKpHVZVk-0jM096O947mXRpwZj8Do-oIMCPff6KtTs&embedded=true](https://docs.google.com/document/pub?id=1JoKpHVZVk-0jM096O947mXRpwZj8Do-oIMCPff6KtTs&embedded=true)

# Creating Dynamic Lookup using %EditTable
1.  Create custom BSU view and follow the key order :  example - Setid , Effdt, Field  corresponding to edit table  

In this example, the record was using ‘EX_LOCATION_VW4’ for the prompt on field TXN_LOCATION.  This view was cloned and then a new custom view was created, and the PeopleCode was modified.

![image00][image00]

One of several new BSU custom views created for project (example In-state, Out of State, Out of US ):

![image01][image01]
![image02][image02]
![image03][image03]
![image04][image04]
![image05][image05]

2. Add derived record with field as edit table prompt to page. 

![image06][image06]
![image07][image07]
![image08][image08]
![image09][image09]

3. Replace prompt with ‘%EditTable’ for each record field (can use editable2, or editable3 if multiple)

![image11][image11]
![image10][image10]
![image12][image12]

4. Add PeopleCode to dynamically set prompt table view (ex. Page activate)  The view used when they click on the prompt is determined by &BSU_Type_Edit and &BSU_Expense_Type . In this example, the user will be selecting In State travel and BSU_EX_INST_VW will be used to populate the search page as shown in PIA example

![image13][image13]
![image14][image14]
![image15][image15]

[image00]: ./images/image00.png
[image01]: ./images/image01.png
[image02]: ./images/image02.png
[image03]: ./images/image03.png
[image04]: ./images/image04.png
[image05]: ./images/image05.png
[image06]: ./images/image06.png
[image07]: ./images/image07.png
[image08]: ./images/image08.png
[image09]: ./images/image09.png
[image10]: ./images/image10.png
[image11]: ./images/image11.png
[image12]: ./images/image12.png
[image13]: ./images/image13.png
[image14]: ./images/image14.png
[image15]: ./images/image15.png