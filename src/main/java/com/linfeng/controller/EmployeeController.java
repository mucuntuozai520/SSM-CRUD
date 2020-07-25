package com.linfeng.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.linfeng.entity.Employee;
import com.linfeng.entity.Msg;
import com.linfeng.service.EmployeeService;

@Controller
public class EmployeeController {
	@Autowired
	EmployeeService employeeService;
	
	@ResponseBody
	@RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("ids") String ids) {
		if(ids.contains("-")) {
			List<Integer> del_ids=new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			for (String id : str_ids) {
				del_ids.add(Integer.parseInt(id));
			}
				employeeService.deleteBatch(del_ids);
			
		}else {
			int id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		return Msg.success();
	}
	
	@ResponseBody
	@RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
	public Msg saveEmp(Employee employee) {
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	@ResponseBody
	@RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employee employee=employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	@ResponseBody
	@RequestMapping("/checkuser") 
	public Msg checkuser(@RequestParam("empName") String empName) {
		String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})"; 
		if(!empName.matches(regx)) {//��̨У��,matches����
			return Msg.fail().add("vamsg", "�û���������2-5λ���Ļ���6-16λӢ�ĺ����ֵ����!");
		};
		boolean flag=employeeService.checkUser(empName);
		if(flag) {
			return Msg.success();
		}else {
			return Msg.fail().add("vamsg", "�û����Ѵ���");
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/emp",method = RequestMethod.POST)
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			List<FieldError> errors = result.getFieldErrors();
			Map<String,Object> map=new HashMap<String,Object>();
			for (FieldError fieldError : errors) {
				System.out.println("������ֶ���:"+fieldError.getField());
				System.out.println("�������Ϣ:"+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/emps",method = RequestMethod.GET)
	public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue ="1") Integer pn) {
		PageHelper.startPage(pn, 5);
		List<Employee> emps=employeeService.getall();
		PageInfo page=new PageInfo(emps,5);
		return Msg.success().add("PageInfo", page);
	}
	
	/*@RequestMapping("/emps")
	public ModelAndView getEmps(@RequestParam(value = "pn",defaultValue ="1") Integer pn) {
		PageHelper.startPage(pn, 5);//startPagen��������������ѯ����һ����ҳ��ѯ
		List<Employee> emps=employeeService.getall();
		//��pageinfo����ҳ�������,�����װ����ϸ�ķ�ҳ��Ϣ,�������ǲ�ѯ����������,����������ʾ��ҳ��
		PageInfo page=new PageInfo(emps,5);
		ModelAndView mv=new ModelAndView("list");
		mv.addObject("PageInfo", page);
		return mv;*/
	}
	
	

