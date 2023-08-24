package com.project.gogi.vo;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component("orderVO")
public class OrderVO {
	private int order_seq_num; // 주문일련번호
	private int order_id; //주문번호 
	//ex) 한 주문자가 5개 상품 주문하면 주문번호는 1개, 주문일련번호는 5개
	private String mem_id;
	private int goods_id;
	private String mem_name;//주문자 이름
	private String goods_name;//상품이름
	private int order_quantity; //최종 주문  제품 수
	private int goods_sales_price;//최종판매가격
	private String file_name;//상품 이미지 파일 이름
	private String order_rec_name;//수령자 이름
	/*private int cart_goods_qty; //장바구니에 담긴 제품 수*/
	private String order_rec_hp1;
	private String order_rec_hp2;
	private String order_rec_hp3;
	private String order_rec_tel1;
	private String order_rec_tel2;
	private String order_rec_tel3;	
	private String order_delivery_address;
	private String order_delivery_method;
	private String order_delivery_message;
	private String order_delivery_option; //배송옵션-캠핑장배송 or 일반배송	
	private String order_delivery_status;  //현재 주문 상품 배송 상태
	private String order_pay_method; //결제방법
	private String card_company_name;
	private String card_pay_month;
	private String pay_orderer_hp_num; //주문자 휴대폰 번호
	private String order_pay_hp_payment_num;//휴대폰 결제 전화번호
	private Date order_time;
	private String order_deli_hope_date;
	private int final_total_price;
	private int use_point;
	
	public OrderVO() {
		// TODO Auto-generated constructor stub
	} 
	
