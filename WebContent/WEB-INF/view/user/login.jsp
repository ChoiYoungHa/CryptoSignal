<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String SS_USER_NAME = (String)session.getAttribute("SS_USER_NAME");
    System.out.println("세션 : " + SS_USER_NAME);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Corona Admin</title>
    <!-- plugins:css -->
    <link rel="stylesheet" href="/resource/assets/vendors/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="/resource/assets/vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <!-- endinject -->
    <!-- Layout styles -->
    <link rel="stylesheet" href="/resource/assets/css/classic-horizontal/style.css">
    <!-- End layout styles -->
    <link rel="shortcut icon" href="/resource/assets/images/favicon.png" />
    <!-- Sweet Alert -->
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        console.log("실행");
        if ("<%=SS_USER_NAME%>" != "null") {
            Swal.fire({
                title: '이미 로그인 되었습니다!',
                icon: 'warning',
                showConfirmButton: false,
                timer: 1300
            }).then(val => {
                if (val) {
                    location.href = "/index.do";
                }
            });
        }
    })
</script>
<div class="container-scroller">
    <div class="container-fluid page-body-wrapper full-page-wrapper">
        <div class="row w-100">
            <div class="content-wrapper full-page-wrapper auth login-2 login-bg p-0">
                <div class="card col-lg-4">
                    <div class="card-body px-5 py-5">
                        <h3 class="card-title text-left mb-3">Login</h3>

                        <!-- 로그인 회원정보 입력란 -->
                        <form action="/login.do" method="post">
                            <div class="form-group">
                                <label>Username or email *</label>
                                <input name="email" type="text" id="email" class="form-control p_input">
                            </div>
                            <div class="form-group">
                                <label>Password *</label>
                                <input name="password" type="password" id="password" class="form-control p_input">
                            </div>

                            <br/>
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary btn-block enter-btn">Login</button>
                            </div>
                            <p class="sign-up">아직 회원이 아닌가요?&nbsp;<a href="/signUp.do">회원가입</a> <a class="ml-1" href="/">홈으로</a></p>
                        </form>
                    </div>
                </div>
            </div>
            <!-- content-wrapper ends -->
        </div>
        <!-- row ends -->
    </div>
    <!-- page-body-wrapper ends -->
</div>
<!-- container-scroller -->
<!-- plugins:js -->
<script src="/resource/assets/vendors/js/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page -->
<!-- End plugin js for this page -->
<!-- inject:js -->
<script src="/resource/assets/js/off-canvas.js"></script>
<script src="/resource/assets/js/hoverable-collapse.js"></script>
<script src="/resource/assets/js/misc.js"></script>
<script src="/resource/assets/js/settings.js"></script>
<script src="/resource/assets/js/todolist.js"></script>
<!-- endinject -->
</body>
</html>
