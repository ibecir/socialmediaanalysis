package ba.ibu.edu.helper;

import java.util.List;

@SuppressWarnings("rawtypes")
public class Serialize {

	// @JsonView(Views.Public.class)
	private List object;

	public List getElements() {
		return object;
	}

	public void setElements(List object) {
		this.object = object;
	}

}
