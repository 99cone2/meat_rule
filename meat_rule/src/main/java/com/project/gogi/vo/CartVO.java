package com.project.gogi.vo;

import java.util.Date;
import org.springframework.stereotype.Component;

@Component
public class CartVO {
	private String mem_id;
	private int goods_id;
	private int cart_no; //장바구니 번호
	private int cart_count;//장바구니 상품 개수
	private Date cart_time;
	private String delivery_option; //상품배송 옵션 
	
	public CartVO() {
		// TODO Auto-generated constructor stub
	}

	public CartVO(String mem_id, int goods_id, int cart_no, int cart_count, Date cart_time,String delivery_option) {
		super();
		this.mem_id = mem_id;
		this.goods_id = goods_id;
		this.cart_no = cart_no;
		this.cart_count = cart_count;
		this.cart_time = cart_time;
		this.delivery_option=delivery_option;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public int getGoods_id() {
		return goods_id;
	}

	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}

	public int getCart_no() {
		return cart_no;
	}

	public void setCart_no(int cart_no) {
		this.cart_no = cart_no;
	}

	public int getCart_count() {
		return cart_count;
	}

	public void setCart_count(int cart_count) {
		this.cart_count = cart_count;
	}

	public Date getCart_time() {
		return cart_time;
	}

	public void setCart_time(Date cart_time) {
		this.cart_time = cart_time;
	}

	public String getDelivery_option() {
		return delivery_option;
	}

	public void setDelivery_option(String delivery_option) {
		this.delivery_option = delivery_option;
	}

	@Override
	public String toString() {
		return "CartVO [mem_id=" + mem_id + ", goods_id=" + goods_id + ", cart_no=" + cart_no + ", cart_count="
				+ cart_count + ", cart_time=" + cart_time + ", delivery_option=" + delivery_option + "]";
	}
	
	
	
}
