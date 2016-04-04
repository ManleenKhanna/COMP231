<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Footworks.Login" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Slider" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Products" runat="server">
    <div class="">
    <div class="container-fluid">
    <div>
        <h2 class="form-signin-heading">Sign in</h2>
        <asp:login ID="LoginControl" runat="server" OnAuthenticate="LoginControl_Authenticate" TitleText="" Width="100%" FailureText="Invalid username or password" FailureTextStyle-ForeColor="#A94442">
            <LabelStyle CssClass="sr-only" />
            <LoginButtonStyle CssClass="btn btn-lg btn-primary btn-block" />
            <TextBoxStyle CssClass="form-control" />
        </asp:login>
        <asp:ValidationSummary ID="ValidationSummary" runat="server" ValidationGroup="LoginControl" CssClass="alert alert-danger"/>
    </div>
    </div>
        </div>
</asp:Content>
