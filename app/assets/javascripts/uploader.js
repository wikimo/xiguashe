
/* This is an example of how to cancel all the files queued up.  It's made somewhat generic.  Just pass your SWFUpload
 object in to this method and it loops through cancelling the uploads. */
// function cancelQueue(instance) {
// 	document.getElementById(instance.customSettings.cancelButtonId).disabled = true;
// 	instance.stopUpload();
// 	var stats;

// 	do {
// 		stats = instance.getStats();
// 		instance.cancelUpload();
// 	} while (stats.files_queued !== 0);

// }

/* **********************
 Event Handlers
 These are my custom event handlers to make my
 web application behave the way I went when SWFUpload
 completes different tasks.  These aren't part of the SWFUpload
 package.  They are part of my application.  Without these none
 of the actions SWFUpload makes will show up in my application.
 ********************** */
function fileDialogStart() {
    /* I don't need to do anything here */
}


function fileQueued(file) {
    try {
        // You might include code here that prevents the form from being submitted while the upload is in
        // progress.  Then you'll want to put code in the Queue Complete handler to "unblock" the form
    } catch (ex) {
        this.debug(ex);
    }

}

function fileQueueError(file, errorCode, message) {
    try {

        switch (errorCode) {
            case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
                alert("文件大小超过允许范围.");
                break;
            case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
                alert("不允许上传空文件.");
                break;
            case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
                alert("上传文件类型错误.");
                break;
            case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
                alert("超出上传允许文件数.  " +  (message > 1 ? "只能上传 " +  message + " 个文件" : "无法上传额外文件."));
                break;
            default:
                if (file !== null) {
                    alert('上传异常！');
                }
                break;
        }
    } catch (ex) {
        this.debug(ex);
    }
}

function fileDialogComplete(numFilesSelected, numFilesQueued) {
    try {
        this.startUpload();
    } catch (ex)  {
        this.debug(ex);
    }
}

function uploadStart(file) {
    try {
        /* I don't want to do any file validation or anything,  I'll just update the UI and return true to indicate that the upload should start */
        //添加上传的图片
        var li = jQuery('<li></li>');

        var img = jQuery('<span class="up-img"></span>');
        var input = jQuery('<span class="up-descrip"><textarea  name=""/></textarea></span>');
        var opts = jQuery('<span class="up-opts"><em></em></span>');
        var fileList =  jQuery("#"+this.customSettings.fileList);

        li.append(img);
        li.append(input);
        li.append(opts);

        fileList.append(li);
    }
    catch (ex) {
    }

    return true;
}

function uploadProgress(file, bytesLoaded, bytesTotal) {

    try {
        var percent = Math.ceil((bytesLoaded / bytesTotal) * 100);

        var opts = jQuery('.up-opts').last();

        var progressBar =  jQuery('.up-opts > em').last();
        progressBar.css('width',percent+'%');

    } catch (ex) {
        this.debug(ex);
    }
}

function uploadSuccess(file, serverData) {
    try {
        //添加上传的图片
        var img = jQuery('<img src="'+serverData+'" alt="'+serverData+'"/>');
        var upImg =  jQuery(".up-img").last();

        upImg.append(img);

        var opts = jQuery('.up-opts').last();
        jQuery('.up-opts > em').last().remove();
        opts.append(jQuery(' <a href="">[插入]</a>  <a href="">[删除]</a>'));

    } catch (ex) {
        this.debug(ex);
    }
}


function uploadComplete(file) {
    try {
        if (this.getStats().files_queued !== 0) {
            this.startUpload();
        }
    } catch (ex) {
        this.debug(ex);
    }

}

function uploadError(file, errorCode, message) {
    try {
        switch (errorCode) {
            case SWFUpload.UPLOAD_ERROR.HTTP_ERROR:
                alert("上传错误"+ message);
                break;
            case SWFUpload.UPLOAD_ERROR.MISSING_UPLOAD_URL:
                alert("配置错误");
                break;
            case SWFUpload.UPLOAD_ERROR.UPLOAD_FAILED:
                alert("上传失败");
                break;
            case SWFUpload.UPLOAD_ERROR.IO_ERROR:
                alert("服务器IO错误");
                break;
            case SWFUpload.UPLOAD_ERROR.SECURITY_ERROR:
                alert("安全错误");
                break;
            case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
                alert("超出文件上传限制");
                break;
            case SWFUpload.UPLOAD_ERROR.SPECIFIED_FILE_ID_NOT_FOUND:
                alert("文件未找到");
                break;
            case SWFUpload.UPLOAD_ERROR.FILE_VALIDATION_FAILED:
                alert('文件验证失败');
                break;

            case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
                alert('文件上传终止');
                break;
            default:
                alert('上传异常');
                //this.debug("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
                break;
        }
    } catch (ex) {
        this.debug(ex);
    }
}