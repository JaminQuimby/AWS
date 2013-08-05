<!doctype html>
<html>
<head>
	<meta charset="utf-8" />

	<!-- Style our demo. -->
	<link rel="stylesheet" type="text/css" href="./assets/css/demo.css"></link>

	<!-- Load RequireJS and our bootstrap file. -->
	<script
		type="text/javascript"
		src="./assets/require/require.js"
		data-main="./assets/main.js">
	</script>
</head>
<body>

	<!-- BEGIN: Uploader. -->
	<div id="pluploadContainer" class="uploader">

		<!-- BEGIN: Dropzone + Browse Button. -->
		<a id="pluploadDropzone" class="dropzone html5Dropzone">
			
			<!-- If the HTML5 runtime engine is enabled, show this. -->
			<span class="instructions html5Instructions">
				Drag &amp; Drop Files or Click Here
			</span>
			
			<!-- If the Flash runtime engine is enabled, show this. -->
			<span class="instructions flashInstructions">
				Click Here To Select Files!
			</span>

		</a>
		<!-- END: Dropzone + Browse Button. -->


		<!-- BEGIN: File Queue. -->
		<div class="queue emptyQueue">

			<div class="noFiles">
				Please select some files to upload!
			</div>

			<ul class="files">
				<!-- To be populated dynamically. -->
			</ul>

		</div>
		<!-- END: File Queue. -->


		<!-- BEGIN: Templates For Uploader. -->
		<script type="application/template" class="templates">

			<li class="file">
				<span class="name">FILE-NAME</span>
				<span class="progress">
					(
						<span class="percentComplete">0%</span> of
						<span class="totalSize">0</span>
					)
				</span>
			</li>

		</script>
		<!-- END: Templates For Uploader. -->

	</div>
	<!-- END: Uploader. -->
	

</body>
</html>
