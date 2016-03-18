<!--- CFWebstore, version 6.50 --->

<!--- Displays the list of color palettes. Called by home.admin&colors=list --->

<cfparam name="currentpage" default="1">

<!--- Create the page through links, max of 20 records per page --->
<cfmodule template="../../customtags/pagethru.cfm" 
	totalrecords="#qry_get_colors.recordcount#" 
	currentpage="#currentpage#"
	templateurl="#self#"
	addedpath="&fuseaction=home.admin&colors=list#request.token2#"
	displaycount="20" 
	imagepath="#Request.ImagePath#icons/" 
	imageheight="12" 
	imagewidth="12"	
	hilitecolor="###request.getcolors.mainlink#">

	
<cfmodule template="../../customtags/format_output_admin.cfm"
	box_title="Color Palettes"
	width="450"
	>
	
<cfoutput>
	<table width="100%" cellspacing="4" border="0" cellpadding="0" class="formtext" style="color: ###Request.GetColors.OutputTText#;">	

	<tr>
		<td><a href="#self#?fuseaction=home.admin&Colors=add#Request.Token2#">Add Palette</a></td>
		<td colspan="2" align="right">#pt_pagethru#</td>
	</tr>
	
	<tr>
			<td colspan="3" style="BACKGROUND-COLOR: ###Request.GetColors.outputHBgcolor#;"><img src="#Request.ImagePath#spacer.gif" alt="" height="1" width="1" /></td>
	</tr>

	<cfif qry_get_Colors.recordcount gt 0>
			
		<cfloop query="qry_get_Colors" startrow="#PT_StartRow#" endrow="#PT_EndRow#">
		<tr>
			<td>
			<a href="#self#?fuseaction=home.admin&Colors=edit&Color_ID=#Color_ID##Request.Token2#">
			Edit #Color_ID#</a></td>
			<td width="65%">#palette_name#</td>
			<td><a href="#self#?fuseaction=home.admin&Colors=add&Color_ID=#Color_ID##Request.Token2#">
			copy</a></td>
		</tr>
		</cfloop>
		</table>
		<div align="center" class="formtext">#pt_pagethru#</div>
	<cfelse>	
		<td colspan="2">
			<br/>
			No records selected
		</td>
	</table>	
	</cfif>
</cfoutput>

</cfmodule>
