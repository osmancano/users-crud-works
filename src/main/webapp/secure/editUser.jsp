<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Edit User Form</h4>
        </div>
        <div class="modal-body">
            <form class="form-horizontal" action="/secure/user/create" method="post">
                <div class="form-group">
                    <label class="control-label col-sm-3" for="username">Username:</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="username" name="username" placeholder="Enter Username" value="<c:out value="${selectedUser.username}"/>"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-3" for="password">Password:</label>
                    <div class="col-sm-9">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" value="<c:out value="${selectedUser.password}"/>"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-3" for="displayName">Display Name:</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="displayName" name="displayName" placeholder="Enter Display Name" value="<c:out value="${selectedUser.displayName}"/>"/>
                    </div>
                </div>
                <input type="hidden" name="id" value="<c:out default="0" value="${selectedUser.id}"/>"/>
                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-10">
                        <button type="submit" class="btn btn-info">Save</button>
                    </div>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
    </div>

</div>