  //获取项目下拉框
  var btsloader = function(param,success,error){
      //获取输入的值
      var q = param.q || "";
      //此处q的length代表输入多少个字符后开始查询
      //if(q.length <= 0) return false;
      $.ajax({
          url:path+"checkData/projectShow.do",
          //type:"post",
          data:{
        	 //传值，还是JSON数据
             project:q
          },
      
	      //重要，如果写jsonp会报转换错误，此处不写都可以
	      dataType:"json",
	      success:function(data){
		      //关键步骤，遍历一个List对象
		      var items = $.each(data,function(index,value){
		          return {
		          PROJECTID:value.PROJECTID,
		          PROJECTNAME:value.PROJECTNAME
		          };
		      });
      
	      //执行loader的success方法
	      success(items);
	      },
	      //异常处理
	      error:function(xml, text, msg){
	    	  error.apply(this, arguments);
	      }
	    });
   };

    //选中项目下拉框后，触发城市下拉框
	function selectCity(){
	        var project = $('#project').combobox('getValue');
	        $('#city').combobox({
	            url:path+'checkData/cityShow.do?projectId='+project,
	            valueField:'CITYID' , 
	            textField:'CITYNAME',
	        });
	}