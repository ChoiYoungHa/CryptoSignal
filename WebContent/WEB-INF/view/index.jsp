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
    <title>Crypto Signal</title>
    <!-- plugins:css -->
    <link rel="stylesheet" href="/resource/assets/vendors/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="/resource/assets/vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <link rel="stylesheet" href="/resource/assets/vendors/jvectormap/jquery-jvectormap.css">
    <link rel="stylesheet" href="/resource/assets/vendors/flag-icon-css/css/flag-icon.min.css">
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <!-- endinject -->
    <!-- Layout styles -->
    <link rel="stylesheet" href="/resource/assets/css/classic-horizontal/style.css">
    <!-- End layout styles -->
    <link rel="shortcut icon" href="/resource/assets/images/favicon.png" />

    <script>
        function rsiPlay(){
            let obj_length = document.getElementsByName("coin").length;
            let coinList = [];

            for (let i = 0; i < obj_length; i++) {
                if (document.getElementsByName("coin")[i].checked == true) {
                    coinList.push(document.getElementsByName("coin")[i].value);
                }
            }

            let minute = $("#unit-select option:selected").val();

            console.log(coinList[0]);
            console.log(minute)

            $.ajax({
                url : "http://127.0.0.1:5000/rsiAram",
                type : "post",
                dataType : "list",
                data : {
                    "coinList": coinList,
                    "minute" : minute
                }
            })
        }
    </script>
