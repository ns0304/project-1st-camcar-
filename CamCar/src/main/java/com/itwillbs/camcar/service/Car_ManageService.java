package com.itwillbs.camcar.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.camcar.mapper.Car_ManageMapper;
import com.itwillbs.camcar.mapper.Member_ManageMapper;
import com.itwillbs.camcar.vo.BoardVO;
import com.itwillbs.camcar.vo.CarModelVO;
import com.itwillbs.camcar.vo.CarVO;
import com.itwillbs.camcar.vo.MemberVO;

@Service
public class Car_ManageService {
	@Autowired
	private Car_ManageMapper mapper;

	//차량 목록 조회 요청
	public List<CarVO> getCarList(String searchType, String searchKeyword, int startRow, int listLimit) {
		
		return mapper.selectCarList(searchType, searchKeyword, startRow, listLimit);
	}
	
	//차량 총 갯수 조회 요청
	public int getCarListCount(String searchType, String searchKeyword) {
		return mapper.selectgetCarListCount(searchType, searchKeyword);
	}


	// 같은 차량모델 있는지 조회 요청
	public int getSameModel(CarModelVO carModel) {
		return mapper.selectSameModel(carModel);
	}

	// 차량 모델 정보 등록 요청
	public int registCarModel(CarModelVO carModel) {
		return mapper.insertCarModel(carModel);
	}

	// 차량 정보 등록 요청
	public int registCar(CarVO car) {
		return mapper.insertCar(car);
	}

	// 차량 상세 정보 조회 요청
	public CarVO getCarListDetail(int car_idx) {
		return mapper.selectCarListDetail(car_idx);
	}
	// 차량 삭제 
	public int cardeleteBoard(int car_idx) {
		return mapper.cardeleteBoard(car_idx);
	}
	//차량 상태 수정
	public int getCarInfoUpdate(Map<String, String> map) {
		return mapper.updateCar(map);
	}

	


	



	
	



}
