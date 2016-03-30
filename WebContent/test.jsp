<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html >
  <head>
    <meta charset="UTF-8">
    <meta name="google" value="notranslate">


    <title>CodePen - #9 글꼴 크기를 반응형으로 제어</title>
    <meta name="viewport" content="width=device-width">
    
    
    
        <style>
      @media (max-width:360px){html{font-size:10px;}}
@media (min-width:361px) and (max-width:399px){html{font-size:11px;}}
@media (min-width:400px) and (max-width:439px){html{font-size:12px;}}
@media (min-width:440px) and (max-width:479px){html{font-size:13px;}}
@media (min-width:480px) and (max-width:519px){html{font-size:14px;}}
@media (min-width:520px) and (max-width:559px){html{font-size:15px;}}
@media (min-width:560px) and (max-width:599px){html{font-size:16px;}}
@media (min-width:600px) and (max-width:639px){html{font-size:17px;}}
@media (min-width:640px) and (max-width:679px){html{font-size:18px;}}
@media (min-width:680px) and (max-width:719px){html{font-size:19px;}}
@media (min-width:720px) and (max-width:759px){html{font-size:20px;}}
@media (min-width:760px) and (max-width:799px){html{font-size:21px;}}
@media (min-width:800px) and (max-width:839px){html{font-size:22px;}}
@media (min-width:840px) and (max-width:879px){html{font-size:23px;}}
@media (min-width:880px){html{font-size:24px;}}
body{
  font-family:Helvetica, Arial, Sans-serif;
  font-size:1rem;
  line-height:1.5;
}
.container{
  min-width:320px;
  max-width:1280px;
  margin:0 auto;
  background:#eee;
  overflow:hidden;
  min-height:200px;
}
h1{
  text-align:center;
}
    </style>

    
    
    
  </head>

  <body>

    <div class="container">
  <h1>Happy new year! Welcome 2015!</h1>
  <p>#8 모바일 뷰 포트 설정을 통해서 화면 표시 배율을 적절하게 만들면 스마트폰에서 글꼴이 너무 작아지는 문제는 발생하지 않기 때문에 글꼴 크기까지 반응형으로 직접 제어해야 하는 상황은 일반적인 상황은 아닙니다. 읽기에 적절한 크기로 표시하기 때문에 통상 글꼴 크기까지 직접 나서서 제어할 필요는 없다는 의미입니다.</p>
  <p>그러나 디자이너의 의도에 따라 화면 폭에 알맞에 적절한 글자 수를 배치하고 동적인 화면 크기에 따라 동등한 배율로 글꼴 크기를 표현해야 할 때 개발자는 의도에 따라 제어할 수 있어야 합니다.</p>
  <p>이 예제는 <strong>화면 크기와 글꼴 크기가 비례하는 예제</strong>입니다.</p>
</div>
    
    
    
    
    
    
  </body>
</html>
 
