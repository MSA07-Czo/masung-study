package com.czo.masung.page;

import java.net.URLEncoder;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Positive;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PageRequestDTO {
	@Min(value = 1)
	@Positive
	@Builder.Default
	private int page = 1; 

	@Min(value = 10)
	@Max(value = 100)
	@Builder.Default
	private int size = 10; 

	//검색 옵션
	@Builder.Default
	private Boolean titleSearch = false;
	@Builder.Default
	private Boolean writerSearch = false;
	private String  keyword;
	private String  from;
	private String  to;

	public int getSkip() {
		return (page - 1) * size;
	}

	public String getLink()  {
		return getParam(this.page);
	}

	public String getParam(int page)  {
		StringBuilder builder = new StringBuilder();
		builder.append("page=" + page);
		builder.append("&size=" + size);
		
		if(titleSearch) {
			builder.append("&titleSearch=" + titleSearch);
		}
		
		if(writerSearch) {
			builder.append("&writerSearch=" + writerSearch);
		}

		if (keyword != null && keyword.length() > 0) {
			try {
				builder.append("&keyword=" + URLEncoder.encode(keyword, "UTF-8"));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if (from != null) {
			builder.append("&from=" + from);
		}

		if (to != null) {
			builder.append("&to=" + to);
		}

		log.info("getParam-> " + builder.toString());
		return builder.toString();
	}
}
