var chatService = (function(){

      function add(chat, callback, error) {
         $.ajax({
               type : 'post',
               url : '/chats/new',
               data : JSON.stringify(chat), 
               contentType : 'application/json; charset=utf-8',
               success : function(result, status, xhr) {
	               if(callback) {
	                  callback(result);
	                 }
               },error : function(xhr, status, er) {
               if(error) {
                  error(er);
                  }
               }
            }) //ajax
         } //add
      
      function getRecentList(callback, error){
      	$.getJSON("/chats/", function(result) {
		
			if (callback) {
			callback(result);
			}
		
		}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
      }
      
       function getChat(chatId, callback, error) {

		$.get("/chats/" + chatId + ".json", function(result) {
		
			if (callback) {
			callback(result);
			}
		
		}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}
      
      

 	return {add:add, getRecentList:getRecentList, getChat:getChat};
   })();
