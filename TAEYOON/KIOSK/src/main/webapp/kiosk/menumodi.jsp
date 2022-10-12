<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

    <style>
        .container {
            width: 700px;
            height: 600px;
            margin: 0 auto;
            border: 1px solid black;
        }

        .list {
            display: block;
            width: 500px;
            height: 60px;
            margin-left: 100px;
            padding: 10px;
            text-align: center;
        }



        .list ul {
            list-style: none;
            text-align: right;
            padding-left: 15px;

        }

        .list ul li {
            float: left;
            width: 120px;
            height: 40px;

        }

        .list ul li input {
            width: 110px;
            height: 50px;
        }

        .insert_img {
            float: left;
            width: 300px;
            height: 450px;
            margin-left: 50px;


        }

        .insert_text {
            float: left;
            width: 300px;
            height: 450px;
        }

        .insert_text table {
            width: 300px;
            height: 450px;
            text-align: center;
            margin: 0 auto;
            border-collapse: collapse;
        }

        .insert_text table td {
            border: 1px solid black;
        }

        .insert_text table td input {
            text-align: center;
        }

        .insert_text table th {
            width: 150px;
            border: 1px solid black;
            background-color: rgb(190, 190, 190);
        }



        .img {
            border: 1px solid black;
            width: 280px;
            height: 380px;
            text-align: center;
        }
    </style>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
function validateForm(form) {  // 폼 내용 검증
    if (form.food_name.value == "") {
        alert("메뉴 이름을 입력하세요.");
        form.title.focus();
        return false;
    }
    if (form.price.value == "") {
        alert("메뉴 가격을 입력하세요.");
        form.content.focus();
        return false;
    }

    if (form.explain.value == "") {
        alert("설명좀 입력하세요.");
        form.content.focus();
        return false;
    }
    
}



function PreviewImage() {
    // 파일리더 생성 
    var preview = new FileReader();
    preview.onload = function (e) {
    // img id 값 
    document.getElementById("user_image").src = e.target.result;
};
// input id 값 
preview.readAsDataURL(document.getElementById("imgup").files[0]);
};





</script>

</head>
<body>
   <form  method="post" enctype="multipart/form-data" action="processaddmenu.jsp" onsubmit="return validateForm(this);">
        <div class="container">
 			
 
            <nav class="list">
                <ul>
                    <li><input type="" value="" hidden></li>
                    <li><input type="" value="" hidden></li>
                    <li><input type="submit" value="저장"></li>
                    <li><a href="뒤로가기.html"><input type="button" value="돌아가기"> </a></li>
                </ul>
            </nav>




            <div class="insert_img">


				
                <div class="img" id="image_preview">
                      <img scr="#" id="user_image" alt="사진영역"  style="width:280px; height: 380px;">
                </div>
                <div>
                    <label for="imgup">사진 업로드</label>
                    <input type="file" id="imgup" name="img" accept=".jpg" onchange="PreviewImage();" >
                </div>
            </div>





            <div class="insert_text">

                <table>
                    <tr>
                        <th>구분</th>
                        <th>입력</th>

                    </tr>

                    <tr>
                        <td>카테고리</td>
    
    
                        <td>
                      
                         <select name="category" >
                                <option  value="MAIN">MAIN</option>
                                <option value="SIDE">SIDE</option>
                                <option  value="BEVERAGE">BEVERAGE</option>

                            </select>

                        </td>

                    </tr>
                    


                    <tr>
                        <td>메뉴 이름</td>
                        <td> <input type="text" name="foodName"> </td>

                    </tr>

                    <tr>
                        <td>단가</td>
                        <td> <input type="text" name="price"> </td>

                    </tr>
                    
                        <tr>
                        <td>설 명</td>
                        <td> <input type="text" name="explain"> </td>

                    </tr>                   





                </table>

            </div>
        </div>
    </form>
</body>
</html>