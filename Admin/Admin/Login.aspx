<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Admin.Login" %>

<!DOCTYPE html>

<html lang="en">


<head runat="server">

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Admin</title>
  <!-- Bootstrap Core CSS -->
    <link href="content/bootstrap.min.css" rel="stylesheet">
  <!-- FontAwesome -->
    <link href="content/font-awesome.min.css" rel="stylesheet" type="text/css">
  <!-- Custom CSS -->
    <link href="content/admin.css" rel="stylesheet">
   
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
        body {
    background-color: #eee;
    padding-bottom: 40px;
    padding-top: 40px;
}
        #LoginControl{
            margin-bottom:20px;
            width:100%;
        }

    </style>
</head>

<body>
    <div class="container">
    <form class="form-signin" id="form1" runat="server">

    <div>
        <h2 class="form-signin-heading">Sign in</h2>
        <asp:login ID="LoginControl" runat="server" OnAuthenticate="LoginControl_Authenticate" TitleText="" Width="100%" FailureText="Invalid username or password" FailureTextStyle-ForeColor="#A94442">
            <LabelStyle CssClass="sr-only" />
            <LoginButtonStyle CssClass="btn btn-lg btn-primary btn-block" />
            <TextBoxStyle CssClass="form-control" />
        </asp:login>
        <asp:ValidationSummary ID="ValidationSummary" runat="server" ValidationGroup="LoginControl" CssClass="alert alert-danger"/>
    </div>
    </form>
        </div>
</body>
</html>
