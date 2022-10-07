<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="kiosk.css">
    <title>Document</title>
</head>
<style>
#logo{
    width: 200px;
    height: 200px;
}
.pwWrap {
  width: 80%;
  max-width: 450px;
  background: lightGrey;
  margin: 20px auto;
}
#start{
    text-align: center;
}
.pwWrap .pwSection {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 150px;
}

.pwWrap .pwSection .dot {
  display: block;
  width: 50px;
  height: 50px;
  background: darkgrey;
  border-radius: 20px;
  margin: 0 5px;
}

.pwWrap .pwSection .dot.active {
  background: rgba(0, 0, 0, 0.7);
}

.pwWrap .pwSection .message {
  position: absolute;
  bottom: 5px;
  left: 0;
  z-index: 1;
  min-width: 100%;
  text-align: center;
  font-size: 14px;
  font-weight: bold;
  letter-spacing: -0.03em;
  opacity: 0;
  transition: .2s ease-out;
}

.pwWrap .numberSection {
  overflow: hidden;
}

.pwWrap .numberSection .number {
  float: left;
  width: 33.33%;
  border: 1px solid rgba(0, 0, 0, 0.1);
  padding: 12px 0;
  cursor: pointer;
  background: #F8F2F2;
}

.pwWrap .numberSection .number:last-child {
  margin-left: 33.33%;
}

.pwWrap.error .message {
  opacity: 1;
  color: red;
}

.pwWrap.confirm .message {
  opacity: 1;
  color: green;
}
</style>
<body>
    
    <img src="logo.jpg" alt="로고" id="logo">
    <h3>비밀번호를 입력하세요.</h3>
    <div class="pwWrap">
        <div class="pwSection">
            <span class="dot"></span>
            <span class="dot"></span>
            <span class="dot"></span>
            <span class="dot"></span>
            <p class="message">&nbsp;</p>
        </div>
        <div class="numberSection">
            <button class="number">1</button>
            <button class="number">2</button>
            <button class="number">3</button>
            <button class="number">4</button>
            <button class="number">5</button>
            <button class="number">6</button>
            <button class="number">7</button>
            <button class="number">8</button>
            <button class="number">9</button>
            <button class="number">0</button>
        </div>
    </div>
    <!-- <a id="start" href="second.html"><input type="button" value="확인"></a> -->
    <br>
    <script>
        function PwCheck(pw) {
        const _this = this; 
        _this.pwStr = pw.toString(); // 문자, 숫자열을 모두 허용하기 위해 무조건 한가지 타입으로 맞춤
        _this.password = []; // 지정된 패스워드
        _this.passwordNumber = []; // 입력할 패스워드
        _this.cnt = 0; // 입력횟수 체크
        _this.compChk = false; // 입력완료 체크 
        _this.msg = [
            '비밀번호가 틀렸습니다. 다시 입력하세요.',
            '관리자 페이지로 이동'
        ]; 

        _this.parent = document.querySelector('.pwWrap');
        _this.dots = document.querySelectorAll('.dot');
        _this.numbers = document.querySelectorAll('.number');
        _this.message = document.querySelector('.message');


        // 비밀번호를 배열에 넣음 
        _this.getPw = function(){
            for(let i=0; i<_this.pwStr.length; i++) {
                _this.password[i] = _this.pwStr[i];
            }
        }

        // 숫자버튼 click이벤트 연동
        _this.handleListener = function(){
            if(!_this.compChk) {
                _this.numbers.forEach(function(number){
                    number.addEventListener('click', function(){_this.handleNumber(number)});
                })
            }
        }

        // 숫자키를 눌렀을때 이벤트 
        _this.handleNumber = function(number){
            if(!_this.compChk) {    
                _this.passwordNumber[_this.cnt] = number.textContent;
                _this.handleDotActive(true);
                _this.cnt++;
                if(_this.cnt === 4) {
                    _this.handleResult();
                }
            }
        }

        // dot 활성화 
        _this.handleDotActive = function(type){
            if(type) {
                _this.dots.forEach(function(dot, i){
                    if(i === _this.cnt) dot.classList.add('active'); 
                })
            } else {
                _this.dots.forEach(function(dot){
                dot.classList.remove('active'); 
                })
            }
        }

        // 비밀번호 비교
        _this.handleCheckPw = function(){
            let compare = JSON.stringify(_this.password) === JSON.stringify(_this.passwordNumber);
            return compare; 
        }

        // 결과처리 
        _this.handleResult = function(){
            if(_this.handleCheckPw()) {
                _this.parent.classList.add('confirm');
                _this.message.textContent = _this.msg[1];
                _this.compChk = true;
            } else {
                _this.parent.classList.add('error');
                _this.message.textContent = _this.msg[0];
                // 입력상태 초기화 
                _this.passwordNumber = [];
                _this.cnt = 0; 
                _this.compChk = true; // 일시적인 클릭 방지 
                
                setTimeout(function(){
                    _this.compChk = false;
                    _this.parent.classList.remove('error');
                    _this.handleDotActive();
                }, 1000);
            }
        }

            _this.init = function(){
                _this.handleListener();
                _this.getPw();
            }();
        }

        let pwCheck = new PwCheck(1234);
    </script>
</body>
</html>