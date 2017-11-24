package com.olts.commons;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 * 分页标签实现类，负责生成分页的超链接
 * 
 * @author James
 *
 */
public class PageTag extends SimpleTagSupport {
	
	//<p:page url="${'servlet/BookPageServlet'}" styleClass="cssClass" page="${bookPage}" displayStyle="icon"/>
	//分页信息控制对象
	private Page page = new Page(0);
	
	//类样式
	private String styleClass = "page";
	
	//分页显示的是图标还是文字方式
	private String displayStyle = "text";
	
	//分页请求URL
	private String url = "";

	/*
	 * <span id="page" style='margin:0px;padding:0px;' class='cssClassName'>
	 * 	共？页  每页？条  第？页/共？页     <a href="../pageServlet?pageNo=?">
	 * 
	 * </span>
	 * 
	 * @see javax.servlet.jsp.tagext.SimpleTagSupport#doTag()
	 */
	@Override
	public void doTag() throws JspException, IOException {
		StringBuffer buff = new StringBuffer("<span id='page' style='margin:0px;padding:0px;' class='" + this.styleClass + "'>");
		buff.append("共" + this.page.getTotalRow() + "条记录&nbsp;");
		buff.append("  每页" + this.page.getPageSize() + "条&nbsp;");
		buff.append("第" + (page.getTotalRow()==0?0:page.getPageNo()) + "页/共" + page.getTotalPage() + "页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
		
		//显示为文本方式
		if ("text".equalsIgnoreCase(this.displayStyle)) {
			//<a href='javascript:switchPage('${'book.do?method=findAll' }');
			buff.append((!page.getFirst()) ? "<a href=\"" + this.url + "&pageNo=1" + "\">第一页</a>" : "第一页");
			buff.append(page.getPrevious() ? "&nbsp;&nbsp;<a href=\"" + this.url + "&pageNo="+(this.page.getPageNo()-1) + "\">上一页</a>" : "&nbsp;&nbsp;上一页");
			buff.append(page.getNext() ? "&nbsp;&nbsp;<a href=\"" + this.url + "&pageNo="+(this.page.getPageNo()+1) + "\">下一页</a>" : "&nbsp;&nbsp;下一页");
			buff.append(!page.getLast() ? "&nbsp;&nbsp;<a href=\"" + this.url + "&pageNo="+(this.page.getTotalPage()) + "\">最后一页</a>" : "&nbsp;&nbsp;最后一页");
			
		}else{//显示为图标方式
			buff.append((!page.getFirst()) ? "<a href='" + this.url + "&pageNo=1" + "'><img src='images/icon/firstPage.gif' title='第一页'/></a>" : "&nbsp;&nbsp;<img src='images/icon/firstPageDisabled.gif' title='无第一页'/>");
			buff.append(page.getPrevious() ? "&nbsp;<a href='" + this.url + "&pageNo="+(this.page.getPageNo()-1) + "'><img src='images/icon/prevPage.gif' title='上一页'/></a>" : "&nbsp;&nbsp;<img src='images/icon/nextPageDisabled.gif' title='无下一页'/>");
			buff.append(page.getNext() ? "&nbsp;<a href='" + this.url + "&pageNo="+(this.page.getPageNo()+1) + "'><img src='images/icon/nextPage.gif' title='下一页'/></a>" : "&nbsp;&nbsp;<img src='images/icon/nextPageDisabled.gif' title='无下一页'/>");
			buff.append(!page.getLast() ? "&nbsp;<a href='" + this.url + "&pageNo="+(this.page.getTotalPage()) + "'><img src='images/icon/lastPage.gif' title='最后一页'/></a>" : "&nbsp;&nbsp;<img src='images/icon/lastPageDisabled.gif' title='无最后一页'/>");
		}
		buff.append("</span>");
		
		JspWriter out = getJspContext().getOut();
		out.write(buff.toString());
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getStyleClass() {
		return styleClass;
	}

	public void setStyleClass(String styleClass) {
		this.styleClass = styleClass;
	}

	public String getDisplayStyle() {
		return displayStyle;
	}

	public void setDisplayStyle(String displayStyle) {
		this.displayStyle = displayStyle;
	}
}
