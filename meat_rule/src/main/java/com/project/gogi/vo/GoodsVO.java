package com.project.gogi.vo;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component("goodsVO")
public class GoodsVO {
	/*0713 오동림 0714 오동림 수정*/
	
    private int goods_id;
    private String goods_sort; 
    private String goods_name;
    private String goods_seller; 
    private String goods_country; 
    private int goods_price;
    private int goods_sales_price;
    private int goods_point;
    private Date goods_delivery_date; 
    private String goods_intro;
    private String goods_status; // 상품분류(B: 베스트상품 / S: 세일상품 / N: 기본상품)
    private int goods_weight;
    private String file_name; //이미지파일 이름 저장하기 위한 객체

	public GoodsVO() {}

	public GoodsVO(int goods_id, String goods_sort, String goods_name, String goods_seller, String goods_country,
			int goods_price, int goods_sales_price, int goods_point, Date goods_delivery_date, String goods_intro, 
			String goods_status, String file_name,int goods_weight) {
		super();
		this.goods_id = goods_id;
		this.goods_sort = goods_sort;
		this.goods_name = goods_name;
		this.goods_seller = goods_seller;
		this.goods_country = goods_country;
		this.goods_price = goods_price;
		this.goods_sales_price = goods_sales_price;
		this.goods_point = goods_point;
		this.goods_delivery_date = goods_delivery_date;
		this.goods_intro = goods_intro;
		this.goods_status = goods_status;
		this.file_name = file_name;
		this.goods_weight=goods_weight;
	}


	public int getGoods_id() {
		return goods_id;
	}


	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}


	public String getGoods_sort() {
		return goods_sort;
	}


	public void setGoods_sort(String goods_sort) {
		this.goods_sort = goods_sort;
	}


	public String getGoods_name() {
		return goods_name;
	}


	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}


	public String getGoods_seller() {
		return goods_seller;
	}


	public void setGoods_seller(String goods_seller) {
		this.goods_seller = goods_seller;
	}


	public String getGoods_country() {
		return goods_country;
	}


	public void setGoods_country(String goods_country) {
		this.goods_country = goods_country;
	}


	public int getGoods_price() {
		return goods_price;
	}


	public void setGoods_price(int goods_price) {
		this.goods_price = goods_price;
	}


	public int getGoods_point() {
		return goods_point;
	}


	public void setGoods_point(int goods_point) {
		this.goods_point = goods_point;
	}


	public Date getGoods_delivery_date() {
		return goods_delivery_date;
	}


	public void setGood_delivery_date(Date goods_delivery_date) {
		this.goods_delivery_date = goods_delivery_date;
	}


	public String getGoods_intro() {
		return goods_intro;
	}


	public void setGoods_intro(String goods_intro) {
		this.goods_intro = goods_intro;
	}


	public String getGoods_status() {
		return goods_status;
	}


	public void setGoods_status(String goods_status) {
		this.goods_status = goods_status;
	}


	public String getFile_name() {
		return file_name;
	}


	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}


	public int getGoods_sales_price() {
		return goods_sales_price;
	}


	public void setGoods_sales_price(int goods_sales_price) {
		this.goods_sales_price = goods_sales_price;
	}


	public int getGoods_weight() {
		return goods_weight;
	}


	public void setGoods_weight(int goods_weight) {
		this.goods_weight = goods_weight;
	}
	
}
