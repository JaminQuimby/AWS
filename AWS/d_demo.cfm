<cfajaxproxy cfc="proxy" jsclassname="proxy" />

<script>
	function serverTimeClick() {
		var instance = new proxy();
		instance.setCallbackHandler(serverTimeSuccess);
		instance.serverTime();
	}
	
	function serverTimeSuccess(result) {
		document.getElementById('output').innerHTML = result;
	}

	function reverseString(source) {
		var instance = new proxy();
		instance.setCallbackHandler(reverseStringSuccess);
		instance.reverseString(source);
	}
	
	function reverseStringSuccess(result) {
		document.getElementById('output').innerHTML = result;
	}
</script>
<button name="serverTime" onClick="serverTimeClick()">Server Time</button>
<br><br>
<input type="text" name="source" id="source" value="Hello World!" />
<button name="reverseString" onClick="reverseString(getElementById('source').value)">Reverse String</button>
<br><br>
<div id="output"></div>