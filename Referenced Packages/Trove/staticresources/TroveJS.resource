    $j = jQuery.noConflict();
	
    Visualforce.remoting.timeout = 120000; // Set timeout at page level

	$j(document).ready (function () {    
		
		var fileApiSupported = !!(window.File && window.FileReader);
		
		if (!fileApiSupported) {
			$j('#file_upload').hide();
			$j('#file_upload_not_supported').show();

	}});
	    	    
	function ChunkedUploader(guid, extensionClassName, file, objectId, objectName, propertyBag1, propertyBag2) {
	 
	 	this.isNewFile = false;
	    this.file = file;
	    this.objectId = objectId;
	    this.objectName = objectName;
	    this.propertyBag1 = propertyBag1;
	    this.propertyBag2 = propertyBag2;
	    this.extensionClassName = extensionClassName;
	    this.guid = guid;
	 
	 
	    this.file_size = this.file.size;
	    this.chunk_size = (1024 * 100 * 5); // 500k chunks - I was unable to test successfully with larger chunk size
	    this.range_start = 0;
	    
	    //ensure at least 3 chunks
	    if ((this.chunk_size * 3) > this.file_size)
	    {
	    	this.chunk_size = Math.floor(this.file_size / 3);
	    }

	    this.range_end = this.chunk_size;

	 
	    if ('mozSlice' in this.file) {
	        this.slice_method = 'mozSlice';
	    }
	    else if ('webkitSlice' in this.file) {
	        this.slice_method = 'webkitSlice';
	    }
	    else {
	        this.slice_method = 'slice';
	    }
	 
	}
 
	ChunkedUploader.prototype = {
	 
		// Internal Methods __________________________________________________
	 
	    _upload: function(isStart) {

	        var self = this, chunk;
	 
	        // Slight timeout needed here (File read / AJAX readystate conflict?)
	        setTimeout(function() {
	        
	            // Prevent range overflow
	            if (self.range_end > self.file_size) {
	                self.range_end = self.file_size;
	            }
				
	            chunk = self.file[self.slice_method](self.range_start, self.range_end);
	            
                var reader = new FileReader();
                reader.onload = function(event) {
	            
					if (isStart) {
						
				 		$j('#statusmessage').html("Sending 0%");

		       	        Visualforce.remoting.Manager.invokeAction(
		       	        	self.extensionClassName + '.StartUpload',
				            self.guid,
				            self.objectId,
                            self.objectName,
                            self.file_size,
                            self.propertyBag2,
				            self.file.name,
				            event.target.result.split(',')[1],
				            function (result, event) { self._onChunkComplete(result,event); });
	
			        }
			        else if (self.range_end == self.file_size) {

				 		$j('#statusmessage').html("Sending 100%");

		       	        Visualforce.remoting.Manager.invokeAction(
		       	        	self.extensionClassName + '.FinishUpload',
				            self.guid,
                            self.objectId,
                            self.objectName,
                            self.isNewFile?'true':'false',
                            self.propertyBag2,
				            self.file.name,
				            event.target.result.split(',')[1], 
				            self.range_start, 
				            function (result, event) { self._onUploadComplete(result,event); });
			        }
			        else {
	
				 		$j('#statusmessage').html("Sending " + Math.floor((self.range_start / self.file_size) * 100) + "%");

		       	        Visualforce.remoting.Manager.invokeAction(
		       	        	self.extensionClassName + '.ContinueUpload',
				            self.guid,
				            self.objectId,
                            self.objectName,
                            self.propertyBag1,
                            self.propertyBag2,
				            self.file.name,
				            event.target.result.split(',')[1], 
				            self.range_start,
				            function (result, event) { self._onChunkComplete(result,event); });
			        }
			    };
			    
                reader.readAsDataURL(chunk);//Convert the blob from clipboard to base64
		        
	        }, 20);
	    },
	 
	 	_cancelUpload: function () {
	 	
	        var self = this;
    
   	        Visualforce.remoting.Manager.invokeAction(
   	        	this.extensionClassName + '.CancelUpload',
	            this.guid,
                this.objectId,
                this.objectName,
                self.propertyBag1,
                self.propertyBag2,
	            this.file.name,
	            this.isNewFile,
	            function (result, event) { self._onCancelComplete(result,event); });
	            
	 	},
	 
		// Event Handlers ____________________________________________________
	 
	 	
	 
	 
	    _onChunkComplete: function(result, event) {
	        // If the end range is already the same size as our file, we
	        // can assume that our last chunk has been processed and exit
	        // out of the function.
	 
	 		if (result !== null) {
	 			this.isNewFile = result;
	 		}
	 
	 		if (event.status) {
		        // Update our ranges
		        this.range_start = this.range_end;
		        this.range_end = this.range_start + this.chunk_size;
		 
		 
		        // Continue as long as we aren't paused
		        if (!this.is_paused) {
		            this._upload();
		        }
		    }
		    else
		    {
	    		this._onError(result, event);		    
   				this._cancelUpload();
		    }
	    },

	    _onUploadComplete: function(result, event) {
	    

	    	if (event.status) {
   		        setTimeout(function() {
	    				rerenderSharePointFilesPanel();
	    			}, 250);
	    	}
	    	else {
	    		this._onError(result, event);
   				this._cancelUpload();
	    	}	    		    	
	    },
	    
	    _onCancelComplete: function(result, event) {
	    
	    	if (event.status) {
   		        setTimeout(function() {
	    				rerenderSharePointFilesPanel();
	    			}, 250);
	    	}
	    	else {
	    		this._onError(result, event);
	    		rerenderSharePointFilesPanel();
	    	}	    		    	
	    },
	    
	    _onError: function (result, event) {

			if (event.type === 'exception') {
            	alert("An error occurred during the upload.  Response errors: " + event.message);
            } else {
                alert("An error occurred during the upload.  Response message: " + event.message);
            }

	    },
	    
	    _Uint8ToString: function (u8a){
		  var CHUNK_SZ = 0x8000;
		  var c = [];
		  for (var i=0; i < u8a.length; i+=CHUNK_SZ) {
		    c.push(String.fromCharCode.apply(null, u8a.subarray(i, i+CHUNK_SZ)));
		  }
		  return c.join("");
		},
	 
		// Public Methods ____________________________________________________
	 
	    start: function() {
	    	
	    	$j('#submit_btn').attr("disabled","disabled");
	    	$j('#file_input').attr("disabled","disabled");
	    	
	        this._upload(true);
	    },
	 
	    pause: function() {
	        this.is_paused = true;
	    },
	 
	    resume: function() {
	        this.is_paused = false;
	        this._upload();
	    }
	};

	function S4() {
    	return (((1+Math.random())*0x10000)|0).toString(16).substring(1); 
	}
	
	function FileUploader(guid, extensionClassName, file, objectId, objectName, propertyBag1, propertyBag2) {
	 
	 	this.isNewFile = false;
	    this.file = file;
	    this.objectId = objectId;
	    this.objectName = objectName;
	    this.propertyBag1 = propertyBag1;
	    this.propertyBag2 = propertyBag2;
	    this.extensionClassName = extensionClassName;
	    this.guid = guid;
	 
	 
	    this.file_size = this.file.size;
	    
	    if ('mozSlice' in this.file) {
	        this.slice_method = 'mozSlice';
	    }
	    else if ('webkitSlice' in this.file) {
	        this.slice_method = 'webkitSlice';
	    }
	    else {
	        this.slice_method = 'slice';
	    }
	}
	
	FileUploader.prototype = {
		    
	    _upload: function() {

	        var self = this, chunk;
	 
	        // Slight timeout needed here (File read / AJAX readystate conflict?)
	        setTimeout(function() {
	        
				//grab the entire file				
	            chunk = self.file[self.slice_method](0, self.file_size);
	            
                var reader = new FileReader();
                
                reader.onload = function(event) {
	            
			 		$j('#statusmessage').html("Sending 0%");
	
	       	        Visualforce.remoting.Manager.invokeAction(
	       	        	self.extensionClassName + '.StartUpload',
			            self.guid,
			            self.objectId,
	                    self.objectName,
	                    self.file_size,
	                    self.propertyBag2,
			            self.file.name,
			            event.target.result.split(',')[1],
			            function (result, event) { self._onUploadComplete(result,event); });		
				};

                reader.readAsDataURL(chunk);
		        
	        }, 20);
	    	
	    },

	    _onUploadComplete: function(result, event) {
	    

	    	if (event.status) {
   		        setTimeout(function() {
	    				rerenderSharePointFilesPanel();
	    			}, 250);
	    	}
	    	else {
	    		this._onError(result, event);
	    	}	    		    	
	    },

	    _onError: function (result, event) {

			if (event.type === 'exception') {
            	alert("An error occurred during the upload.  Response errors: " + event.message);
            } else {
                alert("An error occurred during the upload.  Response message: " + event.message);
            }

	        setTimeout(function() {
    				rerenderSharePointFilesPanel();
    			}, 250);
	    },
	    
	    start: function() {
	    	
	    	$j('#submit_btn').attr("disabled","disabled");
	    	$j('#file_input').attr("disabled","disabled");
	    	
	        this._upload();
	    }
	    	
	}
	
	
	function UploadSharePointFiles (extensionClassName, objectId, objectName, propertyBag1, propertyBag2) {
	
		// then to call it, plus stitch in '4' in the third group
		var guid = '488c50c5-ffc6-4cec-b8e3-afac570f4843';//(S4() + S4() + "-" + S4() + "-4" + S4().substr(0,3) + "-" + S4() + "-" + S4() + S4() + S4()).toLowerCase();
		var selectedFile = $j('#file_input')[0].files[0];
		var fileExtension = "";

		var a = selectedFile.name.split(".");
		
		if( a.length === 1 || ( a[0] === "" && a.length === 2 ) ) {
		    fileExtension = "";
		}
		else {
			fileExtension = a.pop().toLowerCase();
		}

		var invalidCharacters = '[\\\\\\/:\*\\?"<>\\|#%]';
		
		if(selectedFile.name.match(invalidCharacters))
		{
			alert('The selected file contains invalid characters.  File names cannot contain any one of the following:  \/:*?"<>|#%/&');
			return;  
		}
		
		if (selectedFile.size < 3 || selectedFile.size > 999999999) {
			alert("The selected file is invalid and cannot be uploaded.  File size must be greater than 2 bytes and less than 1G");
			return;
		}
						
		if (["ashx","asmx","json","soap","svc","xamlx"].indexOf(fileExtension) != -1) {
			alert('The file extension of the selected file is not supported and cannot be uploaded');
			return;
		}
		
		if (selectedFile.name.length > 85) {
		
			alert('The name of the selected file is too long.  File names cannot be longer than 85 characters.  The selected file name is ' + selectedFile.name.length + ' characters');
			return;
		}
		

		if (selectedFile.size <= 512000) {
		
			window.fileUploader = new FileUploader(guid, extensionClassName, selectedFile,objectId, objectName, propertyBag1, propertyBag2); 			
			window.fileUploader.start();

		}
		else {

			var viewAllFilesLinkVisible = $j('a:contains("View all files in SharePoint")').length > 0;
			
			if (viewAllFilesLinkVisible) {
				alert('Your file is larger than the 500K upload limit.  Click "View all files in SharePoint" below and upload the file directly in Office 365.');
			}
			else {
				alert('Your file is larger than the 500K upload limit.  Please upload a smaller file.');
			}
/*
			window.chunkedFileUploader = new ChunkedUploader(guid, extensionClassName, selectedFile,objectId, objectName, propertyBag1, propertyBag2); 
			window.chunkedFileUploader.start();
*/
		}
	}
	
	function DeleteSharePointFile(extensionClassName, objectId, objectName, fileName)
	{
 		$j('#statusmessage').html("Deleting " + fileName);
	
        Visualforce.remoting.Manager.invokeAction(
        	extensionClassName + '.DeleteFile',
            objectId,
            objectName,
            fileName,
            function (result, event) 
            { 
		    	if (event.status) {
	   		        setTimeout(function() {
		    				rerenderSharePointFilesPanel();
		    			}, 250);
		    	}
		    	else {
					alert("An error occurred during the upload.  Response errors: " + event.message);		    	
    				rerenderSharePointFilesPanel();
				}	    		    	            	 
            });
	
	}
	
	function ShareWithChatter (extensionClassName, objectId, fileName, fileEditUrl)
	{
        Visualforce.remoting.Manager.invokeAction(
        	extensionClassName + '.ShareWithChatter',
            objectId,
            fileName,
            fileEditUrl,
            '',
            '',
            function (result, event) 
            { 
		    	if (event.status) {
	   		        setTimeout(function() {
		    				alert('An update to the Chatter feed has been posted.');
		    			}, 250);
		    	}
		    	else {
					alert("An error occurred.  Response errors: " + event.message);		    	
    				rerenderSharePointFilesPanel();
				}	    		    	            	 
            });
	
	}
	    