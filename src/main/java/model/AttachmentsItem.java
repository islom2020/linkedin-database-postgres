package model;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.gson.annotations.SerializedName;

public class AttachmentsItem{

	@JsonProperty(value = "content_type")
	private String contentType;

	@JsonProperty(value = "name")
	private String name;

	@JsonProperty(value = "id")
	private String id;

	@JsonProperty(value = "content")
	private String content;
}