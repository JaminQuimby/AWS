//----------------------------------------------------------------------------
//
//  $Id: TextMarkup.js 16224 2011-10-03 21:29:50Z vbuzuev $ 
//
// Project -------------------------------------------------------------------
//
//  DYMO Label Framework
//
// Content -------------------------------------------------------------------
//
//  DYMO Label Framework JavaScript Library Samples: QR-code
//
//----------------------------------------------------------------------------
//
//  Copyright (c), 2011, Sanford, L.P. All Rights Reserved.
//
//----------------------------------------------------------------------------


(function()
{
    // stores loaded label info
    var barcodeLabel;
    var barcodeAsImageLabel;


    // called when the document completly loaded
    function onload()
    {
        var printersSelect = document.getElementById('printersSelect');
        var printButton = document.getElementById('printButton');
        var printAsImageButton = document.getElementById('printAsImageButton');
        var printAsImageCanvasButton = document.getElementById('printAsImageCanvasButton');
        var printAsImageCanvas2Button = document.getElementById('printAsImageCanvas2Button');
        
        
        // loads all supported printers into a combo box 
        function loadPrinters()
        {
            var printers = dymo.label.framework.getLabelWriterPrinters();
            if (printers.length == 0)
            {
               // alert("No DYMO printers are installed. Install DYMO printers.");
                return;
            }

            for (var i = 0; i < printers.length; i++)
            {
                var printer = printers[i];

                var printerName = printer.name;

                var option = document.createElement('option');
                option.value = printerName;
                option.appendChild(document.createTextNode(printerName));
                printersSelect.appendChild(option);
            }
        }



        printButton.onclick = function()
        {
            try
            {
                if (!barcodeLabel)
                    throw "Load label before printing";

                if (!printersSelect.value)
                    throw "Select printer.";


                barcodeLabel.setObjectText('Barcode', 'http://developers.dymo.com');

                barcodeLabel.print(printersSelect.value);
            }
            catch(e)
            {
                alert(e.message || e);
            }
        }

        printAsImageButton.onclick = function()
        {
            try
            {
                if (!barcodeAsImageLabel)
                    throw "Load label before printing";

                if (!printersSelect.value)
                    throw "Select printer.";


                $.get("qr.base64", function(qr)
                {
                    try
                    {
                        barcodeAsImageLabel.setObjectText('Image', qr);

                        barcodeAsImageLabel.print(printersSelect.value);
                    }
                    catch(e)
                    {
                        alert(e.message || e);
                    }
                }, "text");
                

            }
            catch(e)
            {
                alert(e.message || e);
            }
        }


        printAsImageCanvasButton.onclick = function()
        {
            try
            {
                if (!barcodeAsImageLabel)
                    throw "Load label before printing";

                if (!printersSelect.value)
                    throw "Select printer.";


                var img = new Image();
                img.onload = function()
                {
                    try
                    {
                        var canvas = document.createElement('canvas');
                        canvas.width = img.width;                     
                        canvas.height = img.height;

                        var context = canvas.getContext('2d');
                        context.drawImage(img, 0, 0);

                        var dataUrl = canvas.toDataURL('image/png');
                        var pngBase64 = dataUrl.substr('data:image/png;base64,'.length);

                        barcodeAsImageLabel.setObjectText('Image', pngBase64);
                        barcodeAsImageLabel.print(printersSelect.value);
                    }
                    catch(e)
                    {
                        alert(e.message || e);
                    }
                };
                img.onerror = function()
                {
                    alert('Unable to load "qr.png"');                    
                };
                img.src = 'qr.png';
            }
            catch(e)
            {
                alert(e.message || e);
            }
        }

        printAsImageCanvas2Button.onclick = function()
        {
            try
            {
                if (!barcodeAsImageLabel)
                    throw "Load label before printing";

                if (!printersSelect.value)
                    throw "Select printer.";


                var img = new Image();
                img.crossOrigin = 'anonymous';
                img.onload = function()
                {
                    try
                    {
                        var canvas = document.createElement('canvas');
                        canvas.width = img.width;                     
                        canvas.height = img.height;

                        var context = canvas.getContext('2d');
                        context.drawImage(img, 0, 0);

                        var dataUrl = canvas.toDataURL('image/png');
                        var pngBase64 = dataUrl.substr('data:image/png;base64,'.length);

                        barcodeAsImageLabel.setObjectText('Image', pngBase64);
                        barcodeAsImageLabel.print(printersSelect.value);
                    }
                    catch(e)
                    {
                        alert(e.message || e);
                    }
                };
                img.onerror = function()
                {
                    alert('Unable to load qr-code image');                    
                };
                img.src = 'https://chart.googleapis.com/chart?chs=300x300&cht=qr&chl=http%3A//developers.dymo.com&choe=UTF-8';
            }
            catch(e)
            {
                alert(e.message || e);
            }
        }

        function loadLabelFromWeb()
        {                     
            // use jQuery API to load labels

            $.get("Barcode.label", function(labelXml)
            {
                barcodeLabel = dymo.label.framework.openLabelXml(labelXml);
            }, "text");

            $.get("BarcodeAsImage.label", function(labelXml)
            {
                barcodeAsImageLabel = dymo.label.framework.openLabelXml(labelXml);
            }, "text");
        }
        
        loadLabelFromWeb();

        // load printers list on startup
        loadPrinters();
    };

    // register onload event
    if (window.addEventListener)
        window.addEventListener("load", onload, false);
    else if (window.attachEvent)
        window.attachEvent("onload", onload);
    else
        window.onload = onload;

} ());