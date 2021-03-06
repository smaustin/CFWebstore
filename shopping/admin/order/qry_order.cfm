<!--- CFWebstore, version 6.50 --->

<!--- Retrieves the detailed information for an individual order. Called by shopping.admin&order=display and from dsp_print_packlist.cfm --->

<cfparam name="attributes.Order_No" default="0">

<!--- Get the order information --->
<cfquery name="GetOrder" datasource="#Request.DS#" username="#Request.DSuser#" password="#Request.DSpass#">
	SELECT O.*, N.*
	FROM #Request.DB_Prefix#Order_Items O, #Request.DB_Prefix#Order_No N
	WHERE O.Order_No = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.Order_No#"> 
	AND O.Order_No = N.Order_No
	ORDER BY O.Item_ID
</cfquery>
<!--- end custom code --->

<cfif GetOrder.RecordCount>

	<cfquery name="GetCust" datasource="#Request.DS#" username="#Request.DSuser#" password="#Request.DSpass#" maxrows="1">
		SELECT * FROM #Request.DB_Prefix#Customers 
		WHERE Customer_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#GetOrder.Customer_ID#">
	</cfquery>

	<cfinclude template="../../../users/account/qry_get_vendors.cfm">		
	<cfset vendors = StructNew()>
	<cfoutput query="qry_get_vendors">
		<cfset StructInsert(vendors, account_ID, account_name)>
	</cfoutput>

	<!--- Get the Affiliate information --->
	<cfif GetOrder.Affiliate>
		<cfquery name="GetAffiliate" datasource="#Request.DS#" username="#Request.DSuser#" password="#Request.DSpass#">
			SELECT A.AffCode, A.AffPercent, U.User_ID, U.Username, C.FirstName, C.LastName, C.Company 
			FROM (#Request.DB_Prefix#Affiliates A 
				INNER JOIN #Request.DB_Prefix#Users U ON A.Affiliate_ID = U.Affiliate_ID)
			LEFT JOIN #Request.DB_Prefix#Customers C ON U.Customer_ID = C.Customer_ID
			WHERE A.AffCode = <cfqueryparam cfsqltype="cf_sql_integer" value="#GetOrder.Affiliate#">
		</cfquery>
	</cfif>

	<!--- Check for Gift Certificates --->
	<cfquery name="GetCerts" datasource="#Request.DS#" username="#Request.DSuser#" password="#Request.DSpass#">
		SELECT C.Cert_ID, C.Cert_Code, CertAmount, EndDate
		FROM #Request.DB_Prefix#Order_No O, #Request.DB_Prefix#Certificates C
		WHERE O.Order_No = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.Order_No#"> 
		AND C.Order_No = O.Order_No
	</cfquery>

</cfif>

