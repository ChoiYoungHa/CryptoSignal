<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
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
</head>
<body>
<div class="container-scroller">
    <div class="container-fluid page-body-wrapper full-page-wrapper">
        <div class="row w-100">
            <div class="content-wrapper full-page-wrapper auth option-2 register-half-bg">
                <div class="card col-lg-4">
                    <div class="card-body px-5 py-5">
                        <div class="wrapper w-100">
                            <h3 class="card-title text-left mb-3">Register</h3>
                        </div>

                        <!-- 회원가입을 위한 회원정보 입력란 -->
                        <form action="/insertUser.do", method="post">
                            <div class="form-group">
                                <label>이름</label>
                                <input type="text" class="form-control p_input" name="userName">
                            </div>

                            <div class="form-group">
                                <label>닉네임</label>
                                <input type="text" class="form-control p_input" name="userNicName">
                            </div>

                            <div class="form-group">
                                <label>이메일</label>
                                <input type="email" class="form-control p_input" name="email">
                            </div>

                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" class="form-control p_input" name="password">
                            </div>

                            <br/>
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary btn-block enter-btn">회원가입</button>
                            </div>
                            <p class="sign-up text-center">이미 회원인가요?&nbsp;<a href="/loginPage.do">로그인</a></p>
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