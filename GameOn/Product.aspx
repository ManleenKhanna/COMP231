<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="Footworks.Product" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Slider" runat="server">
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Products" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="product-page-info">
        <div class="labout span_1_of_a1">
            <asp:Image ID="ImageProductDisplay" runat="server" class="grid_img cust_img" Height="400" Width="390" />
        </div>
        <div class="cont1 span_2_of_a1">
        <h3 class="m_3">
    <asp:Label ID="LabelProductName" runat="server" Text="ProductName"></asp:Label>
            </h3><div class="price_single">
<span class="actual">
    <asp:Label ID="LabelProductPrice" runat="server" Text="ProductPrice"></asp:Label></span></div>
    <h4 class="m_9"><asp:Label ID="LabelSelectColour" runat="server" Text="Select Colour"></asp:Label></h4>
    <asp:DropDownList ID="DropDownListColours" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownListColours_SelectedIndexChanged"></asp:DropDownList>
    <h4 class="m_9"><asp:Label ID="LabelSelectSize" runat="server" Text="Select Size"></asp:Label>
   </h4> <asp:DropDownList ID="DropDownListSizes" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownListSizes_SelectedIndexChanged"></asp:DropDownList>
    <h4 class="m_9"><asp:Label ID="LabelQuantity" runat="server" Text="Quantity"></asp:Label></h4>
            
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:TextBox ID="TextBoxQuantity" runat="server" OnTextChanged="TextBoxQuantity_TextChanged" Text="1" AutoPostBack="True"></asp:TextBox>
            <ajaxToolkit:FilteredTextBoxExtender runat="server" BehaviorID="TextBoxQuantity_FilteredTextBoxExtender" TargetControlID="TextBoxQuantity" ID="TextBoxQuantity_FilteredTextBoxExtender" FilterType="Numbers"></ajaxToolkit:FilteredTextBoxExtender>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="TextBoxQuantity" />
        </Triggers>
    </asp:UpdatePanel>

    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:Button ID="ButtonSubmit" runat="server" Text="Add to cart" OnClick="ButtonSubmit_Click" class="btn_1"/>
            <asp:Label ID="LabelError" runat="server" Text="Label" ></asp:Label>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="DropDownListColours" />
            <asp:AsyncPostBackTrigger ControlID="DropDownListSizes" />
        </Triggers>
    </asp:UpdatePanel>
</div>

    <asp:Table ID="TableProductDescription" runat="server" class="table">
    </asp:Table>
        </div>
</asp:Content>