<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width initial-scale=1">
	<title>Anonymous Chat</title>
	 <link href="images/chatFavicon.ico" rel="shortcut icon">
	<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="/resources/css/font-awesome.min.css" rel="stylesheet">
	<link href="/resources/css/custom.css" rel="stylesheet">
	
	<script src="/resources/js/jquery-3.3.1.min.js"></script>
	<script src="/resources/js/bootstrap.min.js"></script>
	<script src="/resources/js/chat.js"></script>
</head>
<body>
	<div class="container bootstrap snippets">
	  <div class="row">
        <div class="col-xs-12">
            <div class="portlet portlet-default">
                <div class="portlet-heading">
                    <div class="portlet-title">
                        <h4>실시간 채팅방</h4>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div id="chat" class="panel-collapse collapse in">
                   <div class="portlet-body chat-widget" style="overflow-y: auto; width: auto; height: 400px;">
                   		<div class="chatBox">
	                       <!--  <div class="row">
	                            <div class="col-lg-12">
	                                <div class="media">
	                                    <a class="pull-left" href="#">
	                                        <img class="media-object img-circle img-chat" src="images/tbz.png" alt="">
	                                    </a>
	                                    <div class="media-body">
	                                        <h4 class="media-heading">YH0808
	                                            <span class="small pull-right">오전 16:23</span>
	                                        </h4>
	                                        <p>안녕하세요</p>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
                        <hr> -->
                       </div>                          
                    </div>
                   <div class="portlet-footer">
                   		<form name="chatForm" id="chatForm">
	                    	<div class="row">
	                    		<div class="form-group col-xs-4">
	                    			<input style="height: 40px;" type="text" id="chatName" name="chatName"class="form-control" placeholder="이름" maxlength="20">
	                    		</div> 
	                    	</div>
	                    	<div class="row" style="height: 90px;">
	                    		<div class="form-group col-xs-10">
	                    			<textarea style="height:80px;" id="chatContent" name="chatContent" class="form-control" placeholder="메시지를 입력하세요" maxlength="100"></textarea>
	                    		</div>
	                    		<div class="form-group col-xs-2">
	                    			<input type="button" class="btn btn-default pull-right" id="RegisterBtn" value="전송">
	                    			<div class="clearfix"></div>
	                    		</div>
	                    	</div>
	                    </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.col-md-4 -->
    </div>
    <!-- alert -->
	    <div class="alert alert-success" id="successMessage" style="display:none;">
			<strong>메시지 전송에 성공했습니다</strong>
		</div>
		<div class="alert alert-danger" id="dangerMessage" style="display:none;">
			<strong>이름과 내용을 모두 입력하세요</strong>
		</div>
		<div class="alert alert-warning" id="warningMessage" style="display:none;">
			<strong>데이터베이스 오류</strong>
		</div>
	<!-- alert end-->
</div>
	
</body>

<script>
function autoClosingAlert(selector, delay){
	var alert = $(selector).alert();
	alert.show();
	window.setTimeout(function() {alert.hide()}, delay);
}
</script>

<script>
$(function(){
	   //최근 3개 채팅 조회
		var chatUL = $(".chatBox");
	   
		showRecentChat();
	    
	    function showRecentChat(){
	        chatService.getRecentList( function(list){
	        	
	           var str = "";
	           
	           if(list == null || list.length==0){
	              chatUL.html(str);
	              return;
	           }//if문
	           for(var i=0, len=list.length || 0; i<len; i++){
	              str += '<div class="row" id="'+list[i].chatId+'">';
	              str += '<div class="col-lg-12">';
	              str += '<div class="media">';
	              str += '<a class="pull-left" href="#">';
	              str += '<img class="media-object img-circle img-chat" src="images/tbz.png" alt="">';
	              str += '</a>';
	              str += '<div class="media-body">';
	              str += '<h4 class="media-heading">'+list[i].chatName;
	              str += '<span class="small pull-right">'+list[i].chatTime+'</span>';
	              str += '</h4>';
	              str +=  '<p>'+list[i].chatContent+'</p></div></div></div></div><hr>';
	           }//for문

	           chatUL.html(str);
	           $(".chat-widget").scrollTop(400);
	         
	        });
	     }//showRecentChat()
	
       //등록 insert
       $("#RegisterBtn").on("click", function(e){
			var chatName = $('#chatForm [name="chatName"]').val();
			var chatContent = $('#chatForm [name="chatContent"]').val();
    	  
			if(chatName == "" || chatContent == ""){
				autoClosingAlert("#dangerMessage", 2000);
			}else{
				 var chat = {
		    			   chatName:chatName,
		    			   chatContent:chatContent
		    	    		}
				  chatService.add(chat, function(result){
		    		   if(result == "success"){
							autoClosingAlert('#successMessage', 2000);
						} else {
							autoClosingAlert('#warningMessage', 2000);
						}
		    	   })
		    	$("#chatContent").val("");
			}
			//showChat();
       })
     
       
       //실시간 채팅 조회
	   var intervalId = window.setInterval(function showChat(){
    	   var chatId = $(".chatBox").children().first(".row").attr('id');
           //alert(chatId);
           
	       chatService.getChat(chatId, function(result){
	        	
	           var str = "";
	           
	           if(result == null || result.length==0){
	              chatUL.html(str);
	              return;
	           }//if문
	           for(var i=0, len=result.length || 0; i<len; i++){
	              str += '<div class="row" id="'+result[i].chatId+'">';
	              str += '<div class="col-lg-12">';
	              str += '<div class="media">';
	              str += '<a class="pull-left" href="#">';
	              str += '<img class="media-object img-circle img-chat" src="images/tbz.png" alt="">';
	              str += '</a>';
	              str += '<div class="media-body">';
	              str += '<h4 class="media-heading">'+result[i].chatName;
	              str += '<span class="small pull-right">'+result[i].chatTime+'</span>';
	              str += '</h4>';
	              str +=  '<p>'+result[i].chatContent+'</p></div></div></div></div><hr>';
	           }//for문

	           chatUL.html(str);
	           $(".chat-widget").scrollTop(500);
	           
	        });
	     }, 1000);
       
});
</script>
</html>