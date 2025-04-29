I can never remember which parts of a URL people refer to when they say site vs server, so I'm working on a mnemonic for the URL format provided by Oracle:

`http://server/servlet_name/sitename/portalname/nodename/content_type/content_id?content_parm`

But I also need to know what I should expect to see in each piece of the URL, so here's a slightly altered URL from the Hub landing page.

`https://dev.mysite.com/psc/hub/EMPLOYEE/EMPL/c/NUI_FRAMEWORK.PT_LANDINGPAGE.GBL?`

- **Scheme**: http\[s\] - this term is mentioned elsewhere in PeopleBooks
- **Server**: the basic url, often a vanity url rather than the actual server name
- **Servlet**: psp or psc - wrapped in portal branding/header or content only
- **Site**: usually application or a combination of application and environment (e.g. hubdev)
- **Portal**: the registry, which usually is EMPLOYEE in my experience, but there are others such as SUPPLIER and CUSTOMER
- **Node**: To be honest, I have trouble telling the difference between the purpose of the Portal and that of the Node - but a little research shows me that a node can host multiple portals, and there are also nodes unrelated to portal content
- **\[Content\] Type**: c for component, e for external, f for file, h for homepage, n for navigation, q for query, s for script, w for worklist
- **\[Content\] ID**: basic content generally consists of MENU.COMPONENT.MARKET, but when the content type is not c for component, the format can change
- **\[Content\] Parameters**: optional parameters such as homepage tab, commands, etc.
