package ba.ibu.edu.helper;

public class StringIntMap {

	public String category;
	public int occurences;

	public StringIntMap(String category, int occurences) {
		super();
		this.category = category;
		this.occurences = occurences;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getOccurences() {
		return occurences;
	}

	public void setOccurences(int occurences) {
		this.occurences = occurences;
	}

}
