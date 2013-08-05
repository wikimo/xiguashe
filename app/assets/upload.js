 function fileQueueError(file, errorCode, message) {
    try {
      switch (errorCode) {
        case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
          return alert("文件大小超过允许范围.");
        case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
          return alert("不允许上传空文件.");
        case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
          return alert("上传文件类型错误.");
        case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
          return alert("超出上传允许文件数.  " + (message > 1 ? "只能上传 " + message + " 个文件" : "无法上传额外文件."));
        default:
          if (file !== null) {
            return alert("上传异常！");
          }
      }
    } catch (ex) {
      return this.debug(ex);
    }
}    