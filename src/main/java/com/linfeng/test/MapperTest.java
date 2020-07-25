package com.linfeng.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.linfeng.dao.DepartmentMapper;
import com.linfeng.dao.EmployeeMapper;
import com.linfeng.entity.Department;
import com.linfeng.entity.Employee;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession session;
	@Test
	public void testCRUD() {
		//System.out.println(departmentMapper);
		//departmentMapper.insertSelective(new Department(null,"开发部"));
		//departmentMapper.insertSelective(new Department(null,"哈哈部"));
		//employeeMapper.insertSelective(new Employee(null,"Jerry","M","2534800363@qq.com",1));
		EmployeeMapper mapper = session.getMapper(EmployeeMapper.class);
		for(int i=0;i<1000;i++) {
			String uuid = UUID.randomUUID().toString().substring(0,5)+i;
			mapper.insertSelective(new Employee(null,uuid,"M",uuid+"@qingnian.com",1));
		}
		System.out.println("完毕");
	}
	
}
