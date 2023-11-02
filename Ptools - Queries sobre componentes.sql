-- Check if the user can run an specific CI

SELECT A.OPRID, A.CLASSID, B.ROLENAME, C.BCNAME
FROM PSUSERCLASSVW A,
     PSROLECLASS B,
     PS_PSBCDEFN_VW C
WHERE A.oprid = '<user>'
  AND A.CLASSID = B.CLASSID
  AND B.CLASSID = C.CLASSID
  AND C.BCNAME = '<ci>';

-- Check if the user can access to an specific component/page. It shows user and permission lists.
SELECT DISTINCT AI.CLASSID, SS.OPRID
FROM PSAUTHITEM AI, PSCLASSDEFN CD, PSPNLGROUP PG, PSMENUITEM MI, PSOPRCLS SS
WHERE AI.MENUNAME = MI.MENUNAME AND
      AI.BARNAME = MI.BARNAME AND
      AI.BARITEMNAME = MI.ITEMNAME AND
      AI.PNLITEMNAME = PG.ITEMNAME AND
      PG.PNLGRPNAME  = '<component>' AND
      MI.PNLGRPNAME = PG.PNLGRPNAME AND
      MI.MARKET = PG.MARKET AND
      CD.CLASSID = AI.CLASSID AND
      PG.PNLNAME = '<page>' AND
      SS.OPRCLASS = AI.CLASSID AND SS.OPRID IN ('<user>')
ORDER BY SS.OPRID, AI.CLASSID;

-- Find a component's path
SELECTLEVEL, portal.portal_objname,
    LPAD (' ', (4 - LEVEL) * 2)|| (
                 SELECT lng.portal_label
                 FROM sysadm.ps_portal_obj_lng lng
                  WHERE portal.portal_name = lng.portal_name
                  AND portal.portal_reftype = lng.portal_reftype
                  AND portal.portal_objname = lng.portal_objname
                  AND lng.language_cd = '<lang>') || '>' AS descr
FROM sysadm.psprsmdefn portal
WHERE portal_prntobjname <> ' 'AND portal_uri_seg1 LIKE '%'
CONNECT BY PRIOR portal_prntobjname = portal_objname
START WITH portal_objname =
              (SELECT portal_objname
                 FROM (SELECT ROWNUM fila, portal_objname
                         FROM sysadm.psprsmdefn
                        WHERE portal_uri_seg1 LIKE '%'AND portal_uri_seg2 LIKE '%<component>%')
                WHERE fila = 1)
ORDER BY LEVEL DESC;

/*
With this query you can retrieve permission list, menu, pages and authorization based on a component.
http://peoplesoft.wikidot.com/forum/t-217275/information-for-documentation-purpose-through-peoplesoft-pro
*/
SELECT AU.CLASSID,
  HH.MENUNAME,
  HH.BARNAME,
  HH.ITEMNAME,
  II.PNLNAME,
  AU.DISPLAYONLY,
  AU.AUTHORIZEDACTIONS
FROM PSAUTHITEM AU, PSMENUITEM HH,
  PSPNLGROUP II
WHERE AU.MENUNAME = HH.MENUNAME
AND AU.BARNAME = HH.BARNAME
AND AU.BARITEMNAME = HH.ITEMNAME
AND II.PNLGRPNAME = HH.PNLGRPNAME
AND II.MARKET       = HH.MARKET
AND II.PNLGRPNAME = '<component>';

/* 
Displayonly = 1 (true) / 0 (false).

Authorizedactions = 1 (Add) / 2 (Update/View) / 4 (View All) / 8 (Correct).
These number can be combined. E.g.: 12 (View All + Correct).
*/