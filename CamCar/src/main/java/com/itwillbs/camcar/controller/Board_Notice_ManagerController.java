package com.itwillbs.camcar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Board_Notice_ManagerController {

	@GetMapping("board_notice")
	public String member() {
		return"board/board_notice";
	}
}
