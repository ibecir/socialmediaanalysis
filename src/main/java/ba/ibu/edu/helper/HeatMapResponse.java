package ba.ibu.edu.helper;

public class HeatMapResponse {
	public int day;
	public int hour;
	public int occurences;

	public HeatMapResponse(int day, int hour, int occurences) {
		super();
		this.day = day;
		this.hour = hour;
		this.occurences = occurences;
	}

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public int getHour() {
		return hour;
	}

	public void setHour(int hour) {
		this.hour = hour;
	}

	public int getOccurences() {
		return occurences;
	}

	public void setOccurences(int occurences) {
		this.occurences = occurences;
	}

}
