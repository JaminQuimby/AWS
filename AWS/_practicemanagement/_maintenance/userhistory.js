$(document).ready(function(){_grid1()});
 
var _run={
	 new_group1:function(){document.getElementById('content').className='contentbig';_toggle('group1,largeMenu');_hide('entrance,smallMenu');}
	 ,load_group1:function(){_grid1()}
}


_grid1=function(){_jGrid({
	"grid":"grid1",
	"url":"usersettings.cfc",
	"title":"User History",
	"fields":{USER_ID:{key:true,list:false,edit:false}
			,SI_NAME:{title:'User'}

			},
	"method":"f_lookupData",
	"arguments":'{"search":"'+$("#g0_filter").val()+'","orderBy":"0","row":"0","ID":"0","loadType":"group1"}',
	"functions":'$("#task_id").val(record.USER_ID);_updateh3(record.NAME);_toggle("group1,largeMenu");_hide("entrance");$("#content").removeClass();$("#content").addClass("contentbig");_loadData({"id":"task_id","group":"group1","page":"usersettings"});'
	})};