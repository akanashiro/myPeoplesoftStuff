```
!----------------------------------------------------------------------!
! Report Name: ejemplo.SQR                                             !
!----------------------------------------------------------------------!
!                                                                      !
! Confidentiality Information:                                         !
!                                                                      !
! This module is the confidential and proprietary information of       !
! PeopleSoft, Inc.; it is not to be copied, reproduced, or transmitted !
! in any form, by any means, in whole or in part, nor is it to be used !
! for any purpose other than that for which it is expressly provided   !
! without the written permission of PeopleSoft.                        !
!                                                                      !
! Copyright (c) 1988-2000 PeopleSoft, Inc. All Rights Reserved         !
!                                                                      !
!----------------------------------------------------------------------!
!                                                                      !
!       $Release:  FDM801                                              !
!      $Revision:  1                                                   !
!    $Version-ID:  \main\FDM800_stg\FDM801_stg\1                       !
!                                                                      !
!----------------------------------------------------------------------!
! Program Desc:                                                        !
! Programa de ejemplo 						       !
!----------------------------------------------------------------------!
!----------------------------------------------------------------------!

!-------------------------------------------
! Report Setup
!-------------------------------------------

#include 'setenv.sqc'
begin-setup
    #include 'ptset02a.sqc'     ! include setupdb.sqc and printer specfic commands
end-setup
#include 'sqrtrans.sqc'

!-------------------------------------------
! Report Columns Definitions
!-------------------------------------------

#define reqid_col                   5       ! length 10
#define reqdt_col                   17      ! length 10
#define reqstatus_col               30      ! length 10
#define budgethdr_col               45      ! length 10
#define line_nbr_col                60      ! length 7
#define sched_nbr_col               66      ! length 5
#define distrib_ln_col              77      ! length 5
#define distrib_ln_st_col           87      ! length 10
#define budgetln_col                102     ! length 10

!-------------------------------------------
! Begin Heading
!-------------------------------------------
Begin-Heading 7
#debugh do debug-msg('Entering: Heading')

 let $ReportTitle = 'Practica'
   
   !-------------------------------------------------------
   !Esta seccion imprime el encabezado
   !-------------------------------------------------------
   print '            '    (2,1)
   print 'PeopleSoft'      ()          center bold
   print 'Report ID:  '    (+1,5)      bold
   print $ReportID         ()          bold
   uppercase $ReportTitle
   print $ReportTitle      ()          center bold
   let #RptCol = {ColR} - 2
   page-number             (0,#RptCol)   'Page No.  '
   print 'Run Date '       (+1,#RptCol)              bold
   print $ReportDate       ()                        bold
   print 'Run Time '       (+1,#RptCol)              bold
   print $ReportTime       ()                        bold
 
   let $xv_Business_Unit = 'Business Unit:'
   let $xv_Req_Id  = 'Req Id'
   let $xv_Req_DT = 'Req Date'
   let $xv_Req_Status = 'Req Status'
   let $xv_Budget_Hdr_status = 'Budget Status'
   let $xv_Line_nbr = 'Line'
   let $xv_Sched_nbr   = 'Sched'
   let $xv_Distrib_nbr   = 'Dist'
   let $xv_Distrib_Status = 'Dist Status'
   let $xv_Budget_Ln_Status = 'Budget Ln Status'
  
   print $xv_Business_Unit                   (+1,5)     bold
   print $bus_unit                           (,20,5)   bold

  
   print $xv_REQ_ID                          (+2,{reqid_col})      bold
   print $xv_REQ_DT                          (0,{reqdt_col})       bold 
   print $xv_REQ_STATUS                      (0,{reqstatus_col})   bold
   print $xv_BUDGET_HDR_STATUS               (0,{budgethdr_col})   bold
   print $xv_Line_nbr                        (0,{line_nbr_col})    bold
   print $xv_sched_nbr                       (0,{sched_nbr_col})   bold
   print $xv_distrib_nbr                     (0,{distrib_ln_col})  bold
   print $xv_distrib_status                  (0,{distrib_ln_st_col}) bold
   print $xv_budget_ln_status                (0,{budgetln_col})    bold

   print '----------'                        (+1,{reqid_col})       bold
   print '----------'                        (0,{reqdt_col})        bold
   print '----------'                        (0,{reqstatus_col})    bold
   print '-------------'                     (0,{budgethdr_col})    bold
   print '-------'                           (0,{line_nbr_col})    bold
   print '-------'                           (0,{sched_nbr_col})   bold
   print '-------'                           (0,{distrib_ln_col}) bold
   print '----------'                        (0,{distrib_ln_st_col}) bold
   print '----------------'                  (0,{budgetln_col})     bold

#debugh do debug-msg('Exiting: Heading')
End-Heading



!-----------------------------------------------------------------------
! Begin Report
!
! Init-Number:  - number.sqc
!  This procedure sets some variable for use by the other procedures in
!  this SQC.  It needs to be called prior to the others being called.
!-----------------------------------------------------------------------
Begin-Report
#debugh do debug-msg('Entering: Report')

  do Init-Report
  do Init-Number
  do Main-Procedure
  do Closing-Process

#debugh do debug-msg('Exiting: Report')
End-Report


!-------------------------------------------
! Initialize Report
!-------------------------------------------

Begin-Procedure Init-Report
#debugh do debug-msg('Entering: Init-Report')

  Move 'EJEMPLO' TO $ReportID
  Move 'N' to $Input_found
  do Init-Datetime
  do Get-Current-DateTime
  do Define-Prcs-Vars                   !prcsdef.sqc

! if the program came through the process scheduler,
! the $prcs_process_instance = 1

  do Get-Run-Control-Parms              !prcsapi.sqc

! Get-Xlat-Fields:
! This function will get the string text from the string table
! For each program, you can define a series of string IDs (fields) with its
! corresponding string text and width using Utilities-Use-String Table menu path
! This particularly useful for globalization purpose.

  do Get-Xlat-Fields

! get the parameters entered by oprid when submitting the rpt
! (i.e. from the run control record) based on oprid and run control id

  do select-parameters

  if $prcs_process_instance = ''
     let #process_instance = 0
  else
!    Move the parameters obtained from the run control record thru
!    the Select-Parameters procedure to variables used in this program
     do Move-Run-Control-Parms
  end-if


#debugh do debug-msg('Exiting: Init-Report')
End-Procedure

!-------------------------------------------
! Move-Run-Control-Parms
!-------------------------------------------

Begin-Procedure Move-Run-Control-Parms

   move $prcs_process_instance    to #process_instance
   move $prcs_oprid               to $run_oprid
   move $prcs_run_cntl_id         to $run_cntl_id
   move &cntrl_pur.business_unit  to $sel_bu

End-Procedure !Move-Run-Control-Parms





!-------------------------------------------
!  Main Procedure
!-------------------------------------------

begin-procedure Main-Procedure

  display 'main procedure'

  do Select-Review-All


end-procedure Main-Procedure


!-------------------------------------------
!  Select all in view where cancel_ind = 'Y'
!-------------------------------------------

begin-procedure Select-Review-All

  display 'select-Review-all'

print ' ' (+1,5)

begin-SELECT


P.BUSINESS_UNIT              (0,0)                    ON-BREAK  PRINT=NEVER
                                                              SKIPLINES=1
                                                              LEVEL=1
                                                              AFTER=Print-BusUnit-Total

P.VOUCHER_ID

L.VOUCHER_LINE_NUM

L.DESCR

L.QTY_VCHR

L.UNIT_PRICE

L.MERCHANDISE_AMT




A.REQ_ID                     
B.REQ_STATUS         &REQ_STATUS
B.BUDGET_HDR_STATUS  &BUDGET_HDR_STATUS
C.LINE_NBR                        
C.SCHED_NBR                  
C.DISTRIB_LINE_NUM           
C.DISTRIB_LN_STATUS   &DISTRIB_LN_STATUS
C.BUDGET_LINE_STATUS  &BUDGET_LINE_STATUS

  ! Format date
  !  do Format-DateTime(&REQ_DT, $out, {DEFDATE},'', '',)
  !  print $out             (0,{reqdt_col})


  !  Get Translate Value
  !  LET $FieldName = 'REQ_STATUS'
  !  LET $FieldValue = &REQ_STATUS
  !  Do Read-Translate-Table
  !  Print $XlatShortName   (0,{reqstatus_col})
   
  !  LET $FieldName = 'BUDGET_HDR_STATUS'
  !  LET $FieldValue = &BUDGET_HDR_STATUS
  !  Do Read-Translate-Table
  !  Print $XlatShortName (0,{budgethdr_col})
   
  !  LET $FieldName = 'DISTRIB_LN_STATUS'
  !  LET $FieldValue = &DISTRIB_LN_STATUS
  !  Do Read-Translate-Table
  !  Print $XlatShortName (0,{distrib_ln_st_col})
   
  !  LET $FieldName = 'BUDGET_LINE_STATUS'
  !  LET $FieldValue = &BUDGET_LINE_STATUS
  !  Do Read-Translate-Table
  !  Print $XlatShortName (0,{budgetln_col})
      
  !  move &P.BUSINESS_UNIT   to $bus_unit
  !  DO PRINT-VALORES

FROM
    PS_VOUCHER P,
    PS_VOUCHER_LINE L

WHERE
    P.BUSINESS_UNIT = L.BUSINESS_UNIT AND
    P.VOUCHER_ID = L.VOUCHER_ID AND
    P.BUSINESS_UNIT  =  $sel_bu
ORDER BY
P.BUSINESS_UNIT

end-SELECT


end-procedure Select-Review-All


!-------------------------------------------
!  Total for Business Unit
!-------------------------------------------

begin-procedure Print-BusUnit-Total

print 'END-BUSINESS UNIT '   (+2,5)

end-procedure Print-BusUnit-Total


!--------------------------------------------------------------------!
! do get-Xlat-Fields
!--------------------------------------------------------------------!
begin-procedure Get-Xlat-Fields
  #debugh do debug-msg('Get-Xlat-Fields')


  do init_report_translation('EJEMPLO', $prcs_language_cd)

  do Get_Field_Information('EJEMPLO', 'BUSINESS_UNIT', $xv_BUSINESS_UNIT, #xfw_BUSINESS_UNIT)

  do Get_Field_Information('EJEMPLO', 'REQ_ID', $xv_REQ_ID, #xfw_REQ_ID)

  do Get_Field_Information('EJEMPLO', 'REQ_DT', $xv_REQ_DT, #xfw_REQ_DT)

  do Get_Field_Information('EJEMPLO', 'REQ_STATUS', $xv_REQ_STATUS, #xfw_REQ_STATUS)

  do Get_Field_Information('EJEMPLO', 'BUDGET_HDR_STATUS', $xv_BUDGET_HDR_STATUS, #xfw_BUDGET_HDR_STATUS)

  do Get_Field_Information('EJEMPLO', 'DISTRIB_LN_STATUS', $xv_DISTRIB_LN_ST_COL, #xfw_DISTRIB_LN_ST_COL)

 end-procedure ! Get-Xlat-Fields



!----------------------------------------------------
! Error OK Routine
!--------------------------------------------------------

Begin-procedure Error-OK-Rtn

 display 'SQL Error found in: ' noline
 display $sql_stmt_text
 display 'SQL status is:  ' noline
 display #sql-status
 display $sql-error

end-procedure Error-OK-Rtn

!----------------------------------------------------
! Closing Process
!--------------------------------------------------------

Begin-procedure Closing-Process

 do process-scheduler-closing

 do Commit-Transaction


end-procedure Closing-process

!-------------------------------------------------------
! Process-Scheduler-Closing
!--------------------------------------------------------

begin-procedure process-scheduler-closing

 if $prcs_process_instance <> ''

  let $prcs_run_status = 'S'

  let $prcs_message_parm1 = 'Successful Completion'

  do Update-Prcs-Run-Status

 end-if

end-procedure process-scheduler-closing



!-------------------------------------------------------------------!
! Do Select Parameters                                              !
!-------------------------------------------------------------------!
begin-procedure select-parameters

begin-select
         ! begin the field selection
CNTRL_PUR.LANGUAGE_CD,
CNTRL_PUR.BUSINESS_UNIT,

  if isnull(&CNTRL_PUR.LANGUAGE_CD)
    move 'ENG' to $prcs_language_cd
  else
    move &CNTRL_PUR.LANGUAGE_CD to $prcs_language_cd
  end-if

FROM

   PS_RUN_CNTL_PUR CNTRL_PUR

WHERE

   CNTRL_PUR.OPRID = $prcs_oprid and
   CNTRL_PUR.RUN_CNTL_ID = $prcs_run_cntl_id

end-select

end-procedure  !select-parameters



!-------------------------------------------------------------------!
! Debug Msg                                                         !
!-------------------------------------------------------------------!
begin-procedure Debug-Msg($procedure_name)
   display ' '
   display '----------------------------------'
   display $procedure_name
   display ' '
end-procedure ! Debug-Msg



!---------------------------------------------------------------------------!
! Called SQC Procedures         !
!---------------------------------------------------------------------------!

#include 'curdttim.sqc'    !Get Current Date and Time
#include 'readxlat.sqc'    !Read Translate Table
!#include 'poasksi.sqc'     !Get Set ID Input

#include 'prcsapi.sqc'     !Update Process REQuest API --> Get-Run-Control-Parms
#include 'prcsdef.sqc'     !Update Process REQuest variable declare --> Define-Prcs-Vars
!#include 'pogetid.sqc'     !Get Run Control -> Select-Parameters and Get-Run-Location
#include 'validdt.sqc'     !Validate date routine

#include 'datetime.sqc'    !format date time
#include 'tranctrl.sqc'    !Commit Transaction
#include 'number.sqc'
```