<!--- CFWebstore, version 6.50 --->

<!--- Called from users.email circuit. Displays form for a user to update their email information. --->
<cfparam name="attributes.message" default="">
<cfparam name="attributes.email" default="">
<cfparam name="attributes.xfa_submit_email" default="fuseaction=users.email">
<cfparam name="attributes.xfa_success" default="fuseaction=users.manager">
	
<!-- start users/manager/dsp_email_update.cfm -->
<div id="dspemailupdate" class="users">

<cfoutput>
<form name="editform" action="#XHTMLFormat('#request.self#?#attributes.xfa_submit_email##request.token2#')#" method="post">
<input type="hidden" name="xfa_success" value="#HTMLEditFormat(attributes.xfa_success)#"/>
<input type="hidden" name="XFA_failure" value="#Request.CurrentURL#">
<cfset keyname = "emailAddressUpdate">
<cfinclude template="../../includes/act_add_csrf_key.cfm">
</cfoutput>	

<cfmodule template="../../customtags/format_input_form.cfm"
box_title="Update Email Address"
width="400"
required_fields="0"
>

	
	<cfif len(attributes.Message)>
	<tr>
		<td colspan="3" align="center" class="formerror">
			<br/><cfoutput>#HTMLEditFormat(attributes.Message)#</cfoutput><br/><br/>
		</td>
	</tr>
	</cfif>

	<tr><cfoutput>
		<td align="right">New Email:</td>
		<td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		<td><input type="text" name="email" value="#HTMLEditFormat(attributes.email)#" size="25" maxlength="50" class="formfield"/></td></tr>
		
	<tr>
		<td align="right">Re-enter Email:</td>
		<td style="background-color: ###Request.GetColors.formreq#;">&nbsp;</td>
		<td><input type="text" name="Verify" class="formfield" size="25" maxlength="50"/>
		<cfif get_User_Settings.UseEmailConf><br/>
		<span class="formtextsmall">An account unlock key will be emailed to this address.</span></cfif>
		</td></tr>
	
	<tr><td colspan="3"><img src="#Request.ImagePath#spacer.gif" alt="" height="3" width="1" /></td></tr>
	
	<tr>
	<td></td><td></td>
	<td><input type="submit" name="submit_email" value="Update"  class="formbutton"/> 
		<input type="button" value="Cancel" onclick="javascript:window.history.go(-1);" class="formbutton"/></td></tr>
	
	<tr>
	<td></td><td></td>
	<td>
		<table class="formtext" border="0" cellpadding="0" cellspacing="0" style="color: ###Request.GetColors.InputTText#;">
		<tr><td style="background-color: ###Request.GetColors.formreq#;" width="3">&nbsp;</td>
		<td>&nbsp;required fields</td></tr></table>
</cfoutput>
	</td></tr>

</cfmodule>
</form>

<cfprocessingdirective suppresswhitespace="no">
<script type="text/javascript">
<!--
objForm = new qForm("editform");

objForm.required("email,Verify");

objForm.email.validateEmail();
objForm.Verify.validateEmail();

qFormAPI.errorColor = "<cfoutput>###Request.GetColors.formreq#</cfoutput>";
//-->
</script>
</cfprocessingdirective>

</div>
<!-- end users/manager/dsp_email_update.cfm -->
