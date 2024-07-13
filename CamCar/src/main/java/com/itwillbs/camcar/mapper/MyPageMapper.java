package com.itwillbs.camcar.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.camcar.vo.DriverVO;
import com.itwillbs.camcar.vo.MemberVO;

@Mapper
public interface MyPageMapper {
	

	// 회원상세 정보 조회
	MemberVO selectMember(MemberVO member);
	
	
	// 운전자 정보 조회
	DriverVO selectDriver(
			@Param("driver") DriverVO driver,
			@Param("id") String id);
	
	// 회원 정보 수정
	int updateMember(Map<String, String> map);
	
	// 회원 탈퇴
	int updateWithdrawMember(MemberVO member);
}
