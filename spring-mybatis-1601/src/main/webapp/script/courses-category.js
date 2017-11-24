$(function(){
	//初始化课程下拉列表
	$.get("courses/selectAllCourses.do",function(jsonList){
		var co = $("#courses");
		
		$.each(jsonList, function(i,c){
			co.append("<option value='" +c.id+ "'>" + c.courseName + "</option>");
		});
		$("#courses option").each(function(){
			if($(this).attr("value")==$("#cId").attr("value")){
				$(this).attr({selected:"selected"});
				
				var id= $("#cId").attr("value");
				var ca = $("#category");
				ca.empty();
				$.get("category/selectAllCategory.do",{"courseId": id}, function(jsonList){
					$.each(jsonList, function(i,category){
						ca.append("<option value='" +category.id+ "'>" + category.techCtgr + "</option>");
					});
					$("#category option").each(function(){
						if($(this).attr("value")==$("#tcId").attr("value")){
							$(this).attr({selected:"selected"});
						}
					});
				},"json");
			}
		});
	},"json");
	
	$("#courses").change(function(){
		var courses = $(this).val();
		
		var ca = $("#category");
		ca.empty();
		$.get("category/selectAllCategory.do",{"courseId": courses}, function(jsonList){
			$.each(jsonList, function(i,category){
				ca.append("<option value='" +category.id+ "'>" + category.techCtgr + "</option>");
			});
		},"json");
		
	});
	
});

