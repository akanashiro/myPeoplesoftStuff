# Trace de application engine
Navigate to the process definition of the application engine that you would like to trace (PeopleTools > Process Scheduler > Processes). Go to the Overrride Options tab, and from the Parameter List drop down select Append, and in the edit box next to it add the following line:
```
-TRACE 7 -TOOLSTRACEPC 4044
-TRACE 7 -TOOLSTRACEPC 2496 -TOOLSTRACESQL 3
```

This is the recommended setting by [Ketan on PeopleSoft Support & Tips](http://peoplesoftexperts.blogspot.com/2008/07/configuration-settings-for-tracing.html):

```
-TRACE 135 -TOOLSTRACESQL 31 -TOOLSTRACEPC 1984
```

I think I would prefer these settings instead:
```
-TRACE 7 -TOOLSTRACESQL 7 -TOOLSTRACEPC 3596
```


The -TRACE option sets the tracing for the App Engine program generally speaking.  For example, it can turn on the trace output that displays which steps run in which order.  Here are the different options (from the psappsrv.cfg file):
* 1 = Trace STEP execution sequence to AET file
* 2 = Trace Application SQL statements to AET file
* 4 = Trace Dedicated Temp Table Allocation to AET file
* 8 = not yet allocated
* 16 = not yet allocated
* 32 = not yet allocated
* 64 = not yet allocated
* 128 = Timings Report to AET file
* 256 = Method/BuiltIn detail instead of summary in AET Timings Report
* 512 = not yet allocated
* 1024 = Timings Report to tables
* 2048 = DB optimizer trace to file
* 4096 = DB optimizer trace to tables
