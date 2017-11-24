<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
//班马线效果
$(".data_list tr:odd").addClass("odd");
$(".data_list tr:even").addClass("even");

$(".data_list tr:odd").bind("mouseover",function(){
	if($(this).index()==0) return;
    $(this).addClass("highlight");
}); 
$(".data_list tr:odd").bind("mouseout",function(){
    $(this).removeClass("highlight");
    $(this).addClass("odd");
}); 

$(".data_list tr:even").bind("mouseover",function(){
	if($(this).index()==0) return;
    $(this).addClass("highlight");
}); 
$(".data_list tr:even").bind("mouseout",function(){
    $(this).removeClass("highlight");
    $(this).addClass("even");
});
</script>