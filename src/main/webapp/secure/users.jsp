<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Movie Store</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        /* Remove the navbar's default margin-bottom and rounded borders */
        .navbar {
            margin-bottom: 0;
            border-radius: 0;
            background-color: #006699;
        }

        /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
        .row.content {height: 450px}

        /* Set gray background color and 100% height */
        .modal-header , .modal-footer {
            background-color: #006699;
        }

        /* Set black background color, white text and some padding */
        footer {
            background-color: #006699;
            color: white;
            padding: 15px;
        }

        /* On small screens, set height to 'auto' for sidenav and grid */
        @media screen and (max-width: 767px) {
            .sidenav {
                height: auto;
                padding: 15px;
            }
            .row.content {height:auto;}
        }
    </style>
    <script>
        $( document ).ready(function() {
            $("#btnAdd").click(function(event) {
                event.preventDefault();
                $("#NewUserModal").load("newUser.jsp");
                $("#NewUserModal").modal("show");
            });

            $(".btnEdit").click(function(event) {
                event.preventDefault();
                $.get($(this).attr('href'), function(data, status){
                    $("#NewUserModal").html(data);
                    $("#NewUserModal").modal("show");
                });

            });
        });
    </script>
</head>
<body>

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Logo</a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav">
                <li><a href="/secure/movies">Home</a></li>
                <li><a href="/secure/create.jsp">Create</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a>Welcome&nbsp;<span class="badge"><c:out value="${user.displayName}"/></span></a></li>
                <li class="active"><a href="/secure/users"><span class="glyphicon glyphicon-users"></span>Users</a></li>
                <li><a href="/secure/logout"><span class="glyphicon glyphicon-log-out"></span>Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <br/>
    <c:if test="${success_user_operation_msg != null}">
        <div class="alert alert-success">
            <c:out value="${success_user_operation_msg}"/>
        </div>
    </c:if>
    <div class="row">
        <div class="col-sm-8">
            <h4>Users page:</h4>
            <div>
            <p>Click <a href="" class="btn btn-xs btn-info" id="btnAdd">New User</a> to create new user, or
                <form class="form-inline" action="/secure/user/upload" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="usersFile">Select file:</label>
                        <input type="file" class="form-control file input-sm" id="usersFile" name="usersFile">
                    </div>
                    <button type="submit" class="btn btn-sm btn-info">Upload</button>
                </form>
            </p>
            </div>
            <table class="table">
                <thead>
                <tr>
                    <td>User ID</td>
                    <td>Username</td>
                    <td>Display Name</td>
                    <td>Edit/Delete</td>
                </tr>
                <c:if test="${uList == null}">
                    <tr>
                        <td colspan="4" style="text-align: center">No Users to display</td>
                    </tr>
                </c:if>
                </thead>
                <tbody>
                <c:forEach items="${uList}" var="aUser">
                   <tr>
                       <td><c:out value="${aUser.id}"/></td>
                       <td><c:out value="${aUser.username}"/></td>
                       <td><c:out value="${aUser.displayName}"/></td>
                       <td>
                           <a href="/secure/user/select?id=<c:out value="${aUser.id}"/>" class="btnEdit btn btn-success btn-xs">
                               <span class="glyphicon glyphicon-edit"></span>Edit
                           </a>
                           &nbsp;
                           <a href="/secure/user/delete?id=<c:out value="${aUser.id}"/>" class="btn btn-danger btn-xs">
                               <span class="glyphicon glyphicon-remove"></span>Delete
                           </a>
                       </td>
                   </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="NewUserModal" role="dialog">

    </div>

</div>




<footer class="container-fluid text-center">
    <p>Welcome To Skippers Web App</p>
</footer>

</body>
</html>
