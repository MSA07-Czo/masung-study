package com.czo.masung.page;

import java.net.URLEncoder;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Positive;

import lombok.Builder;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Data
@Builder
public class PageRequestDTO {
	@Min(value = 1)
	@Positive
	@Builder.Default
	private int page = 1; 

	@Min(value = 10)
	@Max(value = 100)
	@Builder.Default
	private int size = 10; 

	private String [] types;
	private String keyword;
	private String from;
	private String to;

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

		if (types != null && types.length > 0) {
			for (String type : types) {
				builder.append("&types=" + type);
			}
		}

		if (keyword != null && keyword.length() > 0) {
			try {
				//keyword = "value=10&key=20"
				builder.append("&keyword=" + URLEncoder.encode(keyword, "UTF-8"));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if (from != null) {
			builder.append("&from=" + from.toString());
		}

		if (to != null) {
			builder.append("&to=" + to.toString());
		}

		log.info("getParam-> " + builder.toString());
		return builder.toString();
	}


}
