<cfparam name="FORM.data" default=""><cfparam name="FORM.name" default=""><cfheader name="PRAGMA" value="NO-CACHE" /><cfheader name="CACHE-CONTROL" value="NO-CACHE" />
<cfheader name="content-disposition" value="attachment; filename=""export #DateFormat(Now(), 'mm_dd_yyyy')#.csv"""/>
 
 
<cfcontent type="application/vnd.msexcel"><cfoutput><html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>#FORM.name#</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table> #ToString(URLDecode(FORM.data))#</table></body></html></cfoutput>