</head>
<body>
<div class="container-scroller">
    <!-- partial:partials/_horizontal-navbar.html -->
    <div class="horizontal-menu">
        <nav class="navbar top-navbar col-lg-12 col-12 p-3">
            <div class="container">
                <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
                    <a class="navbar-brand brand-logo mr-2" href="/">Crypto Signal</a>
                    <a class="navbar-brand brand-logo-mini" href="index.html"><img src="/resource/assets/images/logo-mini.svg" alt="logo" /></a>
                </div>
                <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
                    <ul class="navbar-nav w-100">
                        <li class="nav-item w-100">
                        </li>
                    </ul>
                    <ul class="navbar-nav navbar-nav-right">


                        <!-- 로그인 또는 로그인한 회원정보를 표시하는 공간 -->
                        <!-- 세션이 없는 경우(=로그인 안한 상태) -->
                        <li class="nav-item dropdown border-left">
                            <a class="nav-link count-indicator dropdown-toggle" id="notificationDropdown" href="#" data-toggle="dropdown">
                                <% if (SS_USER_NAME == null) { %>
                                <div class="users mr-2" style="width: 150px;" onclick="location.href='/loginPage.do'">로그인 후 이용하세요
                                </div>
                            </a>
                        </li>

                        <!-- 세션이 있는 경우(=로그인 상태인 경우) -->
                        <% } else { %>
                        <div class="users mr-2" style="width: 150px;"><%=SS_USER_NAME%>님 환영합니다!</div>
                        <div class="users" onclick="location.href='/logout.do'" style="width: 50px;">로그아웃</div>
                        <% } %>
                        </a>

                        </li>

                        <li class="nav-item nav-settings d-none d-lg-block">
                            <a class="nav-link" href="#">
                                <i class="mdi mdi-view-grid"></i>
                            </a>
                        </li>
                    </ul>
                    <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="horizontal-menu-toggle">
                        <span class="mdi mdi-menu"></span>
                    </button>
                </div>
            </div>
        </nav>

    </div>

    <!-- ########################################## RSI 알림 설정 등록 ########################################## -->
    <div class="container-fluid page-body-wrapper">
        <div class="main-panel">
            <div class="content-wrapper">
                <div class="row">
                    <div class="col-md-4 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title text-center">상대강도지수 RSI 알림</h4>
                                <div class="row my-4">
                                    <div class="col-lg-7 mx-auto text-center">

                                        <button type="button" class="btn btn-success btn-fw fa-play mb-2" onclick="rsiPlay()"><i class="fa-play">실행</i></button>

                                        <select class="dropdown-header bg-primary rounded-bottom rounded-top m-auto" id="unit-select">
                                            <option class="dropdown-item" value="" selected hidden>분봉 선택</option>
                                            <option class="dropdown-item mdi-cursor-pointer" value="1">1분봉</option>
                                            <option class="dropdown-item" value="3">3분봉</option>
                                            <option class="dropdown-item" value="5">5분봉</option>
                                            <option class="dropdown-item" value="10">10분봉</option>
                                            <option class="dropdown-item" value="15">15분봉</option>
                                            <option class="dropdown-item" value="30">30분봉</option>
                                            <option class="dropdown-item" value="60">60분봉</option>
                                            <option class="dropdown-item" value="240">240분봉</option>
                                        </select>


                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded justify-content-between">
                                        <div>
                                            <h6 class="mb-1">Transfer to stripe</h6>
                                            <p class="card-text">Dec 25, 2018</p>
                                        </div>
                                        <div class="align-self-center">
                                            <h6 class="font-weight-bold mb-0">650$</h6>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-12 bg-gray-dark d-flex flex-row py-3 px-4 rounded">
                                        <div>
                                            <h6 class="mb-1">Transfer to Paypal</h6>
                                            <p class="card-text">Dec 31, 2018</p>
                                        </div>
                                        <div class="align-self-center flex-grow text-right">
                                            <h6 class="font-weight-bold mb-0">530$</h6>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ############################ Coin List ############################ -->
                    <div class="col-md-8 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body" style="height: 450px; overflow: auto;">
                                <div class="d-flex flex-row justify-content-between">
                                    <div>
                                        <h4 class="card-title">Coin List</h4>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <div class="preview-list">

                                            <!-- 01. 비트코인(KRW-BTC) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/1.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">비트코인</h6>
                                                        <p class="mb-0">KRW-BTC</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-BTC" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 02. 이더리움(KRW-ETH) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/1027.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">이더리움</h6>
                                                        <p class="mb-0">KRW-ETH</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-ETH" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 03. 에이다(KRW-ADA) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/2010.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">에이다</h6>
                                                        <p class="mb-0">KRW-ADA</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-ADA" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 04. 리플(KRW-XRP) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/52.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">리플</h6>
                                                        <p class="mb-0">KRW-XRP</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-XRP" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 05. 폴카닷(KRW-DOT) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/6636.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">폴카닷</h6>
                                                        <p class="mb-0">KRW-DOT</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-DOT" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 06. 도지코인(KRW-DOT) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/74.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">도지코인</h6>
                                                        <p class="mb-0">KRW-DOGE</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-DOGE" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 07. 라이트코인(KRW-LTC) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/2.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">라이트코인</h6>
                                                        <p class="mb-0">KRW-LTC</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-LTC" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 07. 체인링크(KRW-LINK) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/1975.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">체인링크</h6>
                                                        <p class="mb-0">KRW-LINK</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-LINK" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 08. 비트코인캐시(KRW-BCH) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/1831.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">비트코인캐시</h6>
                                                        <p class="mb-0">KRW-BCH</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-BCH" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 09. 스텔라루멘(KRW-XLM) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/512.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">스텔라루멘</h6>
                                                        <p class="mb-0">KRW-XLM</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-XLM" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 10. 코스모스(KRW-ATOM) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/3794.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">코스모스</h6>
                                                        <p class="mb-0">KRW-ATOM</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-ATOM" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 11. 비체인(KRW-VET) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/3077.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">비체인</h6>
                                                        <p class="mb-0">KRW-VET</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-VET" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 12. 엑시인피니티(KRW-AXS) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/6783.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">엑시인피니티</h6>
                                                        <p class="mb-0">KRW-AXS</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-AXS" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 13. 트론(KRW-TRX) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/1958.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">트론</h6>
                                                        <p class="mb-0">KRW-TRX</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-TRX" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 14. 이더리움클래식(KRW-ETC) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/1321.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">이더리움클래식</h6>
                                                        <p class="mb-0">KRW-ETC</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-ETC" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 15. 쎄타토큰(KRW-THETA) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/2416.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">쎄타토큰</h6>
                                                        <p class="mb-0">KRW-THETA</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-THETA" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 16. 테조스(KRW-XTZ) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/2011.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">테조스</h6>
                                                        <p class="mb-0">KRW-XTZ</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-XTZ" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 17. 헤데라해시그래프(KRW-HBAR) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/4642.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">헤데라해시그래프</h6>
                                                        <p class="mb-0">KRW-HBAR</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-HBAR" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 18. 크립토닷컴체인(KRW-CRO) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/3635.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">크립토닷컴체인</h6>
                                                        <p class="mb-0">KRW-CRO</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-CRO" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 19. 이오스(KRW-EOS) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/1765.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">이오스</h6>
                                                        <p class="mb-0">KRW-EOS</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-EOS" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 20. 이캐시(KRW-XEC) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/10791.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">이캐시</h6>
                                                        <p class="mb-0">KRW-XEC</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-XEC" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 21. 아이오타(KRW-IOTA) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/1720.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">아이오타</h6>
                                                        <p class="mb-0">KRW-IOTA</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-IOTA" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 22. 비트코인에스브이(KRW-BSV) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/3602.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">비트코인에스브이</h6>
                                                        <p class="mb-0">KRW-BSV</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-BSV" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 23. 네오(KRW-NEO) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/1376.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">네오</h6>
                                                        <p class="mb-0">KRW-NEO</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-NEO" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 24. 웨이브(KRW-WAVES) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/1274.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">웨이브</h6>
                                                        <p class="mb-0">KRW-WAVES</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-WAVES" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 25. 비트토렌트(KRW-BTT) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/3718.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">비트토렌트</h6>
                                                        <p class="mb-0">KRW-BTT</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-BTT" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 26. 스택스(KRW-STX) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/4847.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">스택스</h6>
                                                        <p class="mb-0">KRW-STX</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-STX" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 27. 오미세고(KRW-OMG) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/1808.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">오미세고</h6>
                                                        <p class="mb-0">KRW-OMG</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-OMG" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 28. 칠리즈(KRW-CHZ) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/4066.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">칠리즈</h6>
                                                        <p class="mb-0">KRW-CHZ</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-CHZ" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 29. 쎄타퓨엘(KRW-TFUEL) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/3822.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">쎄타퓨엘</h6>
                                                        <p class="mb-0">KRW-TFUEL</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-TFUEL" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 30. 넴(KRW-XEM) -->
                                            <div class="preview-item border-bottom">
                                                <div class="preview-item-content d-sm-flex flex-grow">
                                                    <div class="media">
                                                        <img src="https://s2.coinmarketcap.com/static/img/coins/64x64/873.png" alt="image" class="img-sm mr-3 rounded-circle">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <h6 class="preview-subject">넴</h6>
                                                        <p class="mb-0">KRW-XEM</p>
                                                    </div>
                                                    <div class="mr-auto text-sm-right pt-2 pt-sm-0">
                                                        <div class="form-check form-check-flat form-check-primary">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" value="KRW-XEM" name="coin">
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 코인 로그 기록 -->
                <div class="row">
                    <div class="col-md-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex flex-row p-3">
                                    <div class="align-self-top">
                                        <h4 class="card-title">로그 기록</h4>
                                        <%--                                        <h3 class="mb-0">2800</h3>--%>
                                    </div>
                                    <div class="align-self-center flex-grow text-right">
                                        <i class="icon-lg mdi mdi-chart-pie text-primary"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 코인 로그 2분할-1 -->
                <div class="row">
                    <div class="col-md-6 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">과매도 RSI 30</h4>
                                <div class="preview-list">
                                    <div class="preview-item border-bottom">
                                        <div class="preview-thumbnail">
                                            <img src="/resource/assets/images/faces/face6.jpg" alt="image" class="rounded-circle img-sm" />
                                        </div>
                                        <div class="preview-item-content d-flex flex-grow">
                                            <div class="flex-grow">
                                                <div class="d-sm-flex justify-content-between">
                                                    <h6 class="preview-subject">Coin name</h6>
                                                    <div class="d-flex">
                                                        <p class="text-small text-muted border-right pr-3">날짜/시간</p>
                                                    </div>
                                                </div>
                                                <p>description</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 코인 로그 2분할-1 -->

                    <!-- 코인 로그 2분할-2 -->
                    <div class="col-md-6 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">과매수 RSI 30</h4>
                                <div class="preview-list">
                                    <div class="preview-item border-bottom">
                                        <div class="preview-thumbnail">
                                            <img src="/resource/assets/images/faces/face6.jpg" alt="image" class="rounded-circle img-sm" />
                                        </div>
                                        <div class="preview-item-content d-flex flex-grow">
                                            <div class="flex-grow">
                                                <div class="d-sm-flex justify-content-between">
                                                    <h6 class="preview-subject">Coin name</h6>
                                                    <div class="d-flex">
                                                        <p class="text-small text-muted border-right pr-3">날짜/시간</p>
                                                    </div>
                                                </div>
                                                <p>description</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 코인 로그 2분할-2 -->

                <!-- 코인 관련 종합 뉴스 기록 -->
                <div class="row">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">코인 종합 뉴스</h4>

                                <!-- table 형태로 뉴스 목록 불러오기 -->
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <!-- column 기록 -->
                                            <th> 뉴스 제목 </th>
                                            <th> 뉴스 내용 </th>
                                            <th> 날짜 </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td> David Grey </td>
                                            <td> davidgrey@demo.com </td>
                                            <td> 01/11/2017 </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 코인 관련 호재 뉴스(오피니언 마이닝) 01 -->
                <div class="row">
                    <div class="col-md-6 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">호재 News</h4>
                                <div class="preview-list">
                                    <div class="preview-item border-bottom">
                                        <div class="preview-thumbnail">
                                            <img src="/resource/assets/images/faces/face6.jpg" alt="image" class="rounded-circle" />
                                        </div>
                                        <div class="preview-item-content d-flex flex-grow">
                                            <div class="flex-grow">
                                                <div class="d-sm-flex justify-content-between">
                                                    <h6 class="preview-subject">Richard Joy</h6>
                                                    <div class="d-flex">
                                                        <p class="text-small text-muted border-right pr-3">13.06.2017</p>
                                                    </div>
                                                </div>
                                                <p>Well, it seems to be working now. Thank You !</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 코인 관련 호재 뉴스(오피니언 마이닝) end -->

                    <!-- 코인 관련 악재 뉴스(오피니언 마이닝) 02 -->
                    <div class="col-md-6 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">악재 News</h4>
                                <div class="preview-list">
                                    <div class="preview-item border-bottom">
                                        <div class="preview-thumbnail">
                                            <img src="/resource/assets/images/faces/face6.jpg" alt="image" class="rounded-circle" />
                                        </div>
                                        <div class="preview-item-content d-flex flex-grow">
                                            <div class="flex-grow">
                                                <div class="d-sm-flex justify-content-between">
                                                    <h6 class="preview-subject">Richard Joy</h6>
                                                    <div class="d-flex">
                                                        <p class="text-small text-muted border-right pr-3">13.06.2017</p>
                                                    </div>
                                                </div>
                                                <p>Well, it seems to be working now. Thank You !</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 코인 관련 악재 뉴스(오피니언 마이닝) end -->

                </div>
            </div>

            <!-- footer -->
            <footer class="footer container">
                <div class="d-sm-flex justify-content-center justify-content-sm-between">
                    <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2019 <a href="https://www.bootstrapdash.com/" target="_blank">BootstrapDash</a>. All rights reserved.</span>
                    <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i class="mdi mdi-heart text-danger"></i></span>
                </div>
            </footer>
            <!-- footer end -->

        </div>
        <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
</div>

<style>
    .card-body::-webkit-scrollbar {
        display: none;
    }

</style>
<!-- container-scroller -->
<!-- plugins:js -->
<script src="/resource/assets/vendors/js/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page -->
<script src="/resource/assets/vendors/progressbar.js/progressbar.min.js"></script>
<script src="/resource/assets/vendors/jvectormap/jquery-jvectormap.min.js"></script>
<script src="/resource/assets/vendors/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- End plugin js for this page -->
<!-- inject:js -->
<script src="/resource/assets/js/off-canvas.js"></script>
<script src="/resource/assets/js/hoverable-collapse.js"></script>
<script src="/resource/assets/js/misc.js"></script>
<script src="/resource/assets/js/settings.js"></script>
<script src="/resource/assets/js/todolist.js"></script>
<!-- endinject -->
<!-- Custom js for this page -->
<script src="/resource/assets/js/dashboard.js"></script>
<!-- End custom js for this page -->
<!--Jquery 3.4.1 -->
<script src="/resource/assets/js/jquery-3.4.1.min.js"></script>
</body>
</html>