package ba.ibu.edu.model;

import org.springframework.data.annotation.Id;

public class Synonym {

	@Id
	public String synonymId;
	public String synonymName;
	public int synonymStatus;

	public Synonym() {
	}

	public Synonym(String synonymId, String synonymName, int synonymStatus) {
		super();
		this.synonymId = synonymId;
		this.synonymName = synonymName;
		this.synonymStatus = synonymStatus;
	}

	public String getSynonymId() {
		return synonymId;
	}

	public void setSynonymId(String synonymId) {
		this.synonymId = synonymId;
	}

	public String getSynonymName() {
		return synonymName;
	}

	public void setSynonymName(String synonymName) {
		this.synonymName = synonymName;
	}

	public int getSynonymStatus() {
		return synonymStatus;
	}

	public void setSynonymStatus(int synonymStatus) {
		this.synonymStatus = synonymStatus;
	}

	@Override
	public String toString() {
		return String.format("SynonymId is # %s # and synonymName is # %s # and synonymStatus is # %d #. End of OBJ #",
				synonymId, synonymName, synonymStatus);

	}

}
