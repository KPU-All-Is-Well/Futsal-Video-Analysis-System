package count;

public class CounterBean{
	private int count;
	
	public CounterBean() {
		count = 0;
	}
	
	public void setNewVisit(String s) {
		count++;
	}
	
	public int getVisitCount() {
		return count;
	}
}