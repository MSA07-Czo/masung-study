<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Header Design</title>
    <link 
     href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" 
     rel="stylesheet"
    />
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            background-color: #222222;
            color: white;
        }
        
        header nav {
        	margin-right: 2rem
        }

        header .logo a{
            font-size: 1.5rem;
            font-weight: bold;
            text-decoration: none;
            color: white;
            margin-left: 2rem;
        }

        header nav a {
            margin-left: 1rem;
            color: white;
            text-decoration: none;
            font-size: 1rem;
            transition: color 0.3s ease;
        }

        header nav a:hover {
            color: #ffcc00;
        }
        
        .dropdown {
		  position: absolute;
		  width: 250px;
		  box-shadow: var(--shadow);
		  border-radius: var(--radius);
		  margin-top: 0.3rem;
		  background: white;
		  transition: all 0.1s cubic-bezier(0.16, 1, 0.5, 1);
		
		  transform: translateY(0.5rem);
		  visibility: hidden;
		  opacity: 0;
		}
		
		.dropdown a {
		  display: flex;
		  align-items: center;
		  column-gap: var(--gap);
		  padding: 0.8rem 1rem;
		  text-decoration: none;
		  color: black;
		}
		
		.dropdown a:hover {
		  background-color: var(--color);
		  color: red;
		}
		
		.show {
		  transform: translateX(-10rem) translateY(1rem);
		  visibility: visible;
		  opacity: 1;
		}
		
/* 		.arrow {
		  transform: rotate(180deg);
		  transition: 0.2s ease;
		} */

        .user-info {
            display: flex;
            align-items: center;
        }

        .user-info span {
            margin-right: 1rem;
            font-weight: bold;
        }

        .login-info {
            margin-right: 1rem;
            display: flex;
            align-items: center;
        }

        .login-info a {
            margin-left: 1rem;
        }

        header .btn {
            padding: 0rem 1rem;
            background-color: rgba(0,0,0,0);
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            font-size: 25px;
            color: #ffffff;
            transition: background-color 0.3s ease;
        }
    </style>
</head>
<body>

    <header id="header">
        <div class="logo">
        	<a href="/">마성</a>
        </div>
        <nav class="user-info">
            <c:if test="${loginInfo == null}">
                <a href="/user/login">로그인</a>
            </c:if>

            <c:if test="${loginInfo != null}">
                <div class="login-info">

                    <c:choose>
                        <c:when test="${loginInfo.user_role == 'admin'}">
                            <a href="/user/list">admin</a>
                        </c:when>
                    </c:choose>
                    <button class="btn" id="btn">
					    <i class="bx bx-user"></i>
					    <%-- ${loginInfo.user_id} 님 --%>
					  <div class="dropdown" id="dropdown">
						  <a href="/noservice">
						    <i class="bx bx-pen"></i>
						    내가 쓴 글
						  </a>
						  <a href="/user/read?uid=${loginInfo.user_id}">
						    <i class="bx bx-user"></i>
						    마이페이지
						  </a>
						  <a href="/user/logout">
						    <i class="bx bx-lock"></i>
						    로그아웃
						  </a>
						</div>
					  <!-- <i class="bx bx-chevron-down" id="arrow"></i> -->
					</button>
                    
                </div>
            </c:if>
        </nav>
    </header>
    
    <script type="text/javascript">
	    const dropdownBtn = document.getElementById("btn");
	    const dropdownMenu = document.getElementById("dropdown");
	    /* const toggleArrow = document.getElementById("arrow"); */

	    const toggleDropdown = function () {
	      dropdownMenu.classList.toggle("show");
	      /* toggleArrow.classList.toggle("arrow"); */
	    };

	    if (dropdownBtn) {
		    dropdownBtn.addEventListener("click", function (e) {
	    	  e.stopPropagation();
	    	  toggleDropdown();
		    });
	    }
    </script>

</body>
</html>