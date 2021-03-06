package com.yezic.com.controller;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yezic.com.entity.Employee;
import com.yezic.com.entity.MilkTea;
import com.yezic.com.entity.MilkTeaClassification;
import com.yezic.com.entity.MilkTeaTaste;
import com.yezic.com.entity.Order;
import com.yezic.com.entity.OrderItem;
import com.yezic.com.service.MilkTeaClassificationService;
import com.yezic.com.service.MilkTeaService;
import com.yezic.com.service.MilkTeaTasteService;
import com.yezic.com.service.OrderService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("sales")
public class SalesController extends BaseController {

	@Resource
	private MilkTeaService  milkTeaService;
	
	@Resource
	private MilkTeaClassificationService  milkClaService;
	
	@Resource 
	private MilkTeaTasteService milkTeaTasteService;
	
	@Resource
	private OrderService orderService;
	
	@RequestMapping("list")
	public void list(Model model) {
		List<Order> orders = orderService.getAll(new Order());
		model.addAttribute("orders", orders);
	}
	
	@RequestMapping("cashier")
	public void cashier(Model model) {
		List<MilkTea> milkTeas = milkTeaService.getAll(new MilkTea());
		model.addAttribute("milkTeas", milkTeas);
		
		List<MilkTeaClassification> milkClas = milkClaService.getAll(new MilkTeaClassification());
		model.addAttribute("milkClas", milkClas);
		
		List<MilkTeaTaste> milkTeaTastes = milkTeaTasteService.getAll(new MilkTeaTaste());
		model.addAttribute("milkTeaTastes", milkTeaTastes);
	}
	
	/**
	 * 生成流水号
	 * 
	 * @throws Exception
	 */
	public synchronized String generateOrderNo() throws Exception {
		Thread.sleep(100);
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
				"yyMMddhhmmss");
		String timestr = simpleDateFormat.format(new Date());
		String asnNoPrefix = "88" + timestr;

		int max = 999;
		int min = 0;
		Random random = new Random();
		int num = random.nextInt(max) % (max - min + 1) + min;

		DecimalFormat decimalFormat = new DecimalFormat("000");
		asnNoPrefix += decimalFormat.format(num);

		max = 99;
		min = 0;
		random = new Random();
		num = random.nextInt(max) % (max - min + 1) + min;

		decimalFormat = new DecimalFormat("00");
		asnNoPrefix += decimalFormat.format(num);
		return asnNoPrefix;
	}
	
	@RequestMapping(value="doCashier",method =RequestMethod.POST)
	public void cashier(String content,String orderNumber,String amount,String exchange,String actualPay,String paymentway,ServletRequest request) throws Exception{
		Order order = new Order();
		order.setOrderNumber(generateOrderNo());
		order.setAmount(new BigDecimal(amount));
		order.setExchange(new BigDecimal(exchange));
		order.setActulPay(new BigDecimal(actualPay));
		order.setPaymentway(paymentway);
		order.setCreateTime(new Date());
		JSONArray  orderItems = JSONArray.fromObject(content);
		for (Object object : orderItems) {
			OrderItem orderItem = new OrderItem();
			JSONObject jsonOb = (JSONObject)object;
			orderItem.setImagePath(jsonOb.getString("image"));
			orderItem.setGoodsName(jsonOb.getString("name"));
			orderItem.setUnitPrice(new BigDecimal(jsonOb.getString("unitPrice")));
			orderItem.setUnit(jsonOb.getString("unit"));
			orderItem.setAddition(jsonOb.getString("addition"));
			orderItem.setTaste(jsonOb.getString("taste"));
			orderItem.setCount(jsonOb.getInt("count"));
			order.addOrderItem(orderItem);
		}
		
		Session session = SecurityUtils.getSubject().getSession();
		Employee employ = (Employee) session.getAttribute("employ");
		order.setSalesMan(employ.getName());
		order.setCount(orderItems.size());
		order.setStoreName("宝华门店");
		orderService.insert(order);
	}
}
