package ba.ibu.edu.model;

import java.util.List;

import org.springframework.data.annotation.Id;

public class Keyword {

	@Id
	public String keywordId;
	public String keywordName;
	public int keywordStatus;
	public List<Synonym> synonyms;

	public Keyword() {
	}

	public Keyword(String keywordId, String keywordName, int keywordStatus) {
		super();
		this.keywordId = keywordId;
		this.keywordName = keywordName;
		this.keywordStatus = keywordStatus;
	}

	public Keyword(String keywordId, String keywordName, int keywordStatus, List<Synonym> synonyms) {
		super();
		this.keywordId = keywordId;
		this.keywordName = keywordName;
		this.keywordStatus = keywordStatus;
		this.synonyms = synonyms;
	}

	public String getKeywordId() {
		return keywordId;
	}

	public void setKeywordId(String keywordId) {
		this.keywordId = keywordId;
	}

	public String getKeywordName() {
		return keywordName;
	}

	public void setKeywordName(String keywordName) {
		this.keywordName = keywordName;
	}

	public int getKeywordStatus() {
		return keywordStatus;
	}

	public void setKeywordStatus(int keywordStatus) {
		this.keywordStatus = keywordStatus;
	}

	public List<Synonym> getSynonyms() {
		return synonyms;
	}

	public void setSynonyms(List<Synonym> synonyms) {
		this.synonyms = synonyms;
	}

}
