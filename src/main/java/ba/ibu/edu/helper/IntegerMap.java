package ba.ibu.edu.helper;

public class IntegerMap {

	public int value;
	public int key;

	public int getValue() {
		return value;
	}

	public void setValue(int value) {
		this.value = value;
	}

	public int getKey() {
		return key;
	}

	public void setKey(int key) {
		this.key = key;
	}

	public IntegerMap(int value, int key) {
		super();
		this.value = value;
		this.key = key;
	}

}
