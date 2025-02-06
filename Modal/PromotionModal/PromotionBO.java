package PromotionModal;

import java.sql.Date;
import java.util.ArrayList;



public class PromotionBO {
	PromotionDAO prdao = new PromotionDAO();
	ArrayList<Promotion> ds;
	
	public ArrayList<Promotion> getPromtions() throws Exception{
		ds = prdao.getPromotions();
		return ds;
	}
	
	public ArrayList<Promotion> searchPromotions(String name , Date startDate ,Date endDate) throws Exception{
		ds = prdao.searchPromotions(name, startDate, endDate);
		return ds;
	}
	
	public ArrayList<Promotion> getAvailablePromotion() throws Exception{
		ds = prdao.getAvailablePromotion();
		return ds;
	}
	
	public int checkName(String name) throws Exception {
		return prdao.checkName(name);
	}
	
	public int addPromotion(String name , Double discount , Date startDate , Date endDate) throws Exception {
		return prdao.addPromotion(name, discount, startDate, endDate);
	}
	
	public int updatePromotion(int promotionID , String name , Double discount , Date startDate , Date endDate) throws Exception {
		return prdao.updatePromotion(promotionID, name, discount, startDate, endDate);
	}
	
	public Boolean deletePromotion(int promotionID) throws Exception{
		return prdao.deletePromotion(promotionID);
	}
	
	public int isUse(int promotionID) throws Exception{
		return prdao.IsUsePromotionInProducts(promotionID);
	}
	
}
