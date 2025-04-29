```
/*
* Set the enabled state of all the fields in &rec to &state. You
* don't have to call this function directly. For convenience and for
* clarity, call the enable_fields or disable_fields function.
*/
Function set_fields_state(&rec As Record, &state As boolean)

Local number &fieldIndex = 1;
  For &fieldIndex = 1 To &rec.FieldCount
    &rec.GetField(&fieldIndex).Enabled = &state;
  End-For;
End-Function;

/*
 * Enable each field in &rec
 */
Function enable_fields(&rec As Record)
  set_fields_state(&rec, True);
End-Function;

/*
 * Disable each field in &rec
 */

Function disable_fields(&rec As Record)
  set_fields_state(&rec, False);
End-Function;
```
