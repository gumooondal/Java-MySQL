function joinCheck(){
	
	if(document.frm.membname.value.length == 0){
			alert("회원이름이 입력되지 않았습니다.");
			frm.membname.focus();
			return false;
	}
	if(document.frm.phone.value.length == 0){
			alert("회원전화가 입력되지 않았습니다.");
			frm.phone.focus();
			return false;
	}
	if(document.frm.address.value.length == 0){
			alert("회원주소가 입력되지 않았습니다.");
			frm.address.focus();
			return false;
	}
	if(document.frm.joindate.value.length == 0){
			alert("가입일자가 입력되지 않았습니다.");
			frm.joindate.focus();
			return false;
	}
	if(document.frm.grade.value.length == 0){
			alert("회원등급이 입력되지 않았습니다.");
			frm.grade.focus();
			return false;
	}
	if(document.frm.city.value.length == 0){
			alert("도시가 입력되지 않았습니다.");
			frm.city.focus();
			return false;
	}
	success();
	return true;
}

function success(){
	alert("회원등록이 완료되었습니다!");
}

function memberSearch(){
	window.location = 'memberList.jsp' ;
}

function modify(){
	alert("회원정보수정이 완료되었습니다!");
}

function deletePost(){
	// 사용자에게 확인 메시지 표시
	var userConfirmed = confirm("삭제하시겠습니까?");

	// 사용자가 확인 버튼을 눌렀을 경우만 삭제 작업 수행
	if (userConfirmed) {
	    // 삭제 작업을 여기에 추가하세요
	    alert("삭제가 완료되었습니다.");
	} else {
	    // 취소 버튼을 눌렀을 경우
	    alert("삭제가 취소되었습니다.");
		return false;
	}
}

function setJoinDate() {
		var today = new Date();
		var year = today.getFullYear();
		var month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
		var day = String(today.getDate()).padStart(2, '0');
		var formattedDate = year + '-' + month + '-' + day;

		// input 요소에 현재 날짜를 설정
		document.getElementsByName("joindate")[0].value = formattedDate;
     }
	 
	 