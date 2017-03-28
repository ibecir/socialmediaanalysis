package ba.ibu.edu.model;

public class DateAggregation {
	public int year;
	public int month;
	public int day;
	public int count;

	public DateAggregation(int year, int month, int day, int count) {
		super();
		this.year = year;
		this.month = month;
		this.day = day;
		this.count = count;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

}
