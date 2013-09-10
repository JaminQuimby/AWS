<!-- Load Queue widget CSS and jQuery -->
<style type="text/css">@import url(assets/plupload/js/jquery.plupload.queue/css/jquery.plupload.queue.css);</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.10.2.min.js"></script>


<!-- Load plupload and all it's runtimes and finally the jQuery queue widget -->
<script type="text/javascript" src="assets/plupload/js/plupload.full.js"></script>
<script type="text/javascript" src="assets/plupload/js/jquery.plupload.queue/jquery.plupload.queue.js"></script>
<script type="text/javascript">
// Convert divs to queue widgets when the DOM is ready
$(function() {
$("#uploader").pluploadQueue({
		// General settings
		runtimes : 'html5,flash',
		url : 'upload.cfc?method=upload',
		max_file_size : '10mb',
		chunk_size : '1mb',
		unique_names : true,

		 // The ID of the drop-zone element.
drop_element: "uploader",
 
// To enable click-to-select-files, you can provide
// a browse button. We can use the same one as the
// drop zone.
browse_button: "selectFiles",
 
// For the Flash engine, we have to define the ID
// of the node into which Pluploader will inject the
// <OBJECT> tag for the flash movie.
container: "uploader",
 
// The URL for the SWF file for the Flash upload
// engine for browsers that don't support HTML5.
flash_swf_url: "./assets/plupload/js/plupload.flash.swf",
 
// Needed for the Flash environment to work.
urlstream_upload: true,
 
// Set up the multi-part data. For now, just leave
// the params blank - we'll be adding to them as
// we start to upload files.
multipart: true,
multipart_params: { },
		// Resize images on clientside if we can
		resize : {width : 320, height : 240, quality : 90},

		// Specify what files to browse for
		filters : [
			{title : "Image files", extensions : "jpg,gif,png"},
			{title : "Zip files", extensions : "zip"}
		],
		


		// Flash settings
		flash_swf_url : 'assets/plupload/js/plupload.flash.swf',

		// Silverlight settings
		silverlight_xap_url : 'assets/plupload/js/plupload.silverlight.xap',
   init : {
            BeforeUpload: function(up, files) {
				alert('testing')
                      up.settings.multipart_params = {'description' : $('#'+files.id+'_description').val()};  
            }
        }
    });
});




        

	
</script>




	<div id="uploader">
		<p>You browser doesn't have Flash, Silverlight, Gears, BrowserPlus or HTML5 support.</p>
	</div>

			
