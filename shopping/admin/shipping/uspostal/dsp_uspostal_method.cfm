<!--- CFWebstore, version 6.50 --->

<!--- Displays the form to add or edit a US Postal method. Called by shopping.admin&shipping=usps_method --->

<cfquery name="GetMethod" datasource="#Request.DS#" username="#Request.DSuser#" password="#Request.DSpass#" maxrows="1">
SELECT * FROM #Request.DB_Prefix#USPSMethods
WHERE ID = #attributes.ID#
</cfquery>

<cfmodule template="../../../../customtags/format_admin_form.cfm"
	box_title="U.S.P.S. Shipping Methods"
	width="450"
	>


	<cfoutput>
	<form action="#self#?fuseaction=shopping.admin&shipping=usps_method#request.token2#"  method="post" name="editform">
	<input type="hidden" name="XFA_failure" value="#Request.CurrentURL#">
	<input type="hidden" name="ID" value="#attributes.ID#"/>
	<cfset keyname = "uspsMethod">
	<cfinclude template="../../../../includes/act_add_csrf_key.cfm">

	<cfinclude template="../../../../includes/form/put_space.cfm">
	
		<tr>
			<td align="right" valign="top" width="35%">Type:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td width="65%">
			<select name="Type" size="1" class="formfield">
			<option value="Domestic" #doSelected(GetMethod.Type,"Domestic")#>Domestic</option>
			<option value="International" #doSelected(GetMethod.Type,"International")#>International</option>
			</select>
			</td>	
		</tr>

		<tr>
			<td align="right" valign="top">Description:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="Name" size="50" maxlength="50" value="#GetMethod.Name#" class="formfield"/>
			<br/><span class="formtextsmall">Shipping name displayed in the store.</span>
			</td>	
		</tr>
		
		<tr>
			<td align="right" valign="top">Code:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="Code" size="50" maxlength="255" value="#GetMethod.Code#" class="formfield"/>
			<br/><span class="formtextsmall">Must match the U.S.P.S. code.</span>
			</td>
		</tr>
		
		<tr>
			<td align="right" valign="top">Priority:</td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="text" name="Priority" value="#doPriority(GetMethod.Priority,0,99)#" size="4" maxlength="10" class="formfield"/>
			<br/><span class="formtextsmall">1 is highest, 0 is none.</span>
			</td>
		</tr>

		<tr>
			<td align="right" valign="top">Used? </td>
			<td style="background-color: ###Request.GetColors.formreq#;"></td>
			<td>
			<input type="radio" name="Used" value="1" #doChecked(GetMethod.Used)# />Yes 
			&nbsp;<input type="radio" name="Used" value="0" #doChecked(GetMethod.Used,0)# />No
			</td>	
		</tr>
		

		<cfinclude template="../../../../includes/form/put_space.cfm">

		<tr>
			<td colspan="2"></td>
			<td><input type="submit" name="submit_method" value="Save" class="formbutton">/ 
			<input type="submit" name="submit_method" value="Delete" class="formbutton"/> 
			
			<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/>
			</td>	
		</tr>	
	</form>

	<cfprocessingdirective suppresswhitespace="no">
	<script type="text/javascript">
	objForm = new qForm("editform");
	
	objForm.required("Name,Code,Priority,Used");
	
	objForm.Name.description = "description";
	objForm.Code.description = "U.S.P.S. code";
	objForm.Priority.validateNumeric();
	
	qFormAPI.errorColor = "###Request.GetColors.formreq#";
	</script>
	</cfprocessingdirective>

</cfoutput>
		
</cfmodule>
