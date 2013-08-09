window.UploadApp = 
	upload_limit : 8

	fileDialogStart : () ->

	fileQueued : (file) ->
		try

		catch ex
			@debug ex

	fileQueueError : (file, errorCode, message) ->
		try
			switch errorCode
				when SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT
					alert "文件大小超过允许范围."
				when SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE
					alert "不允许上传空文件."
				when SWFUpload.QUEUE_ERROR.INVALID_FILETYPE
					alert "上传文件类型错误."
				when SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED
					alert "超出上传允许文件数.  " + ((if message > 1 then "只能上传 " + message + " 个文件" else "无法上传额外文件."))
				else
					alert "上传异常！"  if file isnt null
		catch ex
			@debug ex

	fileDialogComplete : (numFilesSelected, numFilesQueued) ->
	  try
	    @startUpload()
	  catch ex
	    @debug ex

	uploadStart : (file) ->
	  try
	  catch ex
	  	@debug ex
	  true

	uploadProgress : (file, bytesLoaded, bytesTotal) ->
	  try
	    
	  catch ex
	    @debug ex

	uploadSuccess : (file, serverData) ->
	  try
	  	postList =  $ '#photo-list'
	  	idsList = $ '#photo-ids'
	  	json =  '(' + serverData + ')'
	  	json = $ eval(json)

	  	json.each ->
	  		img =  $ "<img src='#{@photo}' data-id='#{@id}'/>"
	  		postList.append img

	  		input = $ "<input type='hidden' name='photo_id[]' value='#{@id}' />"
	  		idsList.append input

	  		stats = swfu.getStats();
	  		stats.successful_uploads--
	  		swfu.setStats stats
	  catch ex
	    @debug ex

	uploadComplete : (file) ->
	  try
	    @startUpload()  if @getStats().files_queued isnt 0
	  catch ex
	    @debug ex
	    
	uploadError : (file, errorCode, message) ->
	  try
	    switch errorCode
	      when SWFUpload.UPLOAD_ERROR.HTTP_ERROR
	        alert "上传错误" + message
	      when SWFUpload.UPLOAD_ERROR.MISSING_UPLOAD_URL
	        alert "配置错误"
	      when SWFUpload.UPLOAD_ERROR.UPLOAD_FAILED
	        alert "上传失败"
	      when SWFUpload.UPLOAD_ERROR.IO_ERROR
	        alert "服务器IO错误"
	      when SWFUpload.UPLOAD_ERROR.SECURITY_ERROR
	        alert "安全错误"
	      when SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED
	        alert "超出文件上传限制"
	      when SWFUpload.UPLOAD_ERROR.SPECIFIED_FILE_ID_NOT_FOUND
	        alert "文件未找到"
	      when SWFUpload.UPLOAD_ERROR.FILE_VALIDATION_FAILED
	        alert "文件验证失败"
	      when SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED
	        alert "文件上传终止"
	      else
	        alert "上传异常"
	  
	  #this.debug("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
	  catch ex
	    @debug ex	