	public OrderVO(int order_seq_num, int order_id, String mem_id, int goods_id, String mem_name, String goods_name,
			int order_quantity, int goods_sales_price, String file_name, String order_rec_name, String order_rec_hp1,
			String order_rec_hp2, String order_rec_hp3, String order_rec_tel1, String order_rec_tel2,
			String order_rec_tel3, String order_delivery_address, String order_delivery_method,
			String order_delivery_message, String order_delivery_option, String order_delivery_status,
			String order_pay_method, String card_company_name, String card_pay_month, String pay_orderer_hp_num,
			String order_pay_hp_payment_num, Date order_time, String order_deli_hope_date, int final_total_price,int use_point) {
		super();
		this.order_seq_num = order_seq_num;
		this.order_id = order_id;
		this.mem_id = mem_id;
		this.goods_id = goods_id;
		this.mem_name = mem_name;
		this.goods_name = goods_name;
		this.order_quantity = order_quantity;
		this.goods_sales_price = goods_sales_price;
		this.file_name = file_name;
		this.order_rec_name = order_rec_name;
		this.order_rec_hp1 = order_rec_hp1;
		this.order_rec_hp2 = order_rec_hp2;
		this.order_rec_hp3 = order_rec_hp3;
		this.order_rec_tel1 = order_rec_tel1;
		this.order_rec_tel2 = order_rec_tel2;
		this.order_rec_tel3 = order_rec_tel3;
		this.order_delivery_address = order_delivery_address;
		this.order_delivery_method = order_delivery_method;
		this.order_delivery_message = order_delivery_message;
		this.order_delivery_option = order_delivery_option;
		this.order_delivery_status = order_delivery_status;
		this.order_pay_method = order_pay_method;
		this.card_company_name = card_company_name;
		this.card_pay_month = card_pay_month;
		this.pay_orderer_hp_num = pay_orderer_hp_num;
		this.order_pay_hp_payment_num = order_pay_hp_payment_num;
		this.order_time = order_time;
		this.order_deli_hope_date=order_deli_hope_date;
		this.final_total_price=final_total_price;
		this.use_point=use_point;
	}
	public int getOrder_seq_num() {
		return order_seq_num;
	}
	public void setOrder_seq_num(int order_seq_num) {
		this.order_seq_num = order_seq_num;
	}
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
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
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getGoods_name() {
		return goods_name;
	}
	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}
	public int getOrder_quantity() {
		return order_quantity;
	}
	public void setOrder_quantity(int order_quantity) {
		this.order_quantity = order_quantity;
	}
	public int getGoods_sales_price() {
		return goods_sales_price;
	}
	public void setGoods_sales_price(int goods_sales_price) {
		this.goods_sales_price = goods_sales_price;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getOrder_rec_name() {
		return order_rec_name;
	}
	public void setOrder_rec_name(String order_rec_name) {
		this.order_rec_name = order_rec_name;
	}
	public String getOrder_rec_hp1() {
		return order_rec_hp1;
	}
	public void setOrder_rec_hp1(String order_rec_hp1) {
		this.order_rec_hp1 = order_rec_hp1;
	}
	public String getOrder_rec_hp2() {
		return order_rec_hp2;
	}
	public void setOrder_rec_hp2(String order_rec_hp2) {
		this.order_rec_hp2 = order_rec_hp2;
	}
	public String getOrder_rec_hp3() {
		return order_rec_hp3;
	}
	public void setOrder_rec_hp3(String order_rec_hp3) {
		this.order_rec_hp3 = order_rec_hp3;
	}
	public String getOrder_rec_tel1() {
		return order_rec_tel1;
	}
	public void setOrder_rec_tel1(String order_rec_tel1) {
		this.order_rec_tel1 = order_rec_tel1;
	}
	public String getOrder_rec_tel2() {
		return order_rec_tel2;
	}
	public void setOrder_rec_tel2(String order_rec_tel2) {
		this.order_rec_tel2 = order_rec_tel2;
	}
	public String getOrder_rec_tel3() {
		return order_rec_tel3;
	}
	public void setOrder_rec_tel3(String order_rec_tel3) {
		this.order_rec_tel3 = order_rec_tel3;
	}
	public String getOrder_delivery_address() {
		return order_delivery_address;
	}
	public void setOrder_delivery_address(String order_delivery_address) {
		this.order_delivery_address = order_delivery_address;
	}
	public String getOrder_delivery_method() {
		return order_delivery_method;
	}
	public void setOrder_delivery_method(String order_delivery_method) {
		this.order_delivery_method = order_delivery_method;
	}
	public String getOrder_delivery_message() {
		return order_delivery_message;
	}
	public void setOrder_delivery_message(String order_delivery_message) {
		this.order_delivery_message = order_delivery_message;
	}
	public String getOrder_delivery_option() {
		return order_delivery_option;
	}
	public void setOrder_delivery_option(String order_delivery_option) {
		this.order_delivery_option = order_delivery_option;
	}
	public String getOrder_delivery_status() {
		return order_delivery_status;
	}
	public void setOrder_delivery_status(String order_delivery_status) {
		this.order_delivery_status = order_delivery_status;
	}
	public String getOrder_pay_method() {
		return order_pay_method;
	}
	public void setOrder_pay_method(String order_pay_method) {
		this.order_pay_method = order_pay_method;
	}
	public String getCard_company_name() {
		return card_company_name;
	}
	public void setCard_company_name(String card_company_name) {
		this.card_company_name = card_company_name;
	}
	public String getCard_pay_month() {
		return card_pay_month;
	}
	public void setCard_pay_month(String card_pay_month) {
		this.card_pay_month = card_pay_month;
	}
	public String getPay_orderer_hp_num() {
		return pay_orderer_hp_num;
	}
	public void setPay_orderer_hp_num(String pay_orderer_hp_num) {
		this.pay_orderer_hp_num = pay_orderer_hp_num;
	}
	public String getOrder_pay_hp_payment_num() {
		return order_pay_hp_payment_num;
	}
	public void setOrder_pay_hp_payment_num(String order_pay_hp_payment_num) {
		this.order_pay_hp_payment_num = order_pay_hp_payment_num;
	}
	public Date getOrder_time() {
		return order_time;
	}
	public void setOrder_time(Date order_time) {
		this.order_time = order_time;
	}
	
	
	public String getOrder_deli_hope_date() {
		return order_deli_hope_date;
	}

	public void setOrder_deli_hope_date(String order_deli_hope_date) {
		this.order_deli_hope_date = order_deli_hope_date;
	}
	
	

	public int getFinal_total_price() {
		return final_total_price;
	}

	public void setFinal_total_price(int final_total_price) {
		this.final_total_price = final_total_price;
	}
	
	

	public int getUse_point() {
		return use_point;
	}

	public void setUse_point(int use_point) {
		this.use_point = use_point;
	}

	@Override
	public String toString() {
		return "OrderVO [order_seq_num=" + order_seq_num + ", order_id=" + order_id + ", mem_id=" + mem_id
				+ ", goods_id=" + goods_id + ", mem_name=" + mem_name + ", goods_name=" + goods_name
				+ ", order_quantity=" + order_quantity + ", goods_sales_price=" + goods_sales_price + ", file_name="
				+ file_name + ", order_rec_name=" + order_rec_name + ", order_rec_hp1=" + order_rec_hp1
				+ ", order_rec_hp2=" + order_rec_hp2 + ", order_rec_hp3=" + order_rec_hp3 + ", order_rec_tel1="
				+ order_rec_tel1 + ", order_rec_tel2=" + order_rec_tel2 + ", order_rec_tel3=" + order_rec_tel3
				+ ", order_delivery_address=" + order_delivery_address + ", order_delivery_method="
				+ order_delivery_method + ", order_delivery_message=" + order_delivery_message
				+ ", order_delivery_option=" + order_delivery_option + ", order_delivery_status="
				+ order_delivery_status + ", order_pay_method=" + order_pay_method + ", card_company_name="
				+ card_company_name + ", card_pay_month=" + card_pay_month + ", pay_orderer_hp_num="
				+ pay_orderer_hp_num + ", order_pay_hp_payment_num=" + order_pay_hp_payment_num + ", order_time="
				+ order_time + ", order_deli_hope_date=" + order_deli_hope_date + ", final_total_price="
				+ final_total_price + ", use_point=" + use_point + ", getOrder_seq_num()=" + getOrder_seq_num()
				+ ", getOrder_id()=" + getOrder_id() + ", getMem_id()=" + getMem_id() + ", getGoods_id()="
				+ getGoods_id() + ", getMem_name()=" + getMem_name() + ", getGoods_name()=" + getGoods_name()
				+ ", getOrder_quantity()=" + getOrder_quantity() + ", getGoods_sales_price()=" + getGoods_sales_price()
				+ ", getFile_name()=" + getFile_name() + ", getOrder_rec_name()=" + getOrder_rec_name()
				+ ", getOrder_rec_hp1()=" + getOrder_rec_hp1() + ", getOrder_rec_hp2()=" + getOrder_rec_hp2()
				+ ", getOrder_rec_hp3()=" + getOrder_rec_hp3() + ", getOrder_rec_tel1()=" + getOrder_rec_tel1()
				+ ", getOrder_rec_tel2()=" + getOrder_rec_tel2() + ", getOrder_rec_tel3()=" + getOrder_rec_tel3()
				+ ", getOrder_delivery_address()=" + getOrder_delivery_address() + ", getOrder_delivery_method()="
				+ getOrder_delivery_method() + ", getOrder_delivery_message()=" + getOrder_delivery_message()
				+ ", getOrder_delivery_option()=" + getOrder_delivery_option() + ", getOrder_delivery_status()="
				+ getOrder_delivery_status() + ", getOrder_pay_method()=" + getOrder_pay_method()
				+ ", getCard_company_name()=" + getCard_company_name() + ", getCard_pay_month()=" + getCard_pay_month()
				+ ", getPay_orderer_hp_num()=" + getPay_orderer_hp_num() + ", getOrder_pay_hp_payment_num()="
				+ getOrder_pay_hp_payment_num() + ", getOrder_time()=" + getOrder_time()
				+ ", getOrder_deli_hope_date()=" + getOrder_deli_hope_date() + ", getFinal_total_price()="
				+ getFinal_total_price() + ", getUse_point()=" + getUse_point() + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}



	




	
}
