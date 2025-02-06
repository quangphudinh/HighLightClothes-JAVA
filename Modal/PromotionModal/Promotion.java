package PromotionModal;

import java.sql.Date;

public class Promotion {
	private int PromotionID;
	private String Name;
	private Double Discount;
	private Date StartDay;
	private Date EndDay;
	
	public Promotion(int promotionID, String name, Double discount, Date startDay, Date endDay) {
		super();
		PromotionID = promotionID;
		Name = name;
		Discount = discount;
		StartDay = startDay;
		EndDay = endDay;
	}
	public Promotion() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getPromotionID() {
		return PromotionID;
	}
	public void setPromotionID(int promotionID) {
		PromotionID = promotionID;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public Double getDiscount() {
		return Discount;
	}
	public void setDiscount(Double discount) {
		Discount = discount;
	}
	public Date getStartDay() {
		return StartDay;
	}
	public void setStartDay(Date startDay) {
		StartDay = startDay;
	}
	public Date getEndDay() {
		return EndDay;
	}
	public void setEndDay(Date endDay) {
		EndDay = endDay;
	}
	
}
