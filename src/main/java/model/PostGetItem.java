package model;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.gson.annotations.SerializedName;

public class PostGetItem{

	@JsonProperty(value = "attachments")
	private List<AttachmentsItem> attachments;

	@JsonProperty(value = "id")
	private String id;

	@JsonProperty(value = "title")
	private String title;
}