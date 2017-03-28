package ba.ibu.edu.model;

public class Categorized {

	public String name;
	public int y;

	public Categorized(String name, int y) {
		super();
		this.name = name;
		this.y = y;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getY() {
		return y;
	}

	public void setY(int y) {
		this.y = y;
	}

}
