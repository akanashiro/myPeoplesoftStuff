/*markdown
# Diversas queries sobre componentes
Formateado con [SQL Notebook][def]

[def]: https://marketplace.visualstudio.com/items?itemName=cmoog.sqlnotebook
*/

/*markdown
## Verificar que el usuario puede ejecutar un CI específico 
*/

SELECT A.OPRID, A.CLASSID, B.ROLENAME, C.BCNAME
FROM PSUSERCLASSVW A,
     PSROLECLASS B,
     PS_PSBCDEFN_VW C
WHERE A.oprid = '<user>'
  AND A.CLASSID = B.CLASSID
  AND B.CLASSID = C.CLASSID
  AND C.BCNAME = '<ci>';

/*markdown
## Verificar si el usuario tiene acceso a un componente/página específico.
Muestra el usuario y listas de permisos.
*/

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

/*markdown
## Encontrar la ruta de un componente.
*/

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

/*markdown
## With this query you can retrieve permission list, menu, pages and authorization based on a component.
http://peoplesoft.wikidot.com/forum/t-217275/information-for-documentation-purpose-through-peoplesoft-pro
*/

/* 
Displayonly = 1 (true) / 0 (false).

Authorizedactions = 1 (Add) / 2 (Update/View) / 4 (View All) / 8 (Correct).
These number can be combined. E.g.: 12 (View All + Correct).
